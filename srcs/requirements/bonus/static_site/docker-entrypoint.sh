#!/bin/sh
# ------------------------------------------------------------------------------
# docker-entrypoint.sh for Rickception Static Site
#
# This script uses envsubst to automatically substitute the ${IP_ADDRESS}
# placeholder in the static files with the actual environment variable value,
# then starts Nginx in the foreground.
# ------------------------------------------------------------------------------

# Replace ${IP_ADDRESS} in index.html
envsubst '${IP_ADDRESS}' < /usr/share/nginx/html/index.html > /usr/share/nginx/html/index.tmp && \
mv /usr/share/nginx/html/index.tmp /usr/share/nginx/html/index.html

# Replace ${IP_ADDRESS} in js/script.js
envsubst '${IP_ADDRESS}' < /usr/share/nginx/html/js/script.js > /usr/share/nginx/html/js/script.tmp && \
mv /usr/share/nginx/html/js/script.tmp /usr/share/nginx/html/js/script.js

# Start Nginx in the foreground
exec nginx -g "daemon off;"