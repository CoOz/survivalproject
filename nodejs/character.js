var character=function character(x,y){
	console.log("[char]+character "+x+" "+y)
	this.x=x;this.y=y;
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

module.exports=character;