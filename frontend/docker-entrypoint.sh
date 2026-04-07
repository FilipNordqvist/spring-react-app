#!/bin/sh
set -eu

node ./scripts/generate-env-config.js || {
  echo "Failed to generate runtime env config"
  exit 1
}

exec serve -s build -l "${PORT:-3000}"
