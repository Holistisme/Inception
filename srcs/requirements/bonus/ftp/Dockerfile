###############################################################################
# Dockerfile for an FTP service using vsftpd (Debian Bullseye)
###############################################################################
FROM debian:bullseye

LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

###############################################################################
# Install vsftpd, bash, and openssl
###############################################################################
RUN apt-get update && apt-get install -y --no-install-recommends \
    vsftpd                                                       \
    bash                                                         \
    openssl                                                      \
    && rm -rf /var/lib/apt/lists/*

###############################################################################
# Copy the vsftpd configuration file and entrypoint script
###############################################################################
COPY conf/vsftpd.conf    /etc/vsftpd.conf
COPY tools/entrypoint.sh /entrypoint.sh

# Ensure the entrypoint script is executable
RUN chmod +x /entrypoint.sh

###############################################################################
# Expose FTP ports (21 for control, 21000-21010 for passive mode)
###############################################################################
EXPOSE 21 21000-21010

###############################################################################
# Run the entrypoint script when the container starts
###############################################################################
CMD ["/entrypoint.sh"]