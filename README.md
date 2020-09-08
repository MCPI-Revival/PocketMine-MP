![](http://shoghicp.github.com/PocketMine-MP/favicon.png)

# PocketMine-MP

Minecraft Pi enchanced compatibility branch.

```
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```	

PocketMine-MP is a Server for Minecraft Pocket Edition. It has a Plugin API that enables a developer to extend it and add new features, or change default ones. The entire server is written in PHP, and has been tested, profiled and optimized to run smoothly.

This is a fork of the [v1.2.2 Alpha](https://github.com/PocketMine-MP/PocketMine-MP/releases/Alpha_1.2.2) release, the only compatible with all the game modes of Minecraft Pi, to enchance and extend the compatibility with MCPI and its mods.

## Supported extensions
The following is a list of supported extensions to the Minecraft Pi protocol, provided by the ModPi API.

### Command Packet
An encapsulated packet that contains one or more MCPI API commands. When is sent to a client, ModPi executes its content.

### Client Secrets
When the last byte (`"unknown2"` field) of a normal Client Connect (`0x09`) packet is not `NULL`, it means that the client is sending a "secret", a 32-bit random and persistent number. This, plus the username, could be used to identify client stronger. However, this currently does not provide any real security, but there are plans to improve it.

If a secret is sent, it will be stored in the `Player`'s `secret` property.

**Do you have an idea for an extension?** Pull Request and Issues are welcome! ~~And sorry for this bad documentation.~~

## Third-party Libraries Used
* **[PHP Sockets](http://php.net/manual/en/book.sockets.php)**
* **[PHP SQLite3](http://php.net/manual/en/book.sqlite3.php)**
* **[cURL](http://curl.haxx.se/)**: cURL is a command line tool for transferring data with URL syntax
* **[GMP](http://gmplib.org/)**: Arithmetic without limitations
* **[Zlib](http://www.zlib.net/)**: A Massively Spiffy Yet Delicately Unobtrusive Compression Library
* **[PHP pthreads](https://github.com/krakjoe/pthreads)** by _[krakjoe](https://github.com/krakjoe)_: Threading for PHP - Share Nothing, Do Everything.
* **[PHP NBT](https://github.com/TheFrozenFire/PHP-NBT-Decoder-Encoder/blob/master/nbt.class.php)** by _[TheFrozenFire](https://github.com/TheFrozenFire)_: Class for reading in NBT-format files (modified to handle Little-Endian files).
* **[Spyc](https://github.com/mustangostang/spyc/blob/master/Spyc.php)** by _[Vlad Andersen](https://github.com/mustangostang)_: A simple YAML loader/dumper class for PHP.
* **[ANSICON](https://github.com/adoxa/ansicon)** by _[Jason Hood](https://github.com/adoxa)_: Process ANSI escape sequences for Windows console programs.
