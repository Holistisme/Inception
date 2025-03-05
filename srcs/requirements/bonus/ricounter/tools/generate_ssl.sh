#!/bin/sh
set -e

###############################################################################
# Generate a self-signed SSL certificate for the Node.js service if not present
###############################################################################

if [ ! -f /app/ssl/server.key ] || [ ! -f /app/ssl/server.crt ]; then
    echo "Generating SSL certificate..."
    openssl req -x509 -nodes -days 365                                              \
        -subj   "/C=FR/ST=Alsace/L=Mulhouse/O=42/OU=aheitz/CN=${DOMAIN:-localhost}" \
        -newkey rsa:2048                                                            \
        -keyout /app/ssl/server.key                                                 \
        -out    /app/ssl/server.crt
else
    echo "SSL certificates already in use."
fi