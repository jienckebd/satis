FROM richarvey/nginx-php-fpm

WORKDIR /var

RUN apk add --update nodejs
RUN apk add npm

RUN composer create-project realshadow/satis-control-panel satis
RUN chown -R nginx:nginx /var/satis

USER nginx
