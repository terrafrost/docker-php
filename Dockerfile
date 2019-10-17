FROM php:5.4

RUN apt-get update \
    && apt-get -y install libgmp-dev libmcrypt-dev libssh2-1 libssh2-1-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && pecl install ssh2-0.13 \
    && docker-php-ext-install gmp bcmath mcrypt \
    && docker-php-ext-enable ssh2