package cdjv.game.survival;

import flixel.FlxState;
import flash.events.KeyboardEvent;
import flash.events.Event;
import flixel.FlxG;
import flixel.text.FlxText;
/**
* A FlxState which can be used for the actual gameplay.
*/
class LoginManager extends FlxState{
	var login:String;
	var afflogin:FlxText;
	var valid:Bool;
	var majactionner:Bool;
	override public function create():Void
	{
			login="";
			valid=false;
			FlxG.cameras.bgColor = 0xff000000;
			this.bgColor=0x00000000;
			afflogin = new FlxText (FlxG.width/2, FlxG.height/2, FlxG.width); 
			afflogin.alignment="left";
       		afflogin.color=0x00000020;
			FlxG.game.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			FlxG.game.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			this.add(afflogin);
	        super.create();
	}

    public function onKeyUp(evt:KeyboardEvent):Void{
    	if(evt.keyCode==flash.ui.Keyboard.SHIFT)
    	{
    		majactionner=false;
    	}
    }

	public function onKeyDown(evt:KeyboardEvent):Void{
		if(!valid)
		{
			if(evt.keyCode==flash.ui.Keyboard.ENTER && login.length>0)
			{
				var connex:Connexion;
				connex = new Connexion();
				connex.sLogin(login);
				FlxG.switchState(new PlayState(login));
			}
			else if(evt.keyCode==flash.ui.Keyboard.BACKSPACE && login.length>0)
			{ 
				login=login.substr(0,login.length-1);
				trace(login);
				afflogin.text=login.substr(0,login.length-1);
			}
        	else
        	{
        		if(majactionner=true)
        		{
        			login+=String.fromCharCode(evt.keyCode);
        			afflogin.text+=String.fromCharCode(evt.keyCode);
        		}

        		else
        		{
        			login+=String.fromCharCode(evt.keyCode);
        			afflogin.text+=String.fromCharCode(evt.keyCode+32);	
        		}
        	}
        	if(evt.keyCode==flash.ui.Keyboard.SHIFT)
        	{
        		majactionner=true;
        	}
        }
    }

	public function loginOK(){
		trace("Login Ok!");
	}

	override public function destroy():Void
	{
	    super.destroy();
	}
		override public function update():Void
	{
		super.update();
	}
}

// FlxG.switchState(new PlayState(con));
// con = new Connectio();