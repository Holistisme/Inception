# ------------------------------------------------------------------------------
# Dockerfile for FTP Service using vsftpd on Debian Bullseye
#
# This Dockerfile sets up an FTP server based on vsftpd. The image is derived 
# from Debian Bullseye, and it installs vsftpd along with necessary tools.
#
# Maintainer: aheitz <aheitz@student.42mulhouse.fr>
# ------------------------------------------------------------------------------

# Use Debian Bullseye as the base image
FROM debian:bullseye

# ------------------------------------------------------------------------------
# Maintainer Information
# ------------------------------------------------------------------------------
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# ------------------------------------------------------------------------------
# Install Dependencies
# ------------------------------------------------------------------------------
# Update package lists and install vsftpd and bash.
# Remove the apt cache to reduce image size.
RUN apt-get update && apt-get install -y \
    vsftpd                               \
    bash                                 \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------------------------
# Copy Configuration Files and Scripts
# ------------------------------------------------------------------------------
# Copy the vsftpd configuration file and the entrypoint script into the image.
COPY conf/vsftpd.conf    /etc/vsftpd.conf
COPY tools/entrypoint.sh /entrypoint.sh

# Make sure the entrypoint script is executable
RUN chmod +x /entrypoint.sh

# ------------------------------------------------------------------------------
# Expose Necessary Ports
# ------------------------------------------------------------------------------
# Port 21 is used for the FTP control connection.
# Ports 21000-21010 are used for passive mode data connections.
EXPOSE 21 21000-21010

# ------------------------------------------------------------------------------
# Set the Default Command
# ------------------------------------------------------------------------------
# The entrypoint script will be executed when the container starts.
CMD ["/entrypoint.sh"]