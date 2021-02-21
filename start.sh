#!/bin/bash
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
if [ -f php/bin/php ]; then
./php/bin/php -d enable_dl=On PocketMine-MP.php $@
read -p "Press [Enter] to continue..."
exit 0
fi
php -d enable_dl=On PocketMine-MP.php $@
read -p "Press [Enter] to continue..."
exit 0
