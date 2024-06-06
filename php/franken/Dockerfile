FROM dunglas/frankenphp:alpine

# add additional extensions here:
RUN set -ex && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache --virtual .php-deps \
    libpq libzip freetype libpng libjpeg-turbo libwebp icu-libs imagemagick && \
    #apk add --no-cache --virtual .node \
    #chromium nodejs npm && npm i -g puppeteer && npm cache clean --force && rm -rf /root/.cache && rm -rf /root/.npm && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    libxml2-dev shadow autoconf g++ make \
    libzip-dev postgresql-dev freetype-dev libpng-dev libjpeg-turbo-dev libwebp-dev imagemagick-dev && \
    curl -L -o /tmp/imagick.tar.gz https://github.com/Imagick/imagick/archive/7088edc353f53c4bc644573a79cdcd67a726ae16.tar.gz \
    && tar --strip-components=1 -xf /tmp/imagick.tar.gz \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini \
    #install-php-extensions imagick/imagick@master \
    && rm -rf /tmp/* && \
    docker-php-ext-configure gd \
    --with-freetype --with-webp \
    --with-jpeg=/user/include --enable-gd && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    pecl install redis && \
    docker-php-ext-install -j${NPROC} gd pdo_pgsql pdo_mysql opcache intl zip \
    && docker-php-ext-enable redis \
    && apk del .build-deps \
    && apk update && apk add --no-cache --virtual .node \
    chromium nodejs npm && npm i -g puppeteer && npm cache clean --force && rm -rf /root/.cache /root/.npm /tmp/* /usr/local/lib/php/doc/* ~/.pearrc /var/cache/apk/* \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/* \
    && echo "opcache.save_comments=1" >> $PHP_INI_DIR/conf.d/docker-php-ext-opcache.ini \
    && rm -rf /tmp/pear ~/.pearrc \
    && rm -rf /var/cache/apk/* \
    && rm -rf /usr/local/bin/php-cgi /usr/local/bin/phpdbg && docker-php-source delete \
