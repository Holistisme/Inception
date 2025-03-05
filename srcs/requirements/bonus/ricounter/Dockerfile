###############################################################################
# Dockerfile for a Node.js-based Rickroll counter service (Debian Bullseye)
###############################################################################
FROM debian:bullseye

LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

###############################################################################
# Install curl, gnupg, openssl, and Node.js (v14 setup)
###############################################################################
RUN apt-get update && apt-get install -y curl gnupg openssl \
    && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -              \
    && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

###############################################################################
# Prepare the application directory and install dependencies
###############################################################################
RUN mkdir -p /app/ssl
WORKDIR /app

COPY package*.json ./
RUN npm install

###############################################################################
# Copy all remaining files, including scripts and source code
###############################################################################
COPY . .

COPY tools/generate_ssl.sh /tools/generate_ssl.sh
RUN chmod +x /tools/generate_ssl.sh

###############################################################################
# Expose the service port (3000 by default) and define the startup command
###############################################################################
EXPOSE 3000
CMD ["sh", "-c", "/tools/generate_ssl.sh && node index.js"]