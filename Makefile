# 🏗️ Inception - Makefile

NAME            := inception
DOCKER_COMPOSE  := ./srcs/docker-compose.yml
ENV_FILE        := ./srcs/.env
VOLUMES_DIR     := /home/aheitz/data
TOOLS_DIR       := ./srcs/requirements/tools

all: build

build:
	@echo "🔨 Building and starting Inception..."
	$(TOOLS_DIR)/build.sh $(DOCKER_COMPOSE) $(ENV_FILE)

start:
	@echo "▶️ Starting services..."
	$(TOOLS_DIR)/start.sh $(DOCKER_COMPOSE)

stop:
	@echo "⏹️ Stopping services..."
	$(TOOLS_DIR)/stop.sh $(DOCKER_COMPOSE)

down:
	@echo "🔽 Stopping and removing containers..."
	$(TOOLS_DIR)/down.sh $(DOCKER_COMPOSE)

re: fclean all

clean: stop
	@echo "🧹 Cleaning stopped containers..."
	$(TOOLS_DIR)/clean.sh $(DOCKER_COMPOSE)

fclean: clean
	@echo "🚮 Removing all containers, volumes, and networks..."
	$(TOOLS_DIR)/fclean.sh $(DOCKER_COMPOSE)

prune:
	@echo "🧼 Performing deep cleanup..."
	$(TOOLS_DIR)/prune.sh $(DOCKER_COMPOSE) $(VOLUMES_DIR)

# 🖥️ Docker Utilities
## 🖼️ Show all images
images:
	@docker images -qa

## 🌐 Show active Docker networks
network:
	@docker network ls

## 💾 Show all Docker volumes
volume:
	@docker volume ls

## 📜 Live logs from Nginx container
logs:
	$(TOOLS_DIR)/logs.sh $(DOCKER_COMPOSE)

setup:
	@echo "🏗️ Setting up volumes and directories..."
	$(TOOLS_DIR)/setup.sh $(VOLUMES_DIR)

help:
	@echo "📖 Available commands:"
	@echo "  make build    → Build and start the containers"
	@echo "  make start    → Start existing containers"
	@echo "  make stop     → Stop running containers"
	@echo "  make down     → Stop and remove containers"
	@echo "  make re       → Rebuild everything"
	@echo "  make clean    → Remove stopped containers"
	@echo "  make fclean   → Full cleanup (containers, volumes, networks)"
	@echo "  make prune    → Deep cleanup (system prune)"
	@echo "  make images   → List Docker images"
	@echo "  make network  → List Docker networks"
	@echo "  make volume   → List Docker volumes"
	@echo "  make logs     → Show live logs from Nginx"
	@echo "  make setup    → Setup volumes and directories"

.PHONY: all build start stop down re clean fclean prune images network volume logs setup help