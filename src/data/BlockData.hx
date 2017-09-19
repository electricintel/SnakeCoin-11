package data;


class BlockData {
	
	public var proofOfWork:Int;
	public var transactions:List<data.Transaction>;
	
	public function new( proofOfWork:Int, transactions:List<data.Transaction> ) {
		
		this.proofOfWork = proofOfWork;
		this.transactions = transactions;
	}
	
	public function toString():String {
		return 'proofOfWork: $proofOfWork\ntransactions: ${transactions.toString()}';
	}
}