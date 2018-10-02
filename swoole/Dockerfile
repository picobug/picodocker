# Use Alpine Linux
FROM alpine:edge

# Maintainer
LABEL maintainer="Julian Prasetyo <picobug.jp@gmail.com>"

# Environments
ENV TIMEZONE            Asia/Jakarta
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        100M

# Let's roll
RUN	echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --update tzdata gnu-libiconv && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apk add --update \
    php7-ftp \
    php7-ssh2 \
    php7-xml \
    php7-simplexml \
    php7-fileinfo \
    php7-session \
    php7-mbstring \
    php7-opcache \
    php7-intl \
    php7-redis \
    php7-tokenizer \
    php7-exif \
    php7-openssl \
    php7-gmp \
    php7-json \
    php7-dom \
    php7-pdo \
    php7-pgsql \
    php7-pdo_pgsql \
    php7-mysqli \
    php7-pdo_mysql \
    php7-sqlite3 \
    php7-pdo_sqlite \
    php7-bcmath \
    php7-gd \
    php7-gettext \
    php7-bz2 \
    php7-iconv \
    php7-curl \
    php7-ctype \
    php7-sodium \
    php7-igbinary \
    php7 \
    php7-fpm && \

    # Set environments
    sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf && \
    sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|;*listen\s*=\s*/||g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini && \
    sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
    sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini && \
    sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
    sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini

RUN apk add autoconf build-base linux-headers \
    libaio-dev \
    zlib-dev \
    php7-dev \
    php7-pear \
    && sed -i "s/struct sigaction {/#ifndef __sighandler_t \ntypedef void (*__sighandler_t)(int);\n#endif\nstruct sigaction\n{/g" /usr/include/signal.h \
    && sed -i "s/union {void (*sa_handler)(int)/__sighandler_t sa_handler/g" /usr/include/signal.h \
    && sed -i "s/ -n / /" `which pecl` \
    && pecl install swoole \
    && echo "extension=swoole.so" > /etc/php7/conf.d/00_swoole.ini \
    && apk del tzdata \
    zlib-dev \
    libaio-dev \
    php7-dev \
    php7-pear \
    autoconf build-base linux-headers \
    && mkdir /www \
    && rm -rf /var/cache/apk && mkdir /var/cache/apk/ && rm -rf /tmp/*

RUN set -x \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
# Set Workdir
WORKDIR /www

# Expose volumes
VOLUME ["/www"]

# Command
CMD ["php", "-a"]