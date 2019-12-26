FROM php:7.0

RUN apt-get update \
    && apt-get -y install libgmp-dev libmcrypt-dev libssh2-1 libssh2-1-dev libsodium-dev \
    && pecl install libsodium ssh2-1.2 \
    && docker-php-ext-install gmp bcmath mcrypt \
    && docker-php-ext-enable ssh2 sodium