#!/bin/sh

# Generates SSL certificate:
/usr/local/bin/generate_ssl.sh

# Checks if the .htpasswd file already exists:
if [ ! -f /etc/nginx/.htpasswd ]; then
    if [ -n "$ADMIN_USER" ] && [ -n "$ADMIN_PASSWORD" ]; then
        echo "🔐 Creating .htpasswd for $ADMIN_USER..."
        htpasswd -bc /etc/nginx/.htpasswd "$ADMIN_USER" "$ADMIN_PASSWORD"
    else
        echo "⚠️ ADMIN_USER or ADMIN_PASSWORD is missing. Cannot create .htpasswd!" >&2
        exit 1
    fi
else
    echo "🔹 .htpasswd already exists. Skipping user creation."
fi

# Starts NGINX in foreground mode:
exec nginx -g 'daemon off;'