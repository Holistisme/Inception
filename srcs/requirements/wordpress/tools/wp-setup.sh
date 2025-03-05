#!/bin/bash
set -euo pipefail

###############################################################################
# wp-setup.sh
#  - Manages WordPress installation and configuration.
#  - Installs WP if not present, generates wp-config.php, and sets up Redis.
#  - Launches PHP-FPM at the end.
###############################################################################

WP_PATH=${WP_PATH:-/var/www/html/wordpress}

echo "Checking WordPress installation at ${WP_PATH}..."

if [ ! -d "$WP_PATH" ]; then
    echo "Downloading WordPress to ${WP_PATH}..."
    wp core download --path="$WP_PATH" --allow-root
fi

cd "$WP_PATH"

if [ -f wp-config.php ] && wp config has DB_PASSWORD --allow-root; then
    echo "wp-config.php found, no modification required."
else
    echo "Generating wp-config.php..."
    cp wp-config-sample.php wp-config.php

    wp config set --allow-root DB_HOST "$DB_HOST"
    wp config set --allow-root DB_NAME "$DB_DATABASE"
    wp config set --allow-root DB_USER "$DB_USER"
    wp config set --allow-root DB_PASSWORD "$DB_USER_PASSWORD" --quiet
    wp config set --allow-root table_prefix "wp_"
    wp config set --allow-root WP_DEBUG false --raw
    wp config set --allow-root WP_DEBUG_LOG false --raw
    wp config shuffle-salts --allow-root

    echo "wp-config.php generated successfully."

    echo "Installing WordPress..."
    wp core install --allow-root              \
        --url="$DOMAIN"                       \
        --title="$WP_TITLE"                   \
        --admin_user="$WP_ADMIN"              \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    echo "Updating plugins..."
    wp plugin update --allow-root --all

    echo "Creating a secondary user..."
    wp user create --allow-root "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" --role=author --porcelain
fi

echo "Fixing file permissions..."
chown -R www-data:www-data "$WP_PATH"
chmod -R 755 "$WP_PATH"

echo "Configuring Redis in wp-config.php..."
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root --raw
wp config set WP_REDIS_PASSWORD "$REDIS_PASSWORD" --allow-root
wp config set WP_REDIS_DATABASE 0 --allow-root --raw
wp config set WP_REDIS_CLIENT phpredis --allow-root
wp config set WP_CACHE true --allow-root --raw

echo "Installing and enabling Redis Cache plugin..."
wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root
wp redis enable --allow-root

echo "Starting PHP-FPM 8.2..."
exec php-fpm8.2 -F