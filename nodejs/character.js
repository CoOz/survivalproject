var crypto = require('crypto');

var character=function character(x,y,pseudo){
	console.log("[char]+character "+x+" "+y)
	this.x=x;this.y=y;
	this.pseudo=pseudo;
	var md5 = crypto.createHash('md5');
	this.id=md5.update(pseudo).digest("hex");
};

character.prototype.getZone = function() {
	if(this.x < 0 && this.y < 0)
        return([parseInt((this.x-800)/800), parseInt((this.y-600)/600)]);
	if(this.x < 0)
		return([parseInt((this.x-800)/800), parseInt(this.y/600)]);
	if(this.y < 0)
		return([parseInt(this.x/800),parseInt((this.y-600)/600)]);
	return([parseInt(this.x/800),parseInt(this.y/600)]); 
};

character.prototype.setPos = function(x,y) {
	console.log("[char]pos "+x+" "+y)
	this.x=x;this.y=y;
};

character.prototype.setVelocity = function(velx,vely) {
	console.log("[char]velocity"+velx+" "+vely);
	this.velox=velx;
	this.veloy=vely;
}

character.prototype.getJString = function(){
	return this.id+';'+this.pseudo+';'+this.x+';'+this.y;
}

module.exports=character;