FROM php:7-fpm-alpine
RUN set -ex && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add \
    libpq postgresql-dev gnu-libiconv \
    freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
    docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    pecl install redis && \
    docker-php-ext-install -j${NPROC} gd pdo_pgsql pdo_mysql mysqli opcache \
    && docker-php-ext-enable redis

RUN mkdir /www \
    && apk del freetype-dev libpng-dev libjpeg-turbo-dev postgresql-dev \
    && pecl update-channels \
    && rm -rf /tmp/pear ~/.pearrc \
    && rm -rf /var/cache/apk/*

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
WORKDIR /www

# Expose volumes
VOLUME ["/www"]