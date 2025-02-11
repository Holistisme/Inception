# # Nom de l'image et du conteneur
# NAME = mariadb-container
# IMAGE = mariadb-test

# # Dossier contenant le Dockerfile
# DOCKER_DIR = srcs/requirements/mariadb

# # Variables pour le build
# DOCKER = docker

# # Commandes principales
# all: build run

# # Build de l'image Docker
# build:
# 	@$(DOCKER) build -t $(IMAGE) $(DOCKER_DIR)

# # Lancement du conteneur MariaDB avec le port exposé
# run:
# 	@$(DOCKER) run -d --name $(NAME) \
# 		-p 3306:3306 \
# 		--env-file srcs/.env \
# 		-v mariadb_data:/var/lib/mysql \
# 		$(IMAGE)

# # Affiche les logs du conteneur
# logs:
# 	@$(DOCKER) logs -f $(NAME)

# # Nettoyage des conteneurs et images
# clean:
# 	@$(DOCKER) stop $(NAME) || true
# 	@$(DOCKER) rm -f $(NAME) || true

# fclean: clean
# 	@$(DOCKER) rmi -f $(IMAGE) || true
# 	@$(DOCKER) volume rm mariadb_data || true
# 	@$(DOCKER) system prune -f --volumes

# # Rebuild complet
# re: fclean all

# Nom de l'image et du conteneur
NAME = nginx-container
IMAGE = nginx-test

# Dossier contenant le Dockerfile
DOCKER_DIR = srcs/requirements/nginx

# Variables pour le build
DOCKER_COMPOSE = docker-compose -f docker-compose.yml
DOCKER = docker

# Commandes principales
all: build run

# Build de l'image Docker
build:
	@$(DOCKER) build -t $(IMAGE) $(DOCKER_DIR)

# Lancement du conteneur Nginx avec les ports exposés
run:
	@$(DOCKER) run -d --name $(NAME) -p 443:443 -p 80:80 --env-file srcs/.env $(IMAGE)

# Affiche les logs du conteneur
logs:
	@$(DOCKER) logs -f $(NAME)

# Nettoyage des conteneurs et images
clean:
	@$(DOCKER) stop $(NAME) || true
	@$(DOCKER) rm -f $(NAME) || true

fclean: clean
	@$(DOCKER) rmi -f $(IMAGE) || true
	@$(DOCKER) system prune -f --volumes

# Rebuild complet
re: fclean all