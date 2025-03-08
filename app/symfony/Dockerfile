FROM alpine:3.19

RUN apk add --no-cache \
    php82 \
    php82-fpm \
    php82-pdo \
    php82-pdo_pgsql \
    php82-pgsql \
    php82-json \
    php82-openssl \
    php82-curl \
    php82-zlib \
    php82-xml \
    php82-phar \
    php82-intl \
    php82-dom \
    php82-xmlreader \
    php82-xmlwriter \
    php82-ctype \
    php82-session \
    php82-mbstring \
    php82-tokenizer \
    php82-fileinfo \
    php82-simplexml \
    php82-iconv \
    nginx \
    supervisor \
    postgresql-client

RUN ln -sf /usr/bin/php82 /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm82 /usr/sbin/php-fpm

COPY php.ini /etc/php82/php.ini
COPY php-fpm.conf /etc/php82/php-fpm.conf

COPY nginx.conf /etc/nginx/nginx.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www/html

RUN mkdir -p /var/log/php82 && \
    mkdir -p /var/www/html/var && \
    chmod -R 777 /var/www/html/var

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
