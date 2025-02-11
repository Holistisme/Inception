#!/bin/sh

# Stops in case of error:
set -e

echo "⌛ Waiting for MariaDB to be ready..."
until mysqladmin ping -h"$WP_DB_HOST" --silent; do
    sleep 2
done

echo "✅ MariaDB is up and running!"
sleep 1

echo "📁 Ensuring WordPress directory exists..."
mkdir -p /var/www/html
cd /var/www/html

# Checks if WordPress is already installed
if [ ! -f wp-config.php ]; then
    echo "📥 Downloading WordPress..."
    wp core download --allow-root

    echo "🛠 Configuring WordPress connection to database..."
    wp config create --dbname="$WP_DB_NAME" --dbuser="$WP_DB_USER" --dbpass="$WP_DB_PASSWORD" --dbhost="$WP_DB_HOST" --allow-root

    echo "🛠 Installing WordPress..."
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root

    echo "✅ WordPress successfully installed!"
else
    echo "🔹 WordPress already installed, updating..."
    wp core update --allow-root
    wp plugin update --all --allow-root
    wp cache flush --allow-root
fi

# Launch PHP-FPM to make WordPress work with Nginx:
echo "🚀 Starting PHP-FPM..."
exec php-fpm7.4 -F