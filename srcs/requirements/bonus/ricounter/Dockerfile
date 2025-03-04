# ------------------------------------------------------------------------------
# Dockerfile for Rickroll Counter Service (Debian Bullseye with HTTPS)
#
# This Dockerfile builds an image for a Node.js-based Rickroll Counter service.
# It uses Debian Bullseye as the base image, installs Node.js, generates a 
# self-signed SSL certificate, and runs the service on port 3000.
#
# Maintainer: aheitz <aheitz@student.42mulhouse.fr>
# ------------------------------------------------------------------------------

# Use Debian Bullseye as the base image
FROM debian:bullseye

# Set the maintainer label
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# Update package lists and install required packages: curl, gnupg, and openssl.
# Then, clean up the apt cache.
RUN apt-get update && apt-get install -y curl gnupg openssl && rm -rf /var/lib/apt/lists/*

# Set up Node.js (using NodeSource for Node.js 14)
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs &&                                 \
    rm -rf /var/lib/apt/lists/*

# Create a directory for SSL certificates in /app/ssl
RUN mkdir -p /app/ssl

# Generate a self-signed SSL certificate valid for 365 days.
RUN openssl req -x509 -nodes -days 365                             \
    -subj "/C=FR/ST=Alsace/L=Mulhouse/O=42/OU=aheitz/CN=${DOMAIN}" \
    -newkey rsa:2048                                               \
    -keyout /app/ssl/server.key                                    \
    -out    /app/ssl/server.crt

# Set the working directory inside the container to /app
WORKDIR /app

# Copy package.json (and package-lock.json if available) into the container
COPY package*.json ./

# Install Node.js dependencies defined in package.json
RUN npm install

# Copy the rest of the application code into the container
COPY . .

# Expose port 3000 (the port the Node.js app listens on)
EXPOSE 3000

# Command to start the Node.js application
CMD ["node", "index.js"]