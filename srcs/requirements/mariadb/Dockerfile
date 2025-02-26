# 📌 Base image: Debian Bullseye
FROM debian:bullseye

# 🏷️ Maintainer Information
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# 🔧 One-step installation of the necessary packages
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client gosu && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# 📂 Directory configuration and permissions
RUN mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql && \
    chmod 755 /run/mysqld

# 📜 Copy MariaDB configuration
COPY conf/my.cnf /etc/mysql/my.cnf

# 📜 Copy and authorize initialization scripts
COPY tools/setup.sh /docker-entrypoint-initdb.d/setup.sh
COPY tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /docker-entrypoint-initdb.d/setup.sh /usr/local/bin/init.sh

# 🚪 Expose MariaDB port
EXPOSE 3306

# 🚀 Input command
ENTRYPOINT [ "/usr/local/bin/init.sh" ]