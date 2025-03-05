###############################################################################
# Dockerfile for a static site using NGINX (Debian Bullseye)
###############################################################################
FROM debian:bullseye

LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

###############################################################################
# Create SSL directory and install necessary packages: curl, gnupg, openssl,
# gettext, and nginx
###############################################################################
RUN mkdir -p /etc/nginx/ssl

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl gnupg openssl gettext nginx                             \
    && rm -rf /var/lib/apt/lists/*

###############################################################################
# Copy static files and configuration
###############################################################################
COPY Rickception/       /usr/share/nginx/html/
COPY conf/default.conf /etc/nginx/conf.d/default.conf

###############################################################################
# Copy entrypoint scripts and set them as executable
###############################################################################
COPY tools/docker-entrypoint.sh /tools/docker-entrypoint.sh
COPY tools/generate_ssl.sh      /tools/generate_ssl.sh
RUN chmod +x /tools/docker-entrypoint.sh /tools/generate_ssl.sh

###############################################################################
# Expose HTTPS port and run entrypoint script
###############################################################################
EXPOSE 443
CMD ["/tools/docker-entrypoint.sh"]