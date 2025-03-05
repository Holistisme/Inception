#!/bin/bash
# -----------------------------------------------------------------------------
# Stops and removes containers, networks, and volumes, then prunes unused
# volumes and system objects. Also removes the specified volumes directory.
# Usage: prune.sh <docker-compose.yml> <volumes_directory>
# -----------------------------------------------------------------------------
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <docker-compose.yml> <volumes_directory>"
  exit 1
fi

DOCKER_COMPOSE=$1
VOLUMES_DIR=$2

echo "Bringing down services and cleaning volumes..."
docker compose -f "$DOCKER_COMPOSE" down --volumes --remove-orphans
docker volume prune -f
docker system prune -af --volumes

echo "Removing volumes directory at $VOLUMES_DIR..."
sudo rm -rf "$VOLUMES_DIR"