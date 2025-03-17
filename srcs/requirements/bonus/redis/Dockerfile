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
# Start Redis with the following script
###############################################################################
COPY conf/redis.conf /etc/redis/redis.conf
COPY entrypoint.sh   /usr/local/bin/entrypoint.sh
RUN  chmod +x        /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]