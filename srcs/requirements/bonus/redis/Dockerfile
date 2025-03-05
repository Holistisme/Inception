###############################################################################
# Dockerfile for Redis (Debian Bullseye)
###############################################################################
FROM debian:bullseye

LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

###############################################################################
# Install redis-server and clean up
###############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends redis-server \
    && rm -rf /var/lib/apt/lists/*

###############################################################################
# Copy Redis configuration
###############################################################################
COPY conf/redis.conf /etc/redis/redis.conf

# Expose the default Redis port
EXPOSE 6379

###############################################################################
# Replace placeholder password in redis.conf, then start Redis with that config
###############################################################################
CMD sed -i "s|\${REDIS_PASSWORD}|$REDIS_PASSWORD|" /etc/redis/redis.conf && redis-server /etc/redis/redis.conf