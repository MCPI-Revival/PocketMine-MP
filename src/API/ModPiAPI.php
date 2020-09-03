<?php

/*
 * ModPiAPI.php
 * 
 * Copyright 2020 Alvarito050506 <donfrutosgomez@gmail.com>
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */

class ModPiAPI
{
	private $__server;

	function __construct(PocketMinecraftServer $server)
	{
		$this->__server = $server;
	}
	
	public function init()
	{
		return 0;
	}

	public function sendto($command, $username)
	{
		$this->__server->handle("modpi.command", new Container($command, $username));
		return 0;
	}

	public function send($command)
	{
		$this->__server->handle("modpi.command", $command);
		return 0;
	}
}

?>
