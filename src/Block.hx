package;
import haxe.Json;
import haxe.crypto.Sha256;


class Block {

	public var index:Int;
	public var timestamp:Float;
	public var data:String;
	public var previousHash:String;
	public var hash:String;
	
	public function new( index:Int, data:String, previousHash:String ) {
		
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
		return Std.string( index ) + Std.string( timestamp ) + data + previousHash;
	}
}