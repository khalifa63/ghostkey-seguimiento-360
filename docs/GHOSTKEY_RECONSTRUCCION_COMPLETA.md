# GhostKey - Documentacion Completa de Reconstruccion
## Tracker Vehicular Encubierto 4G + GNSS
**Version:** 1.0 | **Fecha:** 10 septiembre 2026 | **Firmware:** v8_cid_cleanup (1.09MB/83%)

---

## 1. Resumen Ejecutivo

GhostKey: rastreador vehicular encubierto, bajo consumo (~8mA deep sleep), ESP32-S3 + A7670SA + MPU6050. Reporta a Traccar via HTTP OsmAnd por Cloudflare Tunnel. Comandos remotos por HTTP polling. Autonomia 6-12 meses LiPo 1S.

## 2. Arquitectura

    ESP32-S3 <--UART(115200)--> A7670SA --4G--> Cloudflare Tunnel
       |                            |               |
       +--I2C(100kHz)--> MPU6050    |         +-----+-----+
       |                            |         |     |     |
       +--GPIO--> Boton/LED         |      Traccar NR  MQTT
       +--ADC--> Divisor VBAT       |
       +--WiFi AP (config)          |

Hosts: app.seguimiento360.com (NR), gps.seguimiento360.com (Traccar), cmd.seguimiento360.com (API)

## 3. Bill of Materials

| # | Componente | Modelo | Qty |
|---|---|---|---|
| 1 | MCU | ESP32-S3 SuperMini | 1 |
| 2 | Modem 4G+GNSS | SIMCom A7670SA | 1 |
| 3 | Acelerometro | MPU6050 GY-521 | 1 |
| 4 | Antena 4G | IPEX->SMA | 1 |
| 5 | Antena GNSS | IPEX->ceramica | 1 |
| 6 | SIM | Nano SIM datos | 1 |
| 7 | Bateria | LiPo 1S 1000-2000mAh | 1 |
| 8 | LDO/Boost | MCP1700-3.3 o MT3608 | 1 |
| 9 | Divisor VBAT | 2x 10k 1% | 1 |
| 10 | Boton | Push 6x6mm | 1 |
| 11 | Capacitor | 100uF/10V + 100nF | 1 |

Consumo: deep sleep ~8mA, activo 180-250mA, pico TX ~2A (<100ms)

## 4. Diagrama de Conexiones

| Funcion | GPIO ESP32-S3 | Pin modulo | Nota |
|---|---|---|---|
| UART Modem RX | GPIO6 | A7670 TX | 115200 |
| UART Modem TX | GPIO7 | A7670 RX | 115200 |
| PWRKEY | GPIO11 | A7670 PWRKEY | Pulso 1.1s |
| DTR (SLEEP) | GPIO5 | A7670 DTR | LOW=on HIGH=sleep |
| I2C SDA | GPIO8 | MPU SDA | 100kHz |
| I2C SCL | GPIO9 | MPU SCL | 100kHz |
| MPU INT | GPIO10 | MPU INT | Wake ext0 RISING |
| VBAT ADC | GPIO2 | Divisor 10k+10k | ADC1_CH2 11dB |
| Boton | GPIO4 | Push a GND | Wake ext1 |
| LED WS2812 | GPIO48 | Onboard | rgbLedWrite |

Esquematico divisor VBAT:

    LiPo+ ---[10k]---+---[10k]--- GND
                      |
                      +---> GPIO2 (VBAT = Vpin x 2.0)

Alimentacion:

    ESP32 3V3 ---> MPU VCC, Pull-ups I2C
    ESP32 GND --- comun con A7670, MPU, LiPo
    LiPo+ -------> A7670 VCC (3.8-4.2V directo) + 100uF bulk
    LiPo+ -------> MCP1700 IN -> 3.3V out -> ESP32 VIN
    MPU AD0 -----> GND (direccion 0x68)

Precauciones: A7670SA necesita 3.8-4.2V estable, picos 2A. Capacitor 100uF obligatorio cerca de VCC. GND comun obligatorio.

## 5. Maquina de Estados

    APARCADO (deep sleep ~8mA)
      |-- movimiento (MPU INT) --> ACTIVA (modem ON, GNSS, reporte 30s)
      |                              |-- quieto >= cooldown_s --> COOLDOWN --> APARCADO
      |-- timer heartbeat_h ------> HEARTBEAT (1 fix + reporte + httpCheckIn) --> APARCADO
      |-- boton 3s ----------------> Portal WiFi o sale de bodega
      |-- boton 6s ----------------> BODEGA (solo boton despierta)

## 6. Configuracion NVS

Namespace: "ghostkey". Claves limitadas a 15 chars (nvsAlias traduce).

| Clave | Default | Rango | Descripcion |
|---|---|---|---|
| mot_thr | 15 | 1-255 | Umbral movimiento MPU |
| mot_dur | 20 | 1-255 | Duracion movimiento (x32ms) |
| report_interval_s | 30 | >=1 | Intervalo reporte |
| cooldown_s | 120 | >=1 | Tiempo quieto antes de aparcar |
| heartbeat_h | 24 | >=1 | Heartbeat periodico (horas) |
| batt_alarm_pct | 25 | 0-100 | Alarma bateria baja |
| ap_pass | generado | 10 digitos | Contrasena AP WiFi unica |
| mqtt_pass | generado | 10 digitos | Contrasena MQTT unica |

