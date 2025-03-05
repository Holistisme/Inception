#!/bin/sh
set -e

###############################################################################
# Script to generate SSL certificates if needed and substitute environment
# variables into HTML/JS files, then start NGINX.
###############################################################################

/tools/generate_ssl.sh

# Replace ${IP_ADDRESS} in index.html with actual environment value
envsubst '${IP_ADDRESS}' < /usr/share/nginx/html/index.html > /usr/share/nginx/html/index.tmp \
    && mv /usr/share/nginx/html/index.tmp /usr/share/nginx/html/index.html

# Replace ${IP_ADDRESS} in script.js with actual environment value
envsubst '${IP_ADDRESS}' < /usr/share/nginx/html/js/script.js > /usr/share/nginx/html/js/script.tmp \
    && mv /usr/share/nginx/html/js/script.tmp /usr/share/nginx/html/js/script.js

echo "Starting Nginx..."
exec nginx -g "daemon off;"