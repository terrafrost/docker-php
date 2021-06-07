# Docker Containers For phpseclib Testing

The following extensions are available on all containers:

- bcmath
- gmp
- OpenSSL
- mcrypt
- sodium (5.6+ only)
- ssh2 (5.3+ only)

## Running Multiple PHP versions via Docker
After installing Docker you may use these containers to run multiple versions of PHP on Linux via Docker. Using the 8.0 container as an example, here's what you'd want to do:

```
docker pull "phpseclib/php8.0"
printf "alias php80='docker run -it --rm --name php80 --user \$(id -u):\$(id -g) -v \"\$PWD\":/usr/src/myapp -w /usr/src/myapp phpseclib/php8.0 php'\n" >> ~/.bashrc
printf "alias composer80='docker run -it --rm --name php80 --user \$(id -u):\$(id -g) -v \"\$PWD\":/usr/src/myapp -w /usr/src/myapp phpseclib/php8.0 composer'\n" >> ~/.bashrc
```

At this point you'll be able to do `php80 test.php` to run PHP scripts using the 8.0 container or `composer80 require phpseclib/phpseclib:^3.0` to run Composer using the 8.0 container

## Notes on the available extensions

**ssh2**

This PECL extension is included for comparison purposes with phpseclib.

The PHP 4.4, 5.0, 5.1 and 5.2 Dockerfile's do not support libssh2 due to issues I was having with installing / compiling the extensions. If you're able to get libssh2 working in these versions feel free to submit a pull request.

**sodium**

[sodium](https://www.php.net/manual/en/book.sodium.php) was first included in PHP 7.2 but was available as a PECL extension before that.

There are two versions of the sodium API - a namespaced API (v2) wherein functions look like `\Sodium\bin2hex()` and a non-namespaced API (v1) wherein functions look like `sodium_bin2hex()`. PHP 7.2+ uses v2, which is also what php.net documents. v1 documentation can be found here:

https://github.com/paragonie/pecl-libsodium-doc/blob/v1/chapters/01-quick-start.md

According to [Which Version of [libsodium] Should I Install?](https://paragonie.com/book/pecl-libsodium/read/00-intro.md#extension-versions) v2 is supported on PHP 7.0+ whereas v1 is supported on PHP 5.4 - 7.1.

The PHP 7.0 and 7.1 containers included in this repo use v2. The PHP 5.6 container uses v1. The PHP 5.4 and 5.5 containers do not contain libsodium due to compilation errors I was getting. If you're able to get libsodium working in these versions of PHP feel free to submit a pull request.

**mcrypt**

This extension was deprecated in PHP 7.1.0 and removed (moved to PECL) in PHP 7.2.0. All of the PHP Docker containers have it installed.

**OpenSSL**

All Docker containers have OpenSSL installed but, it may be interesting to note that functions like [openssl_encrypt](https://www.php.net/openssl-encrypt) were not available to PHP until PHP 5.3.0.

**Other PECL extensions**

By and large, PECL extensions that _might_ be of some relevance to phpseclib are _not_ included.

For example, [big_int](https://pecl.php.net/package/big-int) is not included, even though it's an extension that phpseclib _could_ make use of. The fact that it hasn't had a release since 2005 (and as such is likely not PHP7 compatible) notwithstanding the impression I get is that it is probably installed on about 0% of production PHP environments (probably even during it's heyday).

libsodium is an exception to this because libsodium went on to become a core PHP extension and because phpseclib has made use of v1 of the sodium API since phpseclib v2.0.0 (released in January 2016). Supporting it on PHP 5.4 and 5.5 is not a high priority since I imagine the production environment penetration of libsodium on those PHP versions is approaching 0%.

mcrypt is an exception to this because mcrypt used to be a core extension and because, even in PHP 7.3, I suspect the production environment penetration is still fairly high, due to all those old legacy code bases that still use it.

**To Do**

(in order of priority)

- implementing some [testing](https://docs.docker.com/docker-hub/builds/automated-testing/).
- providing [i386 Ubuntu builds](https://hub.docker.com/r/i386/ubuntu/)
- getting libssh2 working on PHP 4.4, 5.0, 5.1 and 5.2
- getting libsodium working on PHP 5.4 and 5.5
