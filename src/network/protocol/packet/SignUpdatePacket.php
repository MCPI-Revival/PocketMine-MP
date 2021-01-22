<?php

/**
 *
 *  ____            _        _   __  __ _                  __  __ ____  
 * |  _ \ ___   ___| | _____| |_|  \/  (_)_ __   ___      |  \/  |  _ \ 
 * | |_) / _ \ / __| |/ / _ \ __| |\/| | | '_ \ / _ \_____| |\/| | |_) |
 * |  __/ (_) | (__|   <  __/ |_| |  | | | | | |  __/_____| |  | |  __/ 
 * |_|   \___/ \___|_|\_\___|\__|_|  |_|_|_| |_|\___|     |_|  |_|_| 
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * @author PocketMine Team
 * @link http://www.pocketmine.net/
 * 
 *
*/

class ESignUpdatePacket extends RakNetDataPacket{
	public $x;
	public $y;
	public $z;

	public $line1;
	public $line2;
	public $line3;
	public $line4;
	
	public function pid(){
		return ProtocolInfo::SIGN_UPDATE_PACKET;
	}
	
	public function decode(){
		$this->x = $this->getShort();
		$this->y = $this->getByte();
		$this->z = $this->getShort();
		$this->line1 = $this->getString();
		$this->line2 = $this->getString();
		$this->line3 = $this->getString();
		$this->line4 = $this->getString();
	}
	
	public function encode(){
		$this->reset();
		$this->putShort($this->x);
		$this->putByte($this->y);
		$this->putShort($this->z);
		$this->putString($this->line1);
		$this->putString($this->line2);
		$this->putString($this->line3);
		$this->putString($this->line4);
	}

}