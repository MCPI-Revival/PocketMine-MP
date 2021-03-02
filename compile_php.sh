#!/bin/sh

set -e

# PHP Version
PHP_VERSION='7.4.14'
ZEND_VM='GOTO'

# Versions
ZLIB_VERSION='1.2.11'
GMP_VERSION='6.2.1'
PTHREADS_VERSION="fa08597173d9fb7ace03d01136c5680937981b87"
CURL_VERSION='curl-7_74_0'
PHPYAML_VERSION='2.2.1'
YAML_VERSION='0.2.5'

echo '[PocketMine] PHP installer and compiler for Linux & Mac - by @shoghicp'
DIR="$(pwd)"

# Check
echo '[INFO] Checking dependecies'
check() {
    type "$1" > /dev/null 2>&1 || { echo >&2 "[ERROR] Please install \"$1\""; exit 1; }
}
check make
check autoconf
check automake
check libtool
check libtool-bin
check gcc
check m4
check libxml2-dev
check pkg-config
check libsqlite3-dev
check zlib1g-dev
check libcurl4-openssl-dev

# Prepare
rm -f install.log
rm -rf install_data
rm -rf php
touch install.log
mkdir -m 0777 install_data
mkdir -m 0777 php
cd install_data

# Download PHP
echo -n "[PHP] downloading ${PHP_VERSION}..."
wget "https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz" -q -O - | tar -zx >> "${DIR}/install.log" 2>&1
mv "php-${PHP_VERSION}" php
echo ' done!'

# ZLib
echo -n "[zlib] downloading ${ZLIB_VERSION}..."
wget "http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz" -q -O - | tar -zx >> "${DIR}/install.log" 2>&1
mv "zlib-${ZLIB_VERSION}" zlib
echo -n ' checking...'
cd zlib
./configure \
    --prefix="${DIR}/install_data/php/ext/zlib" \
    --static \
    >> "${DIR}/install.log" 2>&1
echo -n ' compiling...'
make >> "${DIR}/install.log" 2>&1
echo -n ' installing...'
make install >> "${DIR}/install.log" 2>&1
echo -n ' cleaning...'
cd ..
rm -rf ./zlib
echo ' done!'

# GMP
echo -n "[GMP] downloading ${GMP_VERSION}..."
wget "https://gmplib.org/download/gmp/gmp-${GMP_VERSION}.tar.xz" -q -O - | tar -Jx >> "${DIR}/install.log" 2>&1
mv "gmp-${GMP_VERSION}" gmp
echo -n ' checking...'
cd gmp
./configure \
    --prefix="${DIR}/install_data/php/ext/gmp" \
    --disable-assembly \
    --disable-shared \
    >> "${DIR}/install.log" 2>&1
echo -n ' compiling...'
make >> "${DIR}/install.log" 2>&1
echo -n ' installing...'
make install >> "${DIR}/install.log" 2>&1
echo -n ' cleaning...'
cd ..
rm -rf ./gmp
echo ' done!'

# cURL
echo -n "[cURL] downloading ${CURL_VERSION}..."
wget "https://github.com/curl/curl/archive/${CURL_VERSION}.tar.gz" --no-check-certificate -q -O - | tar -zx >> "${DIR}/install.log" 2>&1
mv "curl-${CURL_VERSION}" curl
echo -n ' checking...'
cd curl
./buildconf >> "${DIR}/install.log" 2>&1
./configure \
    --prefix="${DIR}/install_data/php/ext/curl" \
    --disable-shared >> "${DIR}/install.log" 2>&1
echo -n ' compiling...'
make >> "${DIR}/install.log" 2>&1
echo -n ' installing...'
make install >> "${DIR}/install.log" 2>&1
echo -n ' cleaning...'
cd ..
rm -rf ./curl
echo ' done!'

