exports.addConn=function(conn){
	conn.write('l');
	addToRoom(conn);
	exports.sendToNearConn(conn,"test");
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
exports.sendToZone=function(cle,message){
	for(address in exports.rooms[cle]){
		console.log(exports.rooms[cle][address]);
		exports.rooms[cle][address].write(message);
	}
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