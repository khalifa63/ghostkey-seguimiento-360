# Flujos de Node-RED - GhostKey / Seguimiento 360

Este directorio contiene la lógica de backend del proyecto.

## Archivo principal
- `ghostkey_flows.json`: Exportación completa de los 11 tabs de Node-RED.

## Tabs incluidos (v2.2)
1. GhostKey - Registro (con compensación transaccional)
2. GhostKey - Login
3. GhostKey - Vincular Dispositivo
4. GhostKey - Generar Códigos (Admin)
5. GhostKey - Mis Dispositivos
6. GhostKey - Configuración Dispositivo
7. GhostKey - Renombrar Dispositivo
8. GhostKey - Eliminar Dispositivo
9. GhostKey - Actualizar Usuario
10. GhostKey - Deshabilitar Usuario
11. GhostKey - Comandos Pendientes (HTTP Polling)

## Cómo importar
1. Abre tu instancia de Node-RED.
2. Menú hamburguesa (☰) → **Importar**.
3. Pega el contenido de `ghostkey_flows.json`.
4. Verifica que el nodo de configuración `postgreSQLConfig` tenga la contraseña correcta de tu entorno.
5. Verifica las variables de entorno `TRACCAR_ADMIN_USER` y `TRACCAR_ADMIN_PASS`.
6. Haz clic en **Deploy**.
