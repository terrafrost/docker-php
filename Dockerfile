FROM php:7.0

RUN apt-get update \
    && apt-get -y install libgmp-dev libmcrypt-dev libssh2-1 libssh2-1-dev libsodium-dev \
    && pecl install libsodium \
    # the following doesn't work because of https://bugs.php.net/78560
    #&& pecl install ssh2-1.2 \
    && curl -o /tmp/ssh2-1.2.tgz https://pecl.php.net/get/ssh2 \
    && pear install /tmp/ssh2-1.2.tgz \
    && docker-php-ext-install gmp bcmath mcrypt \
    && docker-php-ext-enable ssh2 sodium