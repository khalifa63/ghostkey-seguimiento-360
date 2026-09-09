# Sistema IoT Modular: Hogar Conectado

## Objetivo General

Ecosistema de seguridad, prevencion de riesgos y rastreo IoT 100% modular, autonomo y sin suscripciones.

## Arquitectura de Hardware

### Hub Central
- ESP32-S3 SuperMini
- Bateria LiPo + UPS
- 4G (A7670SA) futuro
- WiFi + ESP-NOW
- Web-View alojada

### Red de Sensores Fijos
- ESP32-C3 SuperMini
- Bateria litio pequena (1-5 anos autonomia)
- Sensor especifico modular
- Comunicacion ESP-NOW

### Nodos Moviles
- Basados en GhostKey (validado)
- Autonomos con 4G
- Se conectan al Hub en WiFi local

## Catalogo Modular de Sensores

A. Intrusion y Perimetro
- Apertura (contacto magnetico)
- Movimiento (PIR)
- Vibracion/Golpe
- Rotura de Cristal
- Barrera Laser/IR
- Sensores de Presion (Mat)

B. Ambientales y Prevencion
- Humo
- Llama/Calor
- Gas Combustible
- Monoxido de Carbono
- Fugas de Agua
- Sismicos

C. Rastreo y Movimiento
- Tracker Vehicular (GhostKey)
- Tracker Oculto

## Logica de Alarmas

1. Silenciosa - Notificacion push + grabacion
2. Audible/Visual - Sirena 120dB + luces estroboscopicas
3. Hibrida - Combinaciones configurables
4. Automatizaciones - IFTTT (sismo -> cortar gas, humo -> abrir puertas)

## Hoja de Ruta

- Fase 1 (T1): Hub + PIR + Web-View basica
- Fase 2 (T2): Sensores intrusion + logica alarmas
- Fase 3 (T3): Sensores ambientales
- Fase 4 (T4): Perimetro avanzado + sismico
- Fase 5 (Ano 2): PCB personalizado + produccion

Version: 1.0 | Fecha: Julio 15, 2026
