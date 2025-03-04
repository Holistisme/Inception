#!/bin/sh
set -e

###############################################################################
# Initialization script that creates the database and user.
# This script is run only once if no prior setup is detected.
###############################################################################

if [ -f "/var/lib/mysql/.setup_done" ]; then
    echo "MariaDB setup already done, skipping initialization."
    exit 0
fi

echo "Waiting for MariaDB to start..."
i=0
max_retries=30
until mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1" > /dev/null 2>&1; do
    sleep 2
    i=$((i+1))
    if [ "$i" -ge "$max_retries" ]; then
        echo "Error: MariaDB did not start within the expected time." >&2
        exit 1
    fi
done

echo "MariaDB is up and running!"

echo "Configuring database and users..."

echo "Creating database..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"

echo "Creating user..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

echo "Granting privileges..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';"

echo "Updating root user password..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

echo "Flushing privileges..."
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

echo "Database and user setup complete."
touch /var/lib/mysql/.setup_done