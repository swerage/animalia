var express = require( 'express' );
var app     = express();

app.engine( 'html', require('jade').__express );

app.use( express.static( __dirname + '/dist' ));

app.get( '/', function( req, res ){
    res.render( 'index.html' );
});

app.listen( 3000 );
console.log( 'Listening on port 3000' );