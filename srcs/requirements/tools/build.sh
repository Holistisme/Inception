#!/bin/bash
# -----------------------------------------------------------------------------
# Builds and starts Docker services using a specified docker-compose file and
# environment file.
# Usage: build.sh <docker-compose.yml> <.env>
# -----------------------------------------------------------------------------
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <docker-compose.yml> <.env>"
  exit 1
fi

DOCKER_COMPOSE=$1
ENV_FILE=$2

echo "Building services using $DOCKER_COMPOSE with env $ENV_FILE..."
docker compose -f "$DOCKER_COMPOSE" --env-file "$ENV_FILE" build --parallel

echo "Bringing up services..."
docker compose -f "$DOCKER_COMPOSE" --env-file "$ENV_FILE" up -d