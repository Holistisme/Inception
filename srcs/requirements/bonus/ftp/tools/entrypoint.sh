#!/bin/bash
set -euo pipefail

###############################################################################
# Entry script for configuring and running vsftpd
###############################################################################

FTP_DIR=${FTP_DIR:-/var/www/html/wp-content/uploads}

echo "Configuring vsftpd..."

# Update passive address in vsftpd.conf if provided
if [ -n "${FTP_PASV_ADDRESS:-}" ]; then
    sed -i "s/^pasv_address=.*/pasv_address=${FTP_PASV_ADDRESS}/" /etc/vsftpd.conf
fi

if [ ! -f /etc/ssl/private/vsftpd.pem ] || [ ! -f /etc/ssl/certs/vsftpd.pem ]; then
    echo "Generating SSL certificate for vsftpd..."
    mkdir -p /etc/ssl/private /etc/ssl/certs
    openssl req -x509 -nodes -days 365 -newkey rsa:2048                            \
      -subj   "/C=FR/ST=Alsace/L=Mulhouse/O=42/OU=aheitz/CN=${DOMAIN:-localhost}/" \
      -keyout /etc/ssl/private/vsftpd.pem                                          \
      -out    /etc/ssl/certs/vsftpd.pem
fi

FTP_USER=${FTP_USER:-ftpuser}
FTP_PASS=${FTP_PASS:-ftppass}

# Create FTP user if it does not exist
if ! id "$FTP_USER" >/dev/null 2>&1; then
    echo "Creating FTP user $FTP_USER..."
    useradd -m -d "$FTP_DIR" -s /bin/bash "$FTP_USER"
fi

# Set the user's password
echo "$FTP_USER:$FTP_PASS" | chpasswd

# Add the FTP user to the www-data group to manage shared files
usermod -aG www-data "$FTP_USER"

# Ensure the FTP directory exists and has proper permissions
mkdir -p "$FTP_DIR"
chown -R www-data:www-data "$FTP_DIR"
chmod -R 775 "$FTP_DIR"

# Create the vsftpd run directory for PID files
mkdir -p  /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

echo "vsftpd configuration:"
cat  /etc/vsftpd.conf

echo "Starting supervisord..."
exec /usr/bin/supervisord -n