# PThreads
echo -n "[PHP pthreads] downloading ${PTHREADS_VERSION}..."
wget "https://github.com/pmmp/pthreads/archive/${PTHREADS_VERSION}.tar.gz" --no-check-certificate -q -O - | tar -zx >> "${DIR}/install.log" 2>&1
mv "pthreads-${PTHREADS_VERSION}" "${DIR}/install_data/php/ext/pthreads"
echo ' done!'

# PHP YAML
echo -n "[PHP YAML] downloading ${PHPYAML_VERSION}..."
wget "http://pecl.php.net/get/yaml-$PHPYAML_VERSION.tgz" --no-check-certificate -q -O - | tar -zx >> "${DIR}/install.log" 2>&1
mv "yaml-${PHPYAML_VERSION}" "${DIR}/install_data/php/ext/yaml"
echo ' done!'

# YAML
echo -n "[YAML] downloading ${YAML_VERSION}..."
wget "http://pyyaml.org/download/libyaml/yaml-${YAML_VERSION}.tar.gz" --no-check-certificate -q -O - | tar -zx >> "${DIR}/install.log" 2>&1
mv "yaml-${YAML_VERSION}" yaml
echo -n ' checking...'
cd yaml
./configure \
    --prefix="${DIR}/install_data/php/ext/yaml" \
    --enable-static \
    --disable-shared \
    >> "${DIR}/install.log" 2>&1
echo -n ' compiling...'
make >> "${DIR}/install.log" 2>&1
echo -n ' installing...'
make install >> "${DIR}/install.log" 2>&1
echo -n ' cleaning...'
cd ..
rm -rf ./yaml
echo ' done!'

# Build PHP
echo -n '[PHP]'
set +e
MAX_MEMORY="$(free -m | awk '/^Mem:/{print $2}')"
if [ $MAX_MEMORY -gt 2048 ]; then
    echo -n ' enabling optimizations...'
    OPTIMIZATION='--enable-inline-optimization'
else
    OPTIMIZATION=''
fi
echo -n ' checking...'
cd php
rm -rf ./aclocal.m4 >> "${DIR}/install.log" 2>&1
rm -rf ./autom4te.cache  >> "${DIR}/install.log" 2>&1
rm -f ./configure >> "${DIR}/install.log" 2>&1
./buildconf --force >> "${DIR}/install.log" 2>&1
./configure \
    ${OPTIMIZATION} \
    --prefix="${DIR}/php" \
    --exec-prefix="${DIR}/php" \
    --enable-embedded-mysqli \
    --enable-bcmath \
    --with-gmp="${DIR}/install_data/php/ext/gmp" \
    --with-curl="${DIR}/install_data/php/ext/curl" \
    --with-zlib="${DIR}/install_data/php/ext/zlib" \
    --with-yaml="${DIR}/install_data/php/ext/yaml" \
    --disable-libxml \
    --disable-xml \
    --disable-dom \
    --disable-simplexml \
    --disable-xmlreader \
    --disable-xmlwriter \
    --without-pear \
    --disable-cgi \
    --disable-session \
    --enable-ctype \
    --without-iconv \
    --without-pdo-sqlite \
    --enable-sockets \
    --enable-shared=no \
    --enable-static=yes \
    --enable-pcntl \
    --enable-pthreads \
    --enable-maintainer-zts \
    --enable-zend-signals \
    --with-zend-vm="${ZEND_VM}" \
    --enable-cli \
    >> "${DIR}/install.log" 2>&1
echo -n ' compiling...'
make >> "${DIR}/install.log" 2>&1
echo -n ' installing...'
make install >> "${DIR}/install.log" 2>&1
echo ' done!'

# Clean Up
cd "${DIR}"
echo -n '[INFO] Cleaning up...'
rm -rf install_data/ >> "${DIR}/install.log" 2>&1
echo ' done!'
echo '[PocketMine] You should start the server now using "./start.sh"'
echo "[PocketMine] If it doesn't works, please send the \"install.log\" file to the Bug Tracker"
