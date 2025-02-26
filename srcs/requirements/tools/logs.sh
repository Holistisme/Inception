#!/bin/bash
DOCKER_COMPOSE=$1

docker logs -t -f $(docker compose -f "$DOCKER_COMPOSE" ps -q nginx)