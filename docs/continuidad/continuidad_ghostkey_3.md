# Continuidad GhostKey - Sesion 3
## Decisiones de Arquitectura

### Decision 1: Nuevo Schema PostgreSQL
Schema ghostkey_v2 para multi-usuario/multi-dispositivo/multi-tipo.

### Decision 2: Codificacion de Dispositivos
Formato: [TIPO]-[RANDOM]-[CHECKSUM] (ej: GT-7F3A9B-2)

### Decision 3: Tabla device_types
Configuracion por defecto por tipo de dispositivo.

### Decision 4: Tabla claim_codes
Codigos de caja con estados: available -> claimed -> expired

### Decision 5: Provisioning de Firmware
Firmware detecta NVS vacio -> solicita codigo por serial

### Decision 6: Flujo de Registro en Portal
Usuario ingresa codigo caja + alias -> backend valida -> crea device

Version: 3.0 | Fecha: Julio 15, 2026
