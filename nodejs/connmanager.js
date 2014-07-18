exports.addConn=function(conn){
	conn.write('l');
	addToRoom(conn);
	exports.sendToNearConn(conn,'j['+conn['user'].getJString()+']');
	exports.sendNearPlayers(conn);
};
exports.removeConn=function(conn){

}
exports.updateConn=function(conn){

}
exports.sendToNearConn=function(conn,message){
	var zone=conn.user.getZone();
	var cle=zone[0]+';'+zone[1];
	exports.sendToZone(cle,message);
}
exports.sendToNearCoord=function(x,y,message){

}
exports.sendToNearVelocity=function(conn){
	exports.sendToNearConn(conn,'v['+conn['user'].velox+';'+conn['user'].veloy+']');
	exports.sendNearPlayers(conn);
}
exports.sendToZone=function(cle,message){
	for(address in exports.rooms[cle]){
		console.log(exports.rooms[cle][address]);
		exports.rooms[cle][address].write(message);
	}
}
exports.sendNearPlayers=function(conn){
	var zone=conn.user.getZone();
	var cle=zone[0]+';'+zone[1];
	var paquet="";
	for(address in exports.rooms[cle]){
		//console.log(exports.rooms[cle][address]);
		var player=exports.rooms[cle][address]['user'];
		if(player.id!==conn['user'].id){
			paquet+='['+player.getJString()+']';
		}
	}
	if(paquet!=='')
		conn.write('j'+paquet);
}

exports.rooms={};

function addToRoom(conn){
	var zone=conn.user.getZone();
	console.log(zone+" "+conn.remoteAddress+" "+exports.rooms.length);
	if(exports.rooms[zone[0]+';'+zone[1]]===undefined)
		exports.rooms[zone[0]+';'+zone[1]]={};
	exports.rooms[zone[0]+';'+zone[1]][conn.remoteAddress+':'+conn.remotePort]=conn;
}
//exports.roomMap=roomMap;