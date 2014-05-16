package cdjv.game.survival;

import flixel.FlxSprite;

class Inventory extends FlxSprite{

	public function new (scene: PlayState){
		super();
		loadGraphic("assets/images/charEquip.png",false,false,126,115,false,null);
		this.alpha=0;
		scene.add(this);
	}

	override public function destroy():Void{
        super.destroy();
	}

	override public function update():Void{
        super.update();
    }

}
