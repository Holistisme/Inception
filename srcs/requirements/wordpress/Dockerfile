# 📌 Base image: Debian Bullseye
FROM debian:bullseye

# 🏷️ Maintainer Information
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# 📂 Set working directory
WORKDIR /app

# 🔧 Install required dependencies
# --------------------------------
# - `lsb-release`        : Helps manage package repositories dynamically.
# - `apt-transport-https`: Enables APT package fetching over HTTPS.
# - `ca-certificates`    : Ensures secure communication.
# - `curl`               : Needed for fetching external files (e.g., WP-CLI, PHP repo key).
# - `sury-php`           : Third-party repo for modern PHP versions (e.g., PHP 8.2).
RUN apt-get update -y && apt-get install -y                                                                          \
    lsb-release apt-transport-https ca-certificates curl                                                             \
    && curl -fsSL https://packages.sury.org/php/apt.gpg | tee /etc/apt/trusted.gpg.d/sury-php.gpg > /dev/null        \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list \
    && apt-get update -y

# 🏗️ Install PHP, PHP-FPM, MySQL client, and WP-CLI
# --------------------------------------------------
# - `php8.2`, `php8.2-fpm`: PHP 8.2 and FastCGI Process Manager (FPM).
# - `php8.2-mysql`        : MySQL extension for PHP to communicate with MariaDB.
# - `mariadb-client`      : Allows communication with MariaDB from the container.
# - `unzip`               : Needed for extracting certain WordPress files/plugins.
# - `wp-cli`              : WordPress Command Line Interface for easier automation.
RUN apt-get install -y php8.2 php8.2-fpm php8.2-mysql mariadb-client unzip               \
    && mkdir -p /run/php                                                                 \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar                                                              \
    && mv wp-cli.phar /usr/local/bin/wp

# 📝 Copy PHP-FPM pool configuration
# ----------------------------------
# This configuration optimizes PHP-FPM performance and security.
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# 🔧 Copy WordPress setup script and set permissions
# --------------------------------------------------
# This script automates the WordPress installation/configuration process.
COPY --chmod=0755 /tools/wp-setup.sh /usr/local/bin

# 📡 Expose port 9000 for PHP-FPM communication
EXPOSE 9000

# 🚀 Set entrypoint to the WordPress setup script
ENTRYPOINT ["/usr/local/bin/wp-setup.sh"]
