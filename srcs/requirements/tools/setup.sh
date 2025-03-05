#!/bin/bash
# -----------------------------------------------------------------------------
# Creates a directory structure for Docker volumes and sets appropriate
# ownership and permissions.
# Usage: setup.sh <volumes_directory>
# -----------------------------------------------------------------------------
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <volumes_directory>"
  exit 1
fi

VOLUMES_DIR=$1

echo "Creating volumes directories at $VOLUMES_DIR..."
sudo mkdir -p "$VOLUMES_DIR"/{mariadb,wordpress,redis,ricounter}
sudo chown -R "$(whoami):$(whoami)" "$VOLUMES_DIR"
sudo chmod -R 755 "$VOLUMES_DIR"