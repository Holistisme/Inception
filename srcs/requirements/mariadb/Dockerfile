# The source image for the MARIADB service: recovers the second-to-last DEBIAN version (at the time the project was created):
FROM debian:bullseye

# A label to source the author of the Dockerfile:
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# Updating and installing MariaDB:
RUN apt-get update && apt-get install -y mariadb-server mariadb-client gosu && rm -rf /var/lib/apt/lists/*

# Copies the MariaDB configuration file:
COPY conf/my.cnf /etc/mysql/my.cnf

# Copies the initialization script into the container and makes it executable:
COPY tools/setup.sh /docker-entrypoint-initdb.d/setup.sh
RUN chmod +x /docker-entrypoint-initdb.d/setup.sh

# Copie un script d'initialisation pour la gestion des permissions
COPY tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# Exposes MySQL port:
EXPOSE 3306

# Default command (ensures MariaDB starts properly):
CMD ["/usr/local/bin/init.sh"]