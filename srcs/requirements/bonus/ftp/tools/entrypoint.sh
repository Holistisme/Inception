#!/bin/bash

# Enable debugging and exit immediately if a command exits with a non-zero status
set -ex

# Define the directory for FTP uploads
FTP_DIR="/var/www/html/wp-content/uploads"

# Update the vsftpd configuration to set the passive mode address using the FTP_PASV_ADDRESS environment variable
sed -i "s/^pasv_address=.*/pasv_address=${FTP_PASV_ADDRESS}/" /etc/vsftpd.conf

# Generate a self-signed SSL certificate if it does not already exist
if [ ! -f /etc/ssl/private/vsftpd.pem ] || [ ! -f /etc/ssl/certs/vsftpd.pem ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048             \
      -subj "/C=FR/ST=Alsace/L=Mulhouse/O=42/OU=aheitz/CN=$DOMAIN/" \
      -keyout /etc/ssl/private/vsftpd.pem                           \
      -out /etc/ssl/certs/vsftpd.pem
fi

# Create the FTP user if it does not exist
if ! id "$FTP_USER" >/dev/null 2>&1; then
    useradd -m -d "$FTP_DIR" -s /bin/bash "$FTP_USER"
fi

# Set the password for the FTP user
echo "$FTP_USER:$FTP_PASS" | chpasswd

# Add the FTP user to the www-data group for proper permissions on the upload directory
usermod -aG www-data "$FTP_USER"

# Ensure the FTP directory exists, set the owner to www-data and apply directory permissions
mkdir -p "$FTP_DIR"
chown -R www-data:www-data "$FTP_DIR"
chmod -R 775 "$FTP_DIR"

# Create the empty directory required by vsftpd for chroot and set appropriate permissions
mkdir -p  /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

# Output the current vsftpd configuration (useful for debugging)
cat /etc/vsftpd.conf

# Execute vsftpd with the specified configuration file; this process will replace the shell process
exec /usr/sbin/vsftpd /etc/vsftpd.conf