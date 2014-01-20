package cdjv.game.survival;

import flash.events.KeyboardEvent;
import flash.events.Event;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;

class Character extends FlxSprite{
    public var sceneJeu:PlayState;
    public var Control:Array<Bool>;
    public var cam:FlxCamera;
    public function new(scene:PlayState){
        super();
        Control=[false,false,false,false];  // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        this.sceneJeu=scene;
        loadGraphic("assets/images/char.png",true,false,32,48,false,null);
        animation.add("walk_Front",[0,1,2,3],4,true);
        animation.add("walk_Left",[4,5,6,7],4,true);
        animation.add("walk_Right",[8,9,10,11],4,true);
        animation.add("walk_Back",[12,13,14,15],4,true);
        this.registerEvents();
    }

    public function registerEvents():Void{
        FlxG.game.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
        FlxG.game.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);

    }

     public function onKeyDown(evt:KeyboardEvent):Void{
        if(evt.keyCode == flash.ui.Keyboard.Z)
            Control[0]=true;
        if(evt.keyCode == flash.ui.Keyboard.D)
            Control[1]=true;
        if(evt.keyCode == flash.ui.Keyboard.S)
            Control[2]=true;
        if(evt.keyCode == flash.ui.Keyboard.Q)
            Control[3]=true;
    }
    public function onKeyUp(evt:KeyboardEvent):Void{
        if(evt.keyCode == flash.ui.Keyboard.Z)
            Control[0]=false;
        if(evt.keyCode == flash.ui.Keyboard.D)
            Control[1]=false;
        if(evt.keyCode == flash.ui.Keyboard.S)
            Control[2]=false;
        if(evt.keyCode == flash.ui.Keyboard.Q)
            Control[3]=false;
    }
    public function direction ():Void{
        if(Control[0] && !Control[1] && !Control[2] && !Control[3])         // aller vers le haut
        {
            velocity.x = 0;
            velocity.y = -100;
            animation.play("walk_Back");
        }
        else if(!Control[0] && !Control[1] && Control[2] && !Control[3])         // aller vers le bas
        {
            velocity.x = 0;
            velocity.y = 100;
            animation.play("walk_Front");
        }
        else if(!Control[0] && Control[1] && !Control[2] && !Control[3])         // aller vers la droite
        {
            velocity.x = 100;
            velocity.y = 0;
            animation.play("walk_Right");
        }
        else if(!Control[0] && !Control[1] && !Control[2] && Control[3])         // aller vers la gauche
        {
            velocity.x = -100;
            velocity.y = 0;
            animation.play("walk_Left");
        }
        else if(Control[0] && Control[1] && !Control[2] && !Control[3])            // aller en haut a droite
        {
            velocity.x =  100;
            velocity.y = -100;
            //animation.play("walk_Back_Right")
        }
        else if(Control[0] && !Control[1] && !Control[2] && Control[3])             // aller en haut a gauche
        {
            velocity.x = -100;
            velocity.y = -100;
            //animation.play("walk_Back_Left")
        }
        else if(!Control[0] && Control[1] && Control[2] && !Control[3])             // aller en bas a droite
        {
            velocity.x =  100;
            velocity.y =  100;
            //animation.play("walk_Front_Right")
        }
        else if(!Control[0] && !Control[1] && Control[2] && Control[3])             // aller en bas a gauche
        {
            velocity.x = -100;
            velocity.y =  100;
            //animation.play("walk_Front_Right")
        }
        else
        {
            velocity.x=0;
            velocity.y=0;
            animation.pause();
        }
    }

    override public function update():Void{
        direction();
        super.update();
    }
/*
    public function onKeyDown(evt:KeyboardEvent):Void{
        if(evt.keyCode == flash.ui.Keyboard.D)
        {
            this.velocity.x= 100;
            this.animation.play("walk_Right");
        }
        else if(evt.keyCode == flash.ui.Keyboard.Q)
        {
            velocity.x= -100;  
            this.animation.play("walk_Left");      
        }

        if(evt.keyCode == flash.ui.Keyboard.Z)
            {
                velocity.y= - 100;
                this.animation.play("walk_Back");
            }
        else if(evt.keyCode == flash.ui.Keyboard.S)
            {
                this.velocity.y= 100;
                this.animation.play("walk_Front");
            }

    }
    public function onKeyUp(evt:KeyboardEvent):Void{
      if(evt.keyCode== flash.ui.Keyboard.Z)
      {
            this.animation.frameIndex=12;
            velocity.y=0;
      }
     if(evt.keyCode== flash.ui.Keyboard.S)
      {
            this.animation.frameIndex=0;
            velocity.y=0;
      }
    if(evt.keyCode== flash.ui.Keyboard.D)
      {
            this.animation.frameIndex=9;
            velocity.x=0;
      }
    if(evt.keyCode== flash.ui.Keyboard.Q)
      {
            this.animation.frameIndex=4;
            velocity.x=0;
      }
       //sceneJeu.surface.digMap.creuse(x,y);
    }
*/

}