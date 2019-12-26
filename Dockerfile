FROM php:7.3

RUN apt-get update \
    && apt-get -y install libgmp-dev libmcrypt-dev libssh2-1 libssh2-1-dev \
    && pecl install mcrypt ssh2-1.2 \
    && docker-php-ext-install gmp bcmath \
    && docker-php-ext-enable mcrypt ssh2