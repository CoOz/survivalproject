package cdjv.game.survival;

import flixel.FlxState;
import flixel.FlxSprite;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.events.Event;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.ui.FlxTypedButton;
import flixel.util.*;
import flash.display.Graphics;
/**
* A FlxState which can be used for the actual gameplay.
*/
class LoginManager extends FlxState{
	var login:String;
	var afflogin:FlxText;
	var messlogin:FlxText;
	var bgimage:FlxSprite;
	var rectlog:FlxSprite;

	static var tempsconnex=10;
	public var timerconnex:FlxTimer;

	var valid:Bool;
	var majactionner:Bool;
	var boutonvalid: FlxButton;
	var connex:Connexion;

	override public function create():Void
	{		
			bgimage=new FlxSprite();
        	bgimage.loadGraphic("assets/images/pagelogin.jpg",true,false,640,480,false,null);
        	bgimage.x=(FlxG.width-bgimage.width)/2;
        	bgimage.y=(FlxG.height-bgimage.height)/2;

        	this.bgColor = FlxColor.BLACK;
			FlxG.cameras.bgColor = 0xff000000;

			boutonvalid = new FlxButton(FlxG.width/2, FlxG.height, "Connexion", validationlog); //new(?X : Float, ?Y : Float, ?Label : String, ?OnClick : Void -> Void)
			boutonvalid.x = FlxG.width/2-boutonvalid.width/3;
			boutonvalid.y =  FlxG.height*5/6-boutonvalid.height;

			login="";
			valid=false;
			majactionner=false;


			afflogin = new FlxText (280, 410, FlxG.width);
			afflogin.size = 11;
       		afflogin.color = FlxColor.BLUE;

       		messlogin = new FlxText(320, 560, FlxG.width);
       		messlogin.size = 12;

			FlxG.game.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			FlxG.game.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			
			this.add(bgimage);
			this.add(afflogin);
			this.add(messlogin);
			this.add(boutonvalid);

	        super.create();
	}

    public function onKeyUp(evt:KeyboardEvent):Void{
    	if(evt.keyCode==flash.ui.Keyboard.SHIFT)
    	{
    		majactionner=false;
    	}
	   	if(evt.keyCode==flash.ui.Keyboard.CAPS_LOCK)
       	{
       		majactionner=false;
       	}
    }

	public function onKeyDown(evt:KeyboardEvent):Void{
		if(!valid)
		{
			if(evt.keyCode==flash.ui.Keyboard.ENTER){
					validationlog();
			}
			else if(evt.keyCode==flash.ui.Keyboard.BACKSPACE && login.length>0)
			{ 
				var flag:Int;
				var newlog:String;
				newlog="";
				flag=0;
				while(flag<(login.length-1))
				{
					newlog+=login.charAt(flag);
					flag++;
				}
				login=newlog;
				afflogin.text=login;
			}	
        	else if(64<evt.keyCode&&evt.keyCode<91)
        	{
        		if(majactionner==true)
        		{
        			login+=String.fromCharCode(evt.keyCode);
        			afflogin.text+=String.fromCharCode(evt.keyCode);
        		}

        		else
        		{
        			login+=String.fromCharCode(evt.keyCode+32);
        			afflogin.text+=String.fromCharCode(evt.keyCode+32);	
        		}
        	}
        	if(evt.keyCode==flash.ui.Keyboard.SHIFT)
        	{
        		majactionner=true;
        	}
        	if(evt.keyCode==flash.ui.Keyboard.CAPS_LOCK)
        	{
        		majactionner=true;
        	}
        }
    }

    public function validationlog():Void
    {
               /* trace("\n\n ====================== \n ===== Login Ok ! ===== \n ======================= \n\n\n");
        FlxG.switchState(new PlayState(login));*/
    	if(login.length>0)
    	{
    		connex = new Connexion();
    		valid=true;  
    		messlogin.color=FlxColor.BLUE ;
    		messlogin.x=320;
    		messlogin.y=560;
    		messlogin.text="connexion en cours...";
    		timerconnex=FlxTimer.start(tempsconnex);				
    		connex.sLogin(login);
    	}
    	else
    	{
    		messlogin.x=340;
    		messlogin.y=560;
			messlogin.color = FlxColor.RED;
      		messlogin.text="Login Incorrect"; 
    	}
    }
    
    public function checktimerconnex()
    {
    	if(valid)
    	{
    		if(timerconnex.finished)
    		{
				messlogin.color = FlxColor.RED;
				messlogin.x=290;
    			messlogin.y=560;
      			messlogin.text="Erreur: Le serveur ne repond pas";
    		}
    	}
    }

	public function loginOK(){
        trace("\n\n ====================== \n ===== Login Ok ! ===== \n ======================== \n\n\n");
		FlxG.switchState(new PlayState(login));
	}

	override public function destroy():Void
	{
	    super.destroy();
	}
		override public function update():Void
	{
		checktimerconnex();
		super.update();
	}
}

// FlxG.switchState(new PlayState(con));
// con = new Connection();