## 7. Seguridad

- AP WiFi: WPA2-PSK, contrasena unica por dispositivo (esp_random, 10 digitos)
- MQTT: usuario=IMEI, password unica. ACL aisle cada dispositivo
- IMEI/MAC: nunca expuestos. Identidad publica = codigo caja GT-XXXXXX-C
- Backend: secrets en .env, credentialSecret Node-RED, Cloudflare Tunnel

## 8. Comandos de Consola

| Comando | Descripcion |
|---|---|
| !HELP | Ayuda |
| !RUN / !PARK | Ciclo campo |
| !STOP | Sale del ciclo |
| !BENCH | Alterna sleep simulado/real |
| !BATT | Mide bateria |
| !REG | Estado LTE |
| !SIG | Calidad senal dBm |
| !FIX | Fuerza fix GNSS |
| !INFO | IMEI, IMSI, FW |
| !UPTIME | Uptime + contadores |
| !STATE | Estado completo |
| !MPU | Acelerometro X,Y,Z |
| !REPORT | 1 reporte a Traccar |
| !THR/DUR/RPT/CD/HB/BALM | Set parametros NVS |
| !WIFI ON/OFF | Portal WiFi |
| !WIFIPASS / !MQTTPASS | Muestra contrasenas (solo USB) |
| !MQTT | Check-in MQTT manual |
| !HTTPCMD | Check-in HTTP manual |
| !BODEGA | Modo bodega |
| !REBOOT | Reinicio completo |
| texto sin ! | Envia como AT raw |

## 9. Integracion Traccar

Protocolo OsmAnd HTTP GET:

    http://gps.seguimiento360.com/?id={IMEI}&lat={lat}&lon={lon}&batt={%}&timestamp={unix}&speed={kn}&alarm=lowBattery

- speed en nudos (km/h / 1.852)
- alarm=lowBattery solo si batt <= batt_alarm_pct
- timestamp UNIX calculado desde fecha/hora UTC GNSS

## 10. Infraestructura Docker

Servicios: postgresql, traccar, influxdb, mosquitto, nodered, cloudflared
.env obligatorio: INFLUXDB_INIT_PASSWORD, INFLUXDB_INIT_ADMIN_TOKEN, CLOUDFLARE_TUNNEL_TOKEN, NODE_RED_CREDENTIAL_SECRET

## 11. Node-RED

11 tabs: Registro, Login, Vincular, Generar Codigos, Mis Dispositivos, Config, Renombrar, Eliminar, Actualizar Usuario, Deshabilitar, Comandos Pendientes.

Endpoints firmware:

    GET  /api/devices/imei/{IMEI}/pending-cmd
    POST /api/devices/imei/{IMEI}/pending-cmd/ack

Comandos: reboot, bodega, set_wifi_pass, set (key/value), batch (sets)

## 12. Flasheo

1. Arduino IDE 2.x, board esp32 by Espressif
2. Board: ESP32S3 Dev Module, USB CDC On Boot: Enabled
3. Partition: Huge APP (3MB No OTA/1MB SPIFFS)
4. Libs: AsyncTCP, ESPAsyncWebServer
5. Compilar (~1.09MB/83%), subir
6. Primer arranque: anotar ap_pass y mqtt_pass
7. Registrar en Mosquitto: docker exec mosquitto mosquitto_passwd -b /mosquitto/config/passwd {IMEI} "{mqtt_pass}"

## 13. Troubleshooting

- Modem mudo: verificar 3.8-4.2V, GND comun, pulso PWRKEY 1.1s
- Sin LTE: SIM sin PIN, APN automatico, AT+COPS=?
- Sin fix GNSS: antena con vista al cielo, cold start 30-90s
- Consumo alto: DTR HIGH, WiFi OFF, medir con multimetro
- HTTP 302: usar host dedicado gps.seguimiento360.com
- MQTT no conecta: CF Tunnel free no soporta TCP raw, usar HTTP polling
- NVS corrupto: borrar con Preferences clear + esp_restart

## 14. Codigo Fuente del Firmware

Ver archivo: firmware/ghostkey_wifi_console_v8_cid_cleanup.ino

Funciones principales:

- initHW(), setup(), loop()
- parkAndSleep(), runSession(), heartbeatSession(), activeSession()
- ensureModem(), wakeModemFromSleep(), readIMEI()
- gpsOn/Off(), getFix(), reportPosition()
- httpCheckIn(), httpAckCmd(), mqttCheckIn(), mqttExecCommand()
- mpuInit(), mpuArmMotion(), mpuReadAccel()
- startWifiAP(), stopWifiAP(), onWsEvent()
- cfgSetKey(), cfgLoadAll(), nvsAlias()
- enterBodega(), doReboot(), checkButton()
- showBatt(), showReg(), showSig(), showInfo(), showUptime()
- handleLine(), printHelp()
- ConsolePrint (clase espejo Serial+WebSocket)
