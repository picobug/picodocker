FROM php:7-fpm-alpine
RUN set -ex && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    sed -i -e 's/http:\/\/dl-cdn.alpinelinux.org\/alpine/https:\/\/download.nus.edu.sg\/mirror\/alpine/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache --virtual .php-deps \
    libpq libzip freetype libpng libjpeg-turbo && \
    apk add --no-cache --virtual .build-deps \
    libzip-dev postgresql-dev freetype-dev libpng-dev libjpeg-turbo-dev libxml2-dev && \
    apk add gnu-libiconv --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted && \
    docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    pecl install redis && \
    docker-php-ext-install -j${NPROC} gd pdo_pgsql pdo_mysql mysqli opcache zip bcmath soap xml \
    && docker-php-ext-enable redis

RUN mkdir /www \
    && apk del .build-deps \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/* \
    && pecl update-channels \
    && echo "opcache.save_comments=1" >> $PHP_INI_DIR/conf.d/docker-php-ext-opcache.ini \
    && rm -rf /tmp/pear ~/.pearrc \
    && rm -rf /var/cache/apk/*

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
WORKDIR /www

# Expose volumes
VOLUME ["/www"]
