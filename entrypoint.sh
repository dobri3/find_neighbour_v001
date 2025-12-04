#!/bin/bash
set -e

# Генерируем config.json из переменных окружения
cat >/app/build/web/assets/config.json <<EOF
{
  "baseUrl": "${BASE_URL:-http://localhost:8080/api/v1}",
  "wsBaseUrl": "${WS_BASE_URL:-ws://localhost:8080/api/v1}",
  "origin": "${ORIGIN:-http://localhost:8888}",
  "apiKey": "${API_KEY:-}",
  "environment": "${ENVIRONMENT:-production}"
}
EOF

# Запускаем HTTP сервер
exec python3 -m http.server 8888 --directory /app/build/web
