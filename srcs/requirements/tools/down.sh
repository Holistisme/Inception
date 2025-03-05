#!/bin/bash
# -----------------------------------------------------------------------------
# Stops and removes containers, networks, etc. defined in a specified
# docker-compose file.
# Usage: down.sh <docker-compose.yml>
# -----------------------------------------------------------------------------
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <docker-compose.yml>"
  exit 1
fi

DOCKER_COMPOSE=$1

echo "Bringing down services using $DOCKER_COMPOSE..."
docker compose -f "$DOCKER_COMPOSE" down