package cdjv.game.survival;

import flixel.util.FlxPoint;
import flash.events.KeyboardEvent;
import flash.events.Event;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxTimer;

import flixel.FlxObject;

import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.ui.*;
import flixel.util.*;
import flixel.ui.FlxBar;
import flixel.util.FlxRandom;


class Bot extends FlxSprite{

	public var nombot:String;
	var displayname:FlxText;
	public var moveTime:FlxTimer;
	public var randnb: Int;
	public var control:Array<Bool>;

    public function new(scene:PlayState, nombot:String, posx:Int, posy:Int){
        super();
        control=[false,false,false,false];      // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        this.nombot=nombot;
        displayname=new FlxText(Std.int(FlxG.width/4),20,80);
        displayname.alignment="left";
        displayname.color=0x00000000;
        displayname.text=nombot;
        scene.add(displayname);

        control=[false,false,false,false];      // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche

        this.angle=90;
        maxVelocity.x=100;
        maxVelocity.y=100;
        this.x=posx;
        this.y=posy;

        loadGraphic("assets/images/Bot.png",true,false,63,64,false,null);
        centerOffsets;
        scene.add(this);

        animation.add("walk",[0,1,2,3,4,5,6],12,true);

        moveTime=FlxTimer.start(5);

    }

    public function move ():Void
    {
        if(control[0] && !control[1] && !control[2] && !control[3]){         // aller vers le haut
            this.angle=-90;
            animation.play("walk");         
            velocity.x=0;
            velocity.y=-maxVelocity.y;
        }
        else if(!control[0] && !control[1] && control[2] && !control[3]){         // aller vers le bas
            this.angle=90;
            animation.play("walk");  
            velocity.x = 0;
            velocity.y = maxVelocity.y;
        }

        else if(!control[0] && control[1] && !control[2] && !control[3]){         // aller vers la droite
            this.angle=0;
            animation.play("walk");  
            velocity.x = maxVelocity.x;
            velocity.y = 0;
        }

        else if(!control[0] && !control[1] && !control[2] && control[3]){         // aller vers la gauche
            this.angle=180;
            animation.play("walk");  
            velocity.x = -maxVelocity.x;
            velocity.y = 0;
        }

        else if(control[0] && control[1] && !control[2] && !control[3]){            // aller en haut a droite
            this.angle=-45;
            animation.play("walk");  
            velocity.x =  maxVelocity.x;
            velocity.y = -maxVelocity.y;
        }

        else if(control[0] && !control[1] && !control[2] && control[3]){             // aller en haut a gauche
            this.angle=-125;
            animation.play("walk");  
            velocity.x = -maxVelocity.x;
            velocity.y = -maxVelocity.y; 
        }

        else if(!control[0] && control[1] && control[2] && !control[3]){             // aller en bas a droite
            this.angle=45;
            animation.play("walk");  
            velocity.x = maxVelocity.x;
            velocity.y = maxVelocity.y;
        }

        else if(!control[0] && !control[1] && control[2] && control[3])             // aller en bas a gauche
        {
            this.angle=125;
            animation.play("walk");  
            velocity.x = -maxVelocity.x;
            velocity.y =  maxVelocity.y;
        }
        else
        {
            velocity.x=0;
            velocity.y=0;
            this.animation.frameIndex=0;
            animation.pause();
        }
        choosedirection();
        moveTime=FlxTimer.recycle();
    }

    public function choosedirection():Void
    {
    	randnb=FlxRandom.intRanged(0, 7);
    	trace(randnb);
    	if(randnb==0)
    		control=[true,false,false,false];
    	else if (randnb==1)
    		control=[false,true,false,false];
    	else if (randnb==2)
    		control=[false,false,true,false];
    	else if (randnb==3)
    		control=[false,false,false,true];
    	else if (randnb==4)
    		control=[true,true,false,false];
    	else if (randnb==5)
    		control=[true,false,false,true];
    	else if (randnb==6)
    		control=[false,true,true,false];
    	else if (randnb==7)
    		control=[false,false,true,true];
    }

	override public function update():Void
	{
		if(moveTime.finished)
		   	move();
	    super.update();
	}

}