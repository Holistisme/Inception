#!/bin/bash
set -e

###############################################################################
# Installs NGINX and its dependencies on Debian-based systems
###############################################################################

echo "Installing Nginx and dependencies..."
apt-get update && apt-get install -y --no-install-recommends \
    nginx openssl iputils-ping procps                        \
    && rm -rf /var/lib/apt/lists/*