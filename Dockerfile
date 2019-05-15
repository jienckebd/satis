FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    # Install git
    git \
    # Install apache
    apache2 \
    # Install php 7.2
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-fpm \
    php7.2-gd \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-soap \
    php7.2-sqlite3 \
    php7.2-xml \
    php7.2-zip \
    php7.2-intl \
    php-imagick \
    # Install tools
    openssl \
    nano \
    graphicsmagick \
    imagemagick \
    ghostscript \
    mysql-client \
    iputils-ping \
    locales \
    sqlite3 \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

# Configure PHP for TYPO3
# Configure apache for TYPO3
RUN a2enmod rewrite expires ssl

WORKDIR /var/www

# Install dependencies.
RUN apt-get update -y
RUN apt-get install npm cron lsof vim -y

# Install satis-control-panel
RUN composer create-project realshadow/satis-control-panel satis

COPY files/docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Copy required nginx files.
COPY files/etc /etc

WORKDIR /var/www/satis

# Copy required satis files.
COPY files/var/www/satis /var/www/satis

RUN chmod -R ug+rwx bootstrap/cache storage public/private public/public
RUN chmod ug+rwx resources/satis.json

RUN chown -R www-data:www-data /var/www/satis

# Automatically start cron service.
RUN update-rc.d cron defaults
RUN update-rc.d cron enable

# Add cron job.
RUN (crontab -l 2>/dev/null; echo "0 */3 * * * php /var/www/satis/artisan schedule:run >> /dev/null 2>&1") | crontab -

EXPOSE 80
EXPOSE 9010

# VOLUME /var/www/satis

CMD ["docker-entrypoint.sh"]
