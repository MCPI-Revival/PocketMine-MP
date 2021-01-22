#!/bin/bash
DIR="$(cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
cd "${DIR}"
if [ -f ./php/bin/php ]; then
	exec ./php/bin/php -d enable_dl=On PocketMine-MP.php $@
else
	echo "[WARNING] You are not using the standalone PocketMine-MP PHP binary."
	exec php -d enable_dl=On PocketMine-MP.php $@
fi
