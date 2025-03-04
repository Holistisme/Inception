###############################################################################
# Dockerfile for MariaDB setup (Debian Bullseye)
###############################################################################
FROM debian:bullseye

LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# Install MariaDB server, client, and gosu (for privilege dropping)
RUN apt-get update && apt-get install -y --no-install-recommends \
    mariadb-server mariadb-client gosu && rm -rf /var/lib/apt/lists/* /tmp/*

# Create essential directories, set ownership and permissions
RUN mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql                \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql \
    && chmod 755 /run/mysqld

# Copy configuration and initialization scripts
COPY conf/my.cnf    /etc/mysql/my.cnf
COPY tools/setup.sh /docker-entrypoint-initdb.d/setup.sh
COPY tools/init.sh  /usr/local/bin/init.sh

# Ensure scripts are executable
RUN chmod +x /docker-entrypoint-initdb.d/setup.sh /usr/local/bin/init.sh

# Expose the default MariaDB port
EXPOSE 3306

# Use a custom entrypoint script to start MariaDB
ENTRYPOINT ["/usr/local/bin/init.sh"]