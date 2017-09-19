package;
import data.Block;
import data.BlockData;
import data.HTMLCode;
import data.Transaction;
import tink.http.Header.HeaderField;
import tink.http.Request.OutgoingRequestHeader;
import tink.http.Response.OutgoingResponse;
import tink.http.Response.ResponseHeader;

using tink.CoreApi;

class Root {
	
	var minerAddress = "Ben";
	
	var blockchain = new List<Block>();
	var nodesTransactions = new List<Transaction>();
	// Store the url data of every
	// other node in the network
	// so that we can communicate
	// with them
	var peerNodes:Array<String> = [];
	var mining = true;
	
	public function new() {
		
		// Create the blockchain and add the genesis block
		blockchain.add( createGenesisBlock() );
		var previousBlock = blockchain.last();
		
	}	
	
	// check if server is running
	// curl.exe http://localhost:5000
	@:get( '/' )
	public function index():String {
		  return 'SnakeCoin server listening on http://localhost:5000/\n';
	}
	
	// html form to send a transaction
	// http://localhost:5000/txion
	@:get( '/txion' )
	public function transactionHtml():OutgoingResponse {
		return new OutgoingResponse( new ResponseHeader( 200, "ok", [ new HeaderField('Content-Type', 'text/html'), new HeaderField('Content-Length', Std.string(HTMLCode.transaction.length)) ] ), HTMLCode.transaction );
	}
	
	// send transaction
	
	// curl verison not working on windows 10 commandline or powershell
	// command shoud be
	// curl.exe -H "Content-Type: application/json" -d "{'from': 'akjflw', 'to':'fjlakdj', 'amount': 3}" localhost:5000/txion
	@:post( '/txion' )
	public function txion( body: { from:String, to:String, amount:Int } ):String {
		
		var transaction = new Transaction( body.from, body.to, body.amount );
		nodesTransactions.add( transaction );
		var responseText = '\nNew transaction\nfrom: ${transaction.from}\nto: ${transaction.to}\namount: ${transaction.amount}\nSubmission successful';
		trace( responseText );
		return responseText;
	}
		
	// mine a block
	// curl.exe http://localhost:5000/mine
	@:get( '/mine' )
	public function mine():String {
		
		// Get the last proof of work
		var lastBlock = blockchain.last();
		var lastProof = lastBlock.data.proofOfWork;
		
		// Find the proof of work for
		// the current block being mined
		// Note: The program will hang here until a new
		//       proof of work is found
		var proof = proofOfWork( lastProof );
		
		// Once we find a valid proof of work,
		// we know we can mine a block so 
		// we reward the miner by adding a transaction
		nodesTransactions.add( new Transaction( "network", minerAddress, 1 ));
		
		// Now we can gather the data needed
		// to create the new block
		var transactionsCopy = new List<Transaction>();
		for ( transaction in nodesTransactions ) {
			transactionsCopy.add( transaction );
		}
		var newBlockData = new BlockData( proof, transactionsCopy );
		var newBlockIndex = lastBlock.index + 1;
		var lastBlockHash = lastBlock.hash;
		
		// Empty transaction list
		nodesTransactions.clear();
		
		// Now create the
		// new block!
		
		var minedBlock = new Block( newBlockIndex, newBlockData, lastBlockHash );
		blockchain.add( minedBlock );
		
		trace( '\nnew block: ${minedBlock.toString()}' );
		// Let the client know we mined a block
		return minedBlock.toString();
	}
		
	@:get( '/blocks' )
	public function blocks():String {
		
		var chainToSend = [];
		for ( block in blockchain ) {
			
			var jsonBlock = {
				'index' : block.index,
				'timestamp' : block.timestamp,
				'data' : block.data,
				'hash' : block.hash,
			}
			chainToSend.push( jsonBlock );
		}
		
		return Std.string( chainToSend );
	}
	
	function createGenesisBlock():Block {
		
		// Manually construct a block with
		// index zero and arbitrary previous hash
		
		var genesisProofOfWork = 9;
		var genesisTransactions = new List<Transaction>();
		
		return new Block( 0, new BlockData( genesisProofOfWork, genesisTransactions ), "0" );
	}
	
	function proofOfWork( lastProof:Int ):Int {
		
		// Create a variable that we will use to find
		// our next proof of work
		var incrementor = lastProof + 1;
		
		// Keep incrementing the incrementor until
		// it's equal to a number divisible by 9
		// and the proof of work of the previous
		// block in the chain
		while ( !( incrementor % 9 == 0 && incrementor % lastProof == 0 )) {
			incrementor += 1;
		}
		
		// Once that number is found,
		// we can return it as a proof
		// of our work
		return incrementor;
	}
	
}