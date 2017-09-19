package;

import haxe.crypto.Sha256;
import neko.Lib;

class SnakeCoinMain {
	
	static function main() {
		
		new SnakeCoinMain();
	}
	
	function createGenesisBlock():Block {
		
		// Manually construct a block with
		// index zero and arbitrary previous hash
		return new Block( 0, 'Genesis Block', "0" );
	}
	
	function nextBlock( lastBlock:Block ):Block {
		
		var index = lastBlock.index + 1;
		var data = "Hey! I'm block " + Std.string( index );
		var previousHash = lastBlock.hash;
		
		return new Block( index, data, previousHash );
	}
	
	public function new() {
		
		// Create the blockchain and add the genesis block
		var blockchain = [ createGenesisBlock() ];
		var prevousBlock = blockchain[0];
		
		// How many blocks should we add to the chain
		// after the genesis block
		var numOfBlocksToAdd = 5;
		
		// Add blocks to the chain
		for ( i in 0...numOfBlocksToAdd ) {
			
			var blockToAdd = nextBlock( prevousBlock );
			blockchain.push( blockToAdd );
			prevousBlock = blockToAdd;
			
			// Tell everyone about it!
			trace( 'Block #${blockToAdd.index} has been added to the blockchain!' );
			trace( 'Hash ${blockToAdd.hash}\n' );
		}
		
	}
	
}