#!/bin/bash
VOLUMES_DIR=$1

sudo mkdir -p "$VOLUMES_DIR"/mariadb "$VOLUMES_DIR"/wordpress "$VOLUMES_DIR"/redis "$VOLUMES_DIR"/rickroll_counter
sudo chown -R $(whoami):$(whoami) "$VOLUMES_DIR"
sudo chmod -R 755 "$VOLUMES_DIR"