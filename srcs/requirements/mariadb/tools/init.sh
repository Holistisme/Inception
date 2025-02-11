#!/bin/sh

# Stops in case of error:
set -e  

echo "📁 Ensuring correct permissions on /run/mysqld..."
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

echo "🔍 Checking if gosu is installed..."
if ! command -v gosu > /dev/null; then
    echo "❌ Error: gosu is not installed!" >&2
    exit 1
fi

echo "🚀 Starting MariaDB..."
exec gosu mysql mysqld