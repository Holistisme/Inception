# 📌 Base image: Debian Bullseye
FROM debian:bullseye

# 🏷️ Maintainer Information
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# Installation of PHP and its extensions
RUN apt-get update && apt-get install -y                                                     \
    php php-fpm php-mysql php-cli php-json php-mbstring php-xml php-curl php-gd php-zip curl \
    && rm -rf /var/lib/apt/lists/*

# Download and install Adminer
RUN mkdir -p /var/www/html && cd /var/www/html \
    && curl -o index.php -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

# Start the PHP adminer server
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]