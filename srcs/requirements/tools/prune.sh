#!/bin/bash
DOCKER_COMPOSE=$1
VOLUMES_DIR=$2

docker compose -f "$DOCKER_COMPOSE" down --volumes --remove-orphans
docker volume prune -f
docker system prune -af --volumes
sudo rm -rf "$VOLUMES_DIR"
sudo mkdir -p "$VOLUMES_DIR"/mariadb "$VOLUMES_DIR"/wordpress "$VOLUMES_DIR"/database "$VOLUMES_DIR"/redis "$VOLUMES_DIR"/rickroll_counter
sudo chown -R $(whoami):$(whoami) "$VOLUMES_DIR"
sudo chmod -R 755 "$VOLUMES_DIR"