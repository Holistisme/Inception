#!/bin/bash
DOCKER_COMPOSE=$1

docker compose -f "$DOCKER_COMPOSE" down