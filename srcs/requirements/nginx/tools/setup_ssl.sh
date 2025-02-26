#!/bin/bash

set -e

echo "🔐 Generating SSL certificate..."
openssl req -x509 -sha256 -nodes -days 365     \
    -newkey rsa:2048                           \
    -keyout /etc/ssl/private/aheitz_42_fr.key  \
    -out /etc/ssl/certs/aheitz_42_fr.crt       \
    -subj "/C=FR/ST=Alsace/L=Mulhouse/O=42/OU=aheitz/CN=$DOMAIN/"