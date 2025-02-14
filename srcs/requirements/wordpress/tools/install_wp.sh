#!/bin/sh
set -e

echo "📁 Ensuring WordPress directory exists..."
mkdir -p /var/www/html
cd /var/www/html

if ! command -v wp &> /dev/null; then
    echo "📥 Installing WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -f wp-config.php ]; then
    echo "📥 Downloading WordPress..."
    wp core download --allow-root

    echo "🛠 Configuring WordPress..."
    wp config create --dbname="$WP_DB_NAME" --dbuser="$WP_DB_USER" --dbpass="$WP_DB_PASSWORD" --dbhost="$WP_DB_HOST" --allow-root

    echo "🛠 Installing WordPress..."
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root

    echo "✅ WordPress installed successfully!"
else
    echo "🔹 WordPress already installed, updating..."
    wp core update --allow-root
    wp plugin update --all --allow-root
    wp cache flush --allow-root
fi

echo "🚀 Starting PHP-FPM..."
exec php-fpm8.2 -F