FROM matriphe/alpine-php:fpm7

MAINTAINER Julio Pico <picobug.jp@gmail.com>

RUN apk update && apk upgrade && apk add --no-cache bash \
	php7-ftp \
	php7-ssh2 \
	php7-xml \
	php7-fileinfo \
	php7-session \
	php7-mbstring \
	php7-opcache \
	php7-intl \
	php7-redis \
	php7-tokenizer \
	php7-exif \
	php7 \
	&& rm -rf /var/cache/apk/*
