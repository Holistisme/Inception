#!/bin/bash

set -e

echo "📦 Installing Nginx and dependencies..."
apt-get update && apt-get install -y \
    nginx openssl iputils-ping       \
    && rm -rf /var/lib/apt/lists/*