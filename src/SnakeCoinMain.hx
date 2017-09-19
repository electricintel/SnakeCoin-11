package;
import tink.http.Response.OutgoingResponse;
import tink.web.routing.Context;
import tink.web.routing.Router;


class SnakeCoinMain {

	static function main() {
		
		var router = new Router<Root>( new Root());
		
		var container = new tink.http.containers.NodeContainer( 5000 );
		container.run( function( req ) return router.route( Context.ofRequest( req )).recover( OutgoingResponse.reportError ));
		
		trace( "SnakeCoin server listening on http://localhost:5000/" );
	}
	
}