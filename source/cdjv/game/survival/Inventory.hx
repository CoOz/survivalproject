package cdjv.game.survival;

class Inventory extends FlxSprite{

	public function new(){
			super();
		super.create();
	}

	public function registerEvents():Void{

	}

	override public function destroy():Void{
        super.destroy();
	}

	override public function update():Void{
        trace("coucou");
        super.update();
    }

}
