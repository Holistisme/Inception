###############################################################################
# Makefile for managing Docker-based services (Inception project)
###############################################################################

# Primary target name
NAME			:= inception

# Paths to essential files and directories
DOCKER_COMPOSE	:= ./srcs/docker-compose.yml
ENV_FILE		:= ./srcs/.env
TOOLS_DIR       := ./srcs/requirements/tools
VOLUMES_DIR     := /home/aheitz/data

###############################################################################
# Default target: builds the project (containers) by running `make build`
###############################################################################
all: build

###############################################################################
# build
#  - Invokes the setup script to prepare volumes.
#  - Then calls the build script to build and launch containers.
###############################################################################
build: setup
	$(TOOLS_DIR)/build.sh $(DOCKER_COMPOSE) $(ENV_FILE)

###############################################################################
# setup
#  - Calls the script that creates necessary directories for volumes,
#    setting ownership and permissions.
###############################################################################
setup:
	$(TOOLS_DIR)/setup.sh $(VOLUMES_DIR)

###############################################################################
# start
#  - Starts already built containers (without rebuilding).
###############################################################################
start:
	$(TOOLS_DIR)/start.sh $(DOCKER_COMPOSE)

###############################################################################
# stop
#  - Stops the running containers, but does not remove them.
###############################################################################
stop:
	$(TOOLS_DIR)/stop.sh $(DOCKER_COMPOSE)

###############################################################################
# down
#  - Stops and removes the containers, along with associated network.
###############################################################################
down:
	$(TOOLS_DIR)/down.sh $(DOCKER_COMPOSE)

###############################################################################
# clean
#  - First stops containers, then removes them (similar to `down`).
###############################################################################
clean: stop
	$(TOOLS_DIR)/down.sh $(DOCKER_COMPOSE)

###############################################################################
# prune
#  - Performs a deeper cleanup by removing containers, networks, volumes,
#    and orphaned resources. Also removes the volumes directory if specified.
###############################################################################
prune:
	$(TOOLS_DIR)/prune.sh $(DOCKER_COMPOSE) $(VOLUMES_DIR)

###############################################################################
# re
#  - Shorthand target that prunes everything and then rebuilds.
###############################################################################
re: prune all

###############################################################################
# images
#  - Displays all Docker images (by ID).
###############################################################################
images:
	@docker images -qa

###############################################################################
# network
#  - Lists all Docker networks.
###############################################################################
network:
	@docker network ls

###############################################################################
# volume
#  - Lists all Docker volumes.
###############################################################################
volume:
	@docker volume ls

###############################################################################
# help
#  - Prints a summary of available commands.
###############################################################################
help:
	@echo "Available commands:"
	@echo "  make build    → Build and start the containers"
	@echo "  make setup    → Setup volumes and directories"
	@echo "  make start    → Start existing containers"
	@echo "  make stop     → Stop running containers"
	@echo "  make down     → Stop and remove containers"
	@echo "  make clean    → Remove stopped containers"
	@echo "  make prune    → Deep cleanup (system prune)"
	@echo "  make re       → Rebuild everything"
	@echo "  make images   → List Docker images"
	@echo "  make network  → List Docker networks"
	@echo "  make volume   → List Docker volumes"

###############################################################################
# Phony targets ensure that 'make' does not look for files named after the target
###############################################################################
.PHONY: all build setup start stop down clean prune re images network volume help