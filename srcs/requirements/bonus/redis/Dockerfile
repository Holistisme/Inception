# 📌 Base image: Debian Bullseye
FROM debian:bullseye

# 🏷️ Maintainer Information
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# 🔧 Install Redis
RUN apt-get update && apt-get install -y redis && rm -rf /var/lib/apt/lists/*

# 📂 Copy Redis configuration file
COPY conf/redis.conf /etc/redis/redis.conf

# 📡 Expose port 9000 for PHP-FPM communication
EXPOSE 6379

# 🚀 Replace password placeholder and start Redis
CMD sed -i "s|\${REDIS_PASSWORD}|$REDIS_PASSWORD|" /etc/redis/redis.conf && redis-server /etc/redis/redis.conf