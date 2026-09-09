# Portafolio de Proyectos: Ecosistema IoT Integral

## Vision General

Ecosistema IoT integrado bajo stack comun:
- Servidor Central: Inteligencia local, sin dependencias en la nube
- Comunicacion: ESP-NOW (local) + 4G (remoto)
- Modularidad: Cada componente reemplazable e independiente
- Escalabilidad: De 1 sensor a cientos de dispositivos
- Autonomia: 100% autonomo, sin suscripciones

## Proyectos Componentes

### 1. GhostKey - Rastreador Vehicular Encubierto
Estado: Fase 1 Completa

- ESP32-S3 + A7670SA + MPU6050
- Deep sleep + wake por movimiento
- Reporte HTTP a Traccar
- Consumo reposo: ~8mA
- Autonomia: 6-12 meses

### 2. Hogar Conectado - Sistema IoT Modular
Estado: Fase 1 Especificacion

- Hub ESP32-S3 + red sensores ESP32-C3 (ESP-NOW)
- Web-View integrada
- Reglas IFTTT configurables
- Alarmas silenciosa/audible/hibrida

## Roadmap Integrado (18 Meses)

| Mes | GhostKey | Hogar Conectado | Integracion |
|---|---|---|---|
| 1-3 | Multi-dispositivo | Hub + PIR | - |
| 4-6 | OTA updates | Intrusion | WiFi local |
| 7-9 | Reportes inteligentes | Ambientales | Alertas cruzadas |
| 10-12 | Buffer offline | Perimetro | Multi-hub |
| 13-18 | PCB final | PCB nodos | Produccion |

Version: 1.0 | Fecha: Julio 15, 2026
