#!/bin/sh

CERT_DIR="/etc/ssl/certs"
KEY_DIR="/etc/ssl/private"
CERT_FILE="${CERT_DIR}/nginx-cert.pem"
KEY_FILE="${KEY_DIR}/nginx-key.pem"

DAYS_VALID=365
KEY_SIZE=2048

# Checks if the certificate already exists:
if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
    echo "🔐 Generating a new SSL certificate..."

    mkdir -p "$CERT_DIR" "$KEY_DIR" 2>/dev/null

    openssl req -x509 -nodes -days "$DAYS_VALID" -newkey rsa:"$KEY_SIZE" \
        -keyout "$KEY_FILE" -out "$CERT_FILE" \
        -subj "/C=FR/ST=Mulhouse/L=42/OU=IT Department/CN=aheitz.42.fr"

    # Checks if the files were properly created
    if [ -f "$CERT_FILE" ] && [ -f "$KEY_FILE" ]; then
        echo "✅ SSL certificate successfully generated at: $CERT_FILE"
    else
        echo "❌ Failed to generate SSL certificate!" >&2
        exit 1
    fi
else
    echo "🔹 SSL certificate already exists. Skipping generation."
fi