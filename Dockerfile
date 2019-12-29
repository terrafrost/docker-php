FROM php:5.3

RUN apt-get update \
    && apt-get install -y --force-yes wget

RUN cd /tmp \
    && wget --no-check-certificate http://www.openssl.org/source/openssl-0.9.8x.tar.gz \
    && tar xvfz openssl-0.9.8x.tar.gz \
    && cd openssl-0.9.8x \
    && ./config shared --prefix=/usr/local/openssl-0.9.8 \
    && make \
    && make install_sw

RUN apt-get install -y --force-yes libgmp-dev libmcrypt-dev libssh2-1 libssh2-1-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && cd /tmp \
    && wget --no-check-certificate https://museum.php.net/php5/php-5.3.29.tar.xz \
    && tar xvf php-5.3.29.tar.xz \
    && cd php-5.3.29/ext/gmp \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cd ../bcmath \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cd ../mcrypt \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cd ../openssl \
    && mv config0.m4 config.m4 \
    && phpize \
    && ./configure \
        --with-openssl=/usr/local/openssl-0.9.8 \
    && make \
    && make install\
    && pecl install ssh2-0.13 \
    && printf "extension=gmp.so\nextension=bcmath.so\nextension=mcrypt.so\nextension=ssh2.so\nextension=openssl.so" > /usr/local/lib/php.ini