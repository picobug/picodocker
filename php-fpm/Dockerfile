FROM php:fpm-alpine

MAINTAINER Julio Pico <picobug.jp@gmail.com>

RUN apk add --no-cache bash postgresql postgresql-dev \
	    freetype freetype-dev \
	    libjpeg-turbo libjpeg-turbo-dev \
	    libmcrypt libmcrypt-dev \
	    libpng libpng-dev \
	    libintl icu icu-dev libxml2 libxml2-dev \
    && docker-php-ext-configure gd \
    	--with-gd \
	    --with-png-dir=/usr/include/ \
    	--with-freetype-dir=/usr/include/ \
    	--with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" iconv mcrypt gd \
    && docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql opcache intl zip soap \
    && docker-php-ext-enable opcache \
    && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev libmcrypt-dev icu-dev libxml2-dev postgresql-dev

RUN echo "expose_php=0" > /usr/local/etc/php/php.ini
