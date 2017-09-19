package data;


class Transaction {
	
	public var from:String;
	public var to:String;
	public var amount:Int;

	public function new( from:String, to:String, amount:Int ) {
		
		this.from = from;
		this.to = to;
		this.amount = amount;
		
	}
	
	public function toString():String {
		return '$amount coins from $from to $to';
	}
}