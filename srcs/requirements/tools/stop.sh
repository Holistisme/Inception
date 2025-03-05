#!/bin/bash
# -----------------------------------------------------------------------------
# Stops running containers defined in a docker-compose file without removing them.
# Usage: stop.sh <docker-compose.yml>
# -----------------------------------------------------------------------------
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <docker-compose.yml>"
  exit 1
fi

DOCKER_COMPOSE=$1

echo "Stopping services defined in $DOCKER_COMPOSE..."
docker compose -f "$DOCKER_COMPOSE" stop