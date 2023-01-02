FROM php:7.0-apache
RUN set -ex && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    libpq5 zlib1g-dev libzip4 libfreetype6 libpng-tools libjpeg-turbo-progs \
    libpq-dev libzip-dev libfreetype6-dev libpng-dev libjpeg-dev libxml2-dev && \
    docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    pecl install redis && \
    docker-php-ext-install -j${NPROC} gd pdo_pgsql pdo_mysql mysqli opcache zip iconv bcmath soap xml intl \
    && docker-php-ext-enable redis \
    && mkdir /www \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/lib/apt/lists/* \
    && pecl update-channels \
    && echo "opcache.save_comments=1" >> $PHP_INI_DIR/conf.d/docker-php-ext-opcache.ini \
    && rm -rf /tmp/pear ~/.pearrc \
    && rm -rf /var/cache/apk/*
RUN a2enmod proxy_fcgi ssl rewrite proxy proxy_balancer proxy_http
# Expose volumes
