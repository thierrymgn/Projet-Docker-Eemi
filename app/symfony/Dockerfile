FROM alpine:3.14

RUN apk add --no-cache \
    php7 \
    php7-fpm \
    php7-pdo \
    php7-pdo_pgsql \
    php7-pgsql \
    php7-json \
    php7-openssl \
    php7-curl \
    php7-zlib \
    php7-xml \
    php7-phar \
    php7-intl \
    php7-dom \
    php7-xmlreader \
    php7-xmlwriter \
    php7-ctype \
    php7-session \
    php7-mbstring \
    php7-tokenizer \
    php7-fileinfo \
    php7-simplexml \
    php7-iconv \
    nginx \
    supervisor

RUN apk add --no-cache git

COPY php.ini /etc/php7/php.ini
COPY php-fpm.conf /etc/php7/php-fpm.conf

COPY nginx.conf /etc/nginx/nginx.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www/html

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
