#!/bin/bash
echo "Inicializando GhostKey..."
command -v docker >/dev/null 2>&1 || { echo "Docker no instalado"; exit 1; }
if [ ! -f backend/docker/.env ]; then
  cp backend/docker/.env.example backend/docker/.env
  echo ".env creado. Edita con tus secretos."
fi
echo "Listo. Ejecuta: cd backend/docker && docker compose up -d"
