FROM alpine:3.19

RUN apk add --no-cache \
    php82 \
    php82-phar \
    php82-json \
    php82-openssl \
    php82-curl \
    php82-zlib \
    php82-mbstring \
    php82-xml \
    php82-xmlwriter \
    php82-dom \
    php82-ctype \
    php82-iconv \
    php82-zip \
    php82-tokenizer \
    php82-pdo \
    php82-pdo_pgsql \
    php82-simplexml \
    php82-session \
    php82-intl \
    curl \
    git

RUN ln -sf /usr/bin/php82 /usr/bin/php

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

ENTRYPOINT ["composer"]
