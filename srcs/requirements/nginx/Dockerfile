###############################################################################
# Dockerfile for NGINX-based service (Debian Bullseye)
###############################################################################
FROM debian:bullseye

LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# Set working directory for the container
WORKDIR /app

# Copy scripts and the default NGINX configuration
COPY ./tools/            /usr/local/bin/
COPY ./conf/default.conf /etc/nginx/sites-available/aheitz.42.fr.conf

###############################################################################
# Installation and setup steps
###############################################################################
RUN set -eux;                                                                                 \
    chmod +x /usr/local/bin/*.sh;                                                             \
    /usr/local/bin/install_nginx.sh;                                                          \
    ln -s /etc/nginx/sites-available/aheitz.42.fr.conf /etc/nginx/sites-enabled/aheitz.42.fr; \
    /usr/local/bin/setup_ssl.sh;                                                              \
    ln -sf /dev/stdout /var/log/nginx/access.log;                                             \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Expose HTTPS port
EXPOSE 443

# Graceful stop signal for NGINX
STOPSIGNAL SIGQUIT

# Set the default command to run when container starts
CMD ["/usr/local/bin/entrypoint.sh"]