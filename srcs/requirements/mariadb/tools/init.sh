#!/bin/sh

# Stops in case of error:
set -e

echo "📁 Ensuring correct permissions on /run/mysqld and /var/lib/mysql..."
mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql
chmod -R 700 /var/lib/mysql

echo "🔍 Checking if gosu is installed..."
if ! command -v gosu > /dev/null; then
    echo "❌ Error: gosu is not installed!" >&2
    exit 1
fi

if [ ! -f "/var/lib/mysql/.setup_done" ]; then
    echo "⚙️ Running database setup script..."
    /docker-entrypoint-initdb.d/setup.sh &
fi

echo "🚀 Starting MariaDB..."
exec gosu mysql mysqld