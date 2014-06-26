var http = require('http');
var sockjs = require('sockjs');
var connManager= require('./connmanager.js');
var character=require('./character.js');

var joueurs={};

var echo = sockjs.createServer();
echo.on('connection', function(conn) {
    console.log("+connexion");
    conn.on('data', function(message) {
        switch(message.charAt(0)){
        	case 'l':
        		var login=message.substring(1);
        		if(joueurs[login]===undefined)
        			joueurs[login]=conn;
        		console.log("login "+login);
        		//conn.write('l');
                conn['user']=new character(0,0,login);
                console.log(conn['user']);
                connManager.addConn(conn);
        		break;
            case 'p':
                console.log(conn['user']);
                if(conn['user']!==undefined){
                    conn['user'].setPos(message.substring(1).split(';')[0],message.substring(1).split(';')[1]);
                }else{
                    //TODO:gérer
                }
                break;
        	default:
        		console.log('paquet inconnu '+message);
        		break;
        }
    });
    conn.on('close', function() {});
});

var server = http.createServer();
echo.installHandlers(server, {prefix:'/survival'});
server.listen(9999, '0.0.0.0');

function sendToAll(message){

}
