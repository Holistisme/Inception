#!/bin/bash
# -----------------------------------------------------------------------------
# Starts existing containers (previously created) defined in a docker-compose file.
# Usage: start.sh <docker-compose.yml>
# -----------------------------------------------------------------------------
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <docker-compose.yml>"
  exit 1
fi

DOCKER_COMPOSE=$1

echo "Starting services defined in $DOCKER_COMPOSE..."
docker compose -f "$DOCKER_COMPOSE" start