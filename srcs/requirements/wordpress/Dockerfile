# The source image for the WORDPRESS service: recovers the second-to-last DEBIAN version (at the time the project was created):
FROM debian:bullseye

# A label to source the author of the Dockerfile:
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# Update & install necessary dependencies:
RUN apt-get update && apt-get install -y lsb-release apt-transport-https ca-certificates gnupg2 wget curl \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list \
    && wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - \
    && apt-get update \
    && apt-get install -y php8.2 php8.2-fpm php8.2-mysql php8.2-curl php8.2-mbstring php8.2-xml php8.2-gd php8.2-zip \
    && dpkg -l | grep php \
    && ls -l /usr/sbin/php-fpm* \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/php \
    && sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

# Download and install WP-CLI:
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp --info --allow-root

# Copies the initialization script into the container and makes it executable:
COPY tools/install_wp.sh /usr/local/bin/install_wp.sh
RUN chmod +x /usr/local/bin/install_wp.sh

# Defines the working folder:
WORKDIR /var/www/html

# Exposes the port used by PHP-FPM:
EXPOSE 9000

# Default command to start WordPress properly):
ENTRYPOINT ["/usr/local/bin/install_wp.sh"]