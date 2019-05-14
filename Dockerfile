FROM richarvey/nginx-php-fpm

WORKDIR /var

# Copy required files.
COPY files/etc /etc

# Install dependencies.
RUN apk add --update nodejs npm

# Install satis-control-panel
RUN composer create-project realshadow/satis-control-panel satis
COPY files/var/satis /var/satis
RUN chown -R www-data:www-data /var/satis

COPY files/docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/satis
RUN chmod -R ug+rwx bootstrap/cache storage public/private public/public
RUN chmod ug+rwx resources/satis.json

EXPOSE 9010

VOLUME /var/satis

ENTRYPOINT ["docker-entrypoint.sh"]
