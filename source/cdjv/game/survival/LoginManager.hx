package cdjv.game.survival;

import flash.events.KeyboardEvent;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
* A FlxState which can be used for the actual gameplay.
*/
class LoginManager extends FlxState{
	var login:String;
	var valid:Bool;
	override public function create():Void
	{

			valid=false;
			trace("valid");
			FlxG.cameras.bgColor = 0xff000000;
			trace("valid");
			FlxG.game.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			trace("valid");
	        super.create();
	}

	public function onKeyDown(evt:KeyboardEvent):Void{
		if(!valid)
		{
			if(evt.keyCode==flash.ui.Keyboard.ENTER)
				valid=true;
        	else
        		login+=evt.keyCode;
        }
    }

	/*public function loginOK():void{

	}*/

	override public function destroy():Void
	{
	        super.destroy();
	}
		override public function update():Void
	{
		if(valid)
	        trace(login);
		super.update();
	}
}

// FlxG.switchState(new PlayState(con));
// con = new Connectio();