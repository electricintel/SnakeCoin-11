package data;
import haxe.Json;
import haxe.crypto.Sha256;


class Block {

	public var index:Int;
	public var timestamp:Float;
	public var data:BlockData;
	public var previousHash:String;
	public var hash:String;
	
	public function new( index:Int, data:BlockData, previousHash:String ) {
		
		this.index = index;
		this.timestamp = Date.now().getTime();
		this.data = data;
		this.previousHash = previousHash;
		this.hash = generateHash();
	}
	
	public function generateHash():String {
		return Sha256.encode( Std.string( this ));
	}
	
	public function toString():String {
		return 'index: ${Std.string( index )}\ntime: ${Std.string( timestamp )}\ndata: ${Std.string( data )}\nhash: $hash';
	}
}