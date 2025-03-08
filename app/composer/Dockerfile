FROM alpine:3.14

RUN apk add --no-cache \
    php7 \
    php7-phar \
    php7-json \
    php7-openssl \
    php7-curl \
    php7-zlib \
    php7-mbstring \
    php7-xml \
    php7-dom \
    php7-ctype \
    php7-iconv \
    php7-zip \
    php7-tokenizer \
    php7-pdo \
    php7-pdo_pgsql \
    php7-simplexml \
    curl \
    git

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

ENTRYPOINT ["composer"]
