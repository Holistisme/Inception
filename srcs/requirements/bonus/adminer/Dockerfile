###############################################################################
# Dockerfile for Adminer (Debian Bullseye)
###############################################################################
FROM debian:bullseye

LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

###############################################################################
# Install PHP and extensions required by Adminer, plus curl for downloading
###############################################################################
RUN apt-get update && apt-get install -y                                                                \
    supervisor php php-fpm php-mysql php-cli php-json php-mbstring php-xml php-curl php-gd php-zip curl \
    && rm -rf /var/lib/apt/lists/*

###############################################################################
# Download Adminer (single PHP file) into /var/www/html
###############################################################################
RUN mkdir -p /var/www/html && cd /var/www/html                                                          \
    && curl -o index.php -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
    && chmod 644 index.php

###############################################################################
# Run supervisor on port 8080, serving files from /var/www/html
###############################################################################
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-n"]