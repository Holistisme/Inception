# 📌 Base image: Debian Bullseye
FROM debian:bullseye

# 🏷️ Maintainer Information
LABEL maintainer="aheitz <aheitz@student.42mulhouse.fr>"

# 📂 Set working directory
WORKDIR /app

# 🔽 Copy all necessary scripts to /usr/local/bin and make them executable
COPY ./tools/ /usr/local/bin/
COPY ./conf/default.conf /etc/nginx/sites-available/aheitz.42.fr.conf

RUN set -eux;                                                                                 \
    chmod +x /usr/local/bin/*.sh;                                                             \
    /usr/local/bin/install_nginx.sh;                                                          \
    ln -s /etc/nginx/sites-available/aheitz.42.fr.conf /etc/nginx/sites-enabled/aheitz.42.fr; \
    /usr/local/bin/setup_ssl.sh;                                                              \
    ln -sf /dev/stdout /var/log/nginx/access.log;                                             \
    ln -sf /dev/stderr /var/log/nginx/error.log

# 🌐 Expose HTTPS port
EXPOSE 443

# 🔴 Define a clean shutdown signal for Nginx
STOPSIGNAL SIGQUIT

# 🚀 Start the container with the custom entrypoint script
CMD ["/usr/local/bin/entrypoint.sh"]