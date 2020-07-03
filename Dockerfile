FROM node:lts-alpine
RUN sed -i 's,http://dl-cdn.alpinelinux.org/alpine,https://download.nus.edu.sg/mirror/alpine,g' /etc/apk/repositories && apk update && \
	apk add --no-cache --virtual .pkg-deps \
    git && \
	rm -rf /tmp/* /var/cache/apk/*
