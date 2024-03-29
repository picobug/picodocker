FROM microsoft/mssql-tools as mssql
FROM picobug/php:7

COPY --from=mssql /opt/microsoft/ /opt/microsoft/
COPY --from=mssql /opt/mssql-tools/ /opt/mssql-tools/
COPY --from=mssql /usr/lib/libmsodbcsql-13.so /usr/lib/libmsodbcsql-13.so


RUN set -xe \
    && apk add --no-cache --virtual .persistent-deps \
    freetds \
    unixodbc \
    && curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.5.2.1-1_amd64.apk \
    && curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.5.2.1-1_amd64.apk \
    && apk add --allow-untrusted msodbcsql17_17.5.2.1-1_amd64.apk \
    && apk add --allow-untrusted mssql-tools_17.5.2.1-1_amd64.apk \
    && apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    unixodbc-dev \
    freetds-dev \
    && docker-php-source extract \
    && docker-php-ext-install pdo_dblib \
    && pecl install \
    sqlsrv \
    pdo_sqlsrv \
    && docker-php-ext-enable --ini-name 30-sqlsrv.ini sqlsrv \
    && docker-php-ext-enable --ini-name 35-pdo_sqlsrv.ini pdo_sqlsrv \
    && docker-php-source delete \
    && apk del .build-deps \
    && rm -rfv ./*.apk && rm -rf /var/cache/apk/*
