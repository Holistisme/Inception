# The source image for the NGINX service: recovers the second-to-last DEBIAN version (at the time the project was created):
FROM nginx:bullseye

# A label to source the author of the Dockerfile:
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# Deletes all default NGINX configurations to ensure a clean setup:
RUN rm -rf /etc/nginx/conf.d/*

# Replaces the NGINX configuration with the project configuration file:
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copies and configures SSL certificate generation script:
COPY tools/generate_ssl.sh /usr/local/bin/generate_ssl.sh
RUN chmod 700 /usr/local/bin/generate_ssl.sh

# Opens service on HTTPS port:
EXPOSE 443

# Install apache2-utils for htpasswd:
RUN apt-get update && apt-get install -y apache2-utils && rm -rf /var/lib/apt/lists/*

# Initiates and runs the service startup script:
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]