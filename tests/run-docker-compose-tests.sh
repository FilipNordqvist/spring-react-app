#!/bin/bash
# Run Docker Compose integration tests.
#
# Usage:
#   ./tests/run-docker-compose-tests.sh
#
# This script builds both services, runs the test-runner container,
# and tears everything down when done.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
COMPOSE_FILE="$PROJECT_DIR/docker-compose.test.yml"

cleanup() {
  echo ""
  echo "🧹 Cleaning up..."
  docker compose -f "$COMPOSE_FILE" down --volumes --remove-orphans 2>/dev/null || true
}
trap cleanup EXIT

echo "🔨 Building services..."
docker compose -f "$COMPOSE_FILE" build

echo ""
echo "🚀 Starting services and running tests..."
docker compose -f "$COMPOSE_FILE" run --rm test-runner
EXIT_CODE=$?

echo ""
if [ $EXIT_CODE -eq 0 ]; then
  echo "🎉 All Docker Compose tests passed!"
else
  echo "💥 Some Docker Compose tests failed (exit code: $EXIT_CODE)"
fi

exit $EXIT_CODE
