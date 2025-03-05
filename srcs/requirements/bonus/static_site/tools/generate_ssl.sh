#!/bin/sh
set -e

###############################################################################
# Generates a self-signed SSL certificate for NGINX if none exists.
###############################################################################

if [ ! -f /etc/nginx/ssl/nginx.key ] || [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    echo "Generating SSL certificate..."
    openssl req -x509 -nodes -days 365 \
        -subj   "/C=FR/ST=Alsace/L=Mulhouse/O=42/OU=aheitz/CN=${DOMAIN:-aheitz.42.fr}/" \
        -newkey rsa:2048                                                                \
        -keyout /etc/nginx/ssl/nginx.key                                                \
        -out    /etc/nginx/ssl/nginx.crt
else
    echo "SSL certificates already in use."
fi