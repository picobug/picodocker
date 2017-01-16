FROM matriphe/alpine-php:fpm7

MAINTAINER Julio Pico <picobug.jp@gmail.com>

RUN apk add --no-cache bash \
	php7-session \
	php7-mbstring \
	php7-intl

RUN echo "expose_php=0" > /etc/php7/php.ini
