FROM alpine:3.14

RUN apk add --no-cache php7 php7-session php7-pdo php7-pdo_pgsql php7-pgsql php7-mysqli php7-pdo_mysql \
    php7-json php7-fpm php7-mbstring php7-pecl-uploadprogress php7-curl

RUN mkdir -p /var/www/html

RUN wget -O /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php

RUN echo "listen = 0.0.0.0:9000" >> /etc/php7/php-fpm.d/www.conf

RUN apk add --no-cache nginx
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

CMD php-fpm7 && nginx -g "daemon off;"
