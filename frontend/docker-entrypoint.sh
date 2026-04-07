#!/bin/sh
set -eu

node /app/scripts/generate-env-config.js

exec serve -s build -l "${PORT:-3000}"
