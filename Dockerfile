FROM php:8.0

RUN apt-get update \
    && apt-get -y install libgmp-dev libmcrypt-dev \
    && pecl install mcrypt \
    && docker-php-ext-install gmp bcmath \
    && docker-php-ext-enable mcrypt