# ------------------------------------------------------------------------------
# Dockerfile for the Rickception Static Site with Nginx on Debian Bullseye
#
# This Dockerfile builds an image to serve the static website "Rickception"
# using Nginx. It also generates a self-signed SSL certificate for HTTPS.
#
# Maintainer: aheitz <aheitz@student.42mulhouse.fr>
# ------------------------------------------------------------------------------

# Use Debian Bullseye as the base image
FROM debian:bullseye

# Set the maintainer label
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# Create a directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Update package lists and install Nginx and OpenSSL,
# then remove the apt cache to reduce image size
RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# Generate a self-signed SSL certificate for HTTPS
# The DOMAIN environment variable is used for the certificate's CN.
RUN openssl req -x509 -nodes -days 365                            \
    -subj "/C=FR/ST=Alsace/L=Mulhouse/O=42/OU=aheitz/CN=$DOMAIN/" \
    -newkey rsa:2048                                              \
    -keyout /etc/nginx/ssl/nginx.key                              \
    -out /etc/nginx/ssl/nginx.crt

# Copy the static website files (Rickception) into Nginx's web root
COPY Rickception/ /usr/share/nginx/html/

# Copy the custom Nginx configuration file into the container
COPY default.conf /etc/nginx/conf.d/default.conf

# Expose port 443 for HTTPS traffic
EXPOSE 443

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]