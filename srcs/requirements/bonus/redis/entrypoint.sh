#!/bin/sh
set -e

sed -i 's/^\s*daemonize\s\+yes/daemonize no/' /etc/redis/redis.conf

if [ -n "$REDIS_PASSWORD" ]; then
    sed -i "s|\${REDIS_PASSWORD}|$REDIS_PASSWORD|g" /etc/redis/redis.conf
fi

echo "Starting Redis in foreground mode..."
exec redis-server /etc/redis/redis.conf