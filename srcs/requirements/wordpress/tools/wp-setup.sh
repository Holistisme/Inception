#!/bin/bash

set -e

echo "🛠 Checking WordPress installation..."

if ! [ -d "$WP_PATH" ]; then
    echo "📥 Downloading WordPress in $WP_PATH..."
    wp core download --path="$WP_PATH" --allow-root
fi

cd "$WP_PATH"

if [ -f wp-config.php ] && wp config has DB_PASSWORD --allow-root; then
    echo "✅ wp-config.php found, no modification required."
else
    echo "⚙️ Generating wp-config.php..."
    cp wp-config-sample.php wp-config.php

    wp config set --allow-root DB_HOST "$DB_HOST"
    wp config set --allow-root DB_NAME "$DB_DATABASE"
    wp config set --allow-root DB_USER "$DB_USER"
    wp config set --allow-root DB_PASSWORD "$DB_USER_PASSWORD" --quiet
    wp config set --allow-root table_prefix "wp_"
    wp config set --allow-root WP_DEBUG false --raw
    wp config set --allow-root WP_DEBUG_LOG false --raw
    wp config shuffle-salts --allow-root

    echo "✅ wp-config.php generated successfully."

    echo "🚀 Installing WordPress..."
    wp core install --allow-root \
        --url="$DOMAIN" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    echo "🔌 Updating plugins..."
    wp plugin update --allow-root --all

    echo "👤 Creating a secondary user..."
    wp user create --allow-root "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" --role=author --porcelain
fi

echo "🚀 Starting PHP-FPM 8.2..."
exec php-fpm8.2 -F