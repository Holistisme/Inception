###############################################################################
# Dockerfile for WordPress service (Debian Bullseye + PHP 8.2)
###############################################################################
FROM debian:bullseye

LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# Set up a working directory for the container
WORKDIR /app

###############################################################################
# Install necessary packages:
#  - PHP 8.2, extensions (MySQL, Redis), MariaDB client
#  - WP-CLI (WordPress Command Line Interface)
#  - Minimal tooling (curl, vim, unzip, etc.)
###############################################################################
RUN apt-get update -y && apt-get install -y                                                                          \
    lsb-release apt-transport-https ca-certificates curl                                                             \
    && curl -fsSL https://packages.sury.org/php/apt.gpg | tee /etc/apt/trusted.gpg.d/sury-php.gpg > /dev/null        \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list \
    && apt-get update -y && apt-get install -y                                                                       \
    lsb-release apt-transport-https ca-certificates curl unzip vim                                                   \
    php8.2 php8.2-fpm php8.2-mysql php8.2-redis mariadb-client                                                       \
    && mkdir -p /run/php                                                                                             \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar                             \
    && chmod +x wp-cli.phar                                                                                          \
    && mv wp-cli.phar /usr/local/bin/wp                                                                              \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

###############################################################################
# Copy custom configuration for the setup script and PHP-FPM
###############################################################################
COPY              ./conf/www.conf    /etc/php/8.2/fpm/pool.d/www.conf
COPY --chmod=0755 /tools/wp-setup.sh /usr/local/bin/wp-setup.sh

# Expose the default PHP-FPM port
EXPOSE 9000

# Define the entrypoint script to be executed at container startup
ENTRYPOINT ["/usr/local/bin/wp-setup.sh"]