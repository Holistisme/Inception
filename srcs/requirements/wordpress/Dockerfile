# The source image for the WORDPRESS service: recovers the second-to-last DEBIAN version (at the time the project was created):
FROM debian:bullseye

# A label to source the author of the Dockerfile:
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# Update & install necessary dependencies:
RUN apt-get update && apt-get install -y \
    php7.4 php7.4-fpm php7.4-mysql curl wget unzip tar \
    && rm -rf /var/lib/apt/lists/*

# Download and install WP-CLI:
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copies the initialization script into the container and makes it executable:
COPY tools/install_wp.sh /usr/local/bin/install_wp.sh
RUN chmod +x /usr/local/bin/install_wp.sh

# Defines the working folder:
WORKDIR /var/www/html

# Exposes the port used by PHP-FPM:
EXPOSE 9000

# Default command to start WordPress properly):
CMD ["/usr/local/bin/install_wp.sh"]