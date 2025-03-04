#!/bin/bash
set -e

###############################################################################
# Entrypoint script for starting NGINX in the foreground
###############################################################################

echo "Starting Nginx..."
exec nginx -g "daemon off;"