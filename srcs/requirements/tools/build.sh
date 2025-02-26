#!/bin/bash
DOCKER_COMPOSE=$1
ENV_FILE=$2

docker compose -f "$DOCKER_COMPOSE" --env-file "$ENV_FILE" build --parallel
docker compose -f "$DOCKER_COMPOSE" --env-file "$ENV_FILE" up -d