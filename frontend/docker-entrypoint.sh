#!/bin/sh
set -eu

api_base_url="${REACT_APP_API_URL:-${RAILWAY_SERVICE_SERVER_URL:-http://localhost:8080}}"
api_base_url="${api_base_url%/}"

case "$api_base_url" in
  http://*|https://*) ;;
  *) api_base_url="https://$api_base_url" ;;
esac

cat > /app/build/env-config.js <<EOF
window.__ENV__ = {
  API_BASE_URL: "$api_base_url"
};
EOF

exec serve -s build -l "${PORT:-3000}"
