FROM alpine:3.8

LABEL maintainer="Julian Prasetyo <picobug.jp@gmail.com>"

ENV TIMEZONE            Asia/Jakarta
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        100M

RUN	echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
	set -x \
	&& addgroup -g 82 -S www-data \
	&& adduser -u 82 -D -S -G www-data www-data
RUN apk update
RUN apk add --update tzdata gnu-libiconv && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone
RUN apk add --update \
	php7-ftp \
	php7-xml \
	php7-xmlwriter \
	php7-xmlreader \
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
	php7-zip \
	php7 \
	php7-fpm

# Set environments
RUN sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf && \
	sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" /etc/php7/php-fpm.d/www.conf && \
	sed -i "s|;*listen\s*=\s*/||g" /etc/php7/php-fpm.d/www.conf && \
	sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini && \
	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
	sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini && \
	sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
	sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
	sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini

# Cleaning up
RUN mkdir /www && \
	apk del tzdata && \
	rm -rf /var/cache/apk/*

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
# Set Workdir
WORKDIR /www

# Expose volumes
VOLUME ["/www"]

# Expose ports
EXPOSE 9000

# Entry point
ENTRYPOINT ["/usr/sbin/php-fpm7"]