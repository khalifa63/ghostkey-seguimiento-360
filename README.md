# GhostKey - Sistema de Seguimiento Vehicular 4G

![GhostKey](https://img.shields.io/badge/GhostKey-v8.0-blue)
![ESP32-S3](https://img.shields.io/badge/ESP32--S3-SuperMini-green)
![4G LTE](https://img.shields.io/badge/4G--LTE-A7670SA-orange)

**Tracker vehicular encubierto de bajo consumo con conectividad 4G y GNSS**

## Descripcion

GhostKey es un rastreador vehicular autonomo basado en ESP32-S3 + SIMCom A7670SA + MPU6050.
Deep sleep ~8mA, reporta posicion via HTTP a Traccar, comandos remotos por HTTP polling.

## Arquitectura

    ESP32-S3 <--UART--> A7670SA (4G+GNSS)
       |                     |
       +--I2C--> MPU6050     +--4G HTTP--> Cloudflare Tunnel
       |                                |
       +--WiFi AP (config)     +--------+--------+
                                |        |        |
                             Traccar  Node-RED  Mosquitto

## Hardware

| Componente | Modelo | Funcion |
|---|---|---|
| MCU | ESP32-S3 SuperMini | Cerebro, WiFi, NVS, ADC |
| Modem 4G+GNSS | SIMCom A7670SA | LTE Cat-1 + GPS/GLONASS |
| Acelerometro | MPU6050 (GY-521) | Deteccion movimiento + wake |
| Bateria | LiPo 1S 1000-2000mAh | Alimentacion |

## Inicio Rapido

1. Ver docs/GHOSTKEY_RECONSTRUCCION_COMPLETA.md
2. Flashear firmware/ghostkey_wifi_console_v8_cid_cleanup.ino
3. Desplegar backend: cd backend/docker && docker compose up -d

## Documentacion

- Reconstruccion Completa: docs/GHOSTKEY_RECONSTRUCCION_COMPLETA.md
- Continuidad Sesion 2: docs/continuidad/continuidad_ghostkey_2.md
- Continuidad Sesion 3: docs/continuidad/continuidad_ghostkey_3.md
- Portafolio IoT: docs/arquitectura/PORTAFOLIO_Proyectos_IoT_Integral.md
- Hogar Conectado: docs/arquitectura/IoT_Hogar_Conectado_Vision_Arquitectura.md

## Licencia

MIT - Ver LICENSE
