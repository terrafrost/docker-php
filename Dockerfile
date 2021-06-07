FROM php:8.0

RUN apt-get update \
    && apt-get -y install libgmp-dev libmcrypt-dev \
    && pecl install mcrypt \
    && docker-php-ext-install gmp bcmath \
    && docker-php-ext-enable mcrypt
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && apt-get -y install git unzip