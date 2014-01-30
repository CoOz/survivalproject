package cdjv.game.survival;

import flash.events.KeyboardEvent;
import flash.events.Event;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.text.FlxText;

class Character extends FlxSprite{

    public var duringDigging:Bool;
    public var diggingFinish:Bool;
    public var inMoving:Bool;

    public var prevX:Int;
    public var prevY:Int;

    public var control:Array<Bool>;
    public var direction:Array<Bool>;

    public var displayCoord:FlxText;
    public var sceneJeu:PlayState;

    public function new(scene:PlayState){
        super();
        control=[false,false,false,false];      // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        direction=[true,false,false,false];    // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        displayCoord=new FlxText(Std.int(FlxG.width/4),20,80);
        displayCoord.alignment="left";
        displayCoord.color=0xFFFFFFFF;
        this.sceneJeu=scene;
        this.sceneJeu.add(displayCoord);
        loadGraphic("assets/images/char.png",true,false,32,48,false,null);

        /* Animation : */
        animation.add("walk_Front",[0,1,2,3],4,true);
        animation.add("walk_Left",[4,5,6,7],4,true);
        animation.add("walk_Right",[8,9,10,11],4,true);
        animation.add("walk_Back",[12,13,14,15],4,true);
        animation.add("walk_Front_Left",[16,17,18,19],4,true);
        animation.add("walk_Back_Left",[20,21,22,23],4,true);
        animation.add("walk_Front_Right",[24,25,26,27],4,true);
        animation.add("walk_Back_Right",[28,29,30,31],4,true);
        animation.add("dig_Front",[32,33,34,35],4,true);
        animation.add("dig_Left",[36,37,38,39],4,true);
        animation.add("dig_Right",[40,41,42,43],4,true);
        animation.add("dig_Back",[44,45,46,47],4,true);

        prevX=Std.int(x);
        prevY=Std.int(y);

        this.registerEvents();
    }

    public function registerEvents():Void{
        FlxG.game.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
        FlxG.game.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
        FlxG.game.stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN,onMousseDown);
        FlxG.game.stage.addEventListener(flash.events.MouseEvent.MOUSE_UP,onMousseUP);
    }

     public function onKeyDown(evt:KeyboardEvent):Void{
        if(evt.keyCode == flash.ui.Keyboard.Z)
            control[0]=true;
        if(evt.keyCode == flash.ui.Keyboard.D)
            control[1]=true;
        if(evt.keyCode == flash.ui.Keyboard.S)
            control[2]=true;
        if(evt.keyCode == flash.ui.Keyboard.Q)
            control[3]=true;
    }
    public function onKeyUp(evt:KeyboardEvent):Void{
        if(evt.keyCode == flash.ui.Keyboard.Z)
            control[0]=false;
        if(evt.keyCode == flash.ui.Keyboard.D)
            control[1]=false;
        if(evt.keyCode == flash.ui.Keyboard.S)
            control[2]=false;
        if(evt.keyCode == flash.ui.Keyboard.Q)
            control[3]=false;
    }
    public function onMousseDown(evt:flash.events.MouseEvent):Void{
        duringDigging=true;
        diggingAnimation();
        while((animation.frames!=35 || animation.frames!=39 || animation.frames!=43 || animation.frames!=47) && duringDigging==true){}
        diggingFinish=true;
        duringDigging=false;

    }
    public function onMousseUP(evt:flash.events.MouseEvent):Void{
        duringDigging=false;
    }
    public function move ():Void{
        if(control[0] && !control[1] && !control[2] && !control[3] && !duringDigging)         // aller vers le haut
        {
            velocity.x = 0;
            velocity.y = -100;
            direction[0]=true; direction[1]=false; direction[2]=false; direction[3]=false;
            animation.play("walk_Back");
        }
        else if(!control[0] && !control[1] && control[2] && !control[3] &&  !duringDigging)         // aller vers le bas
        {
            velocity.x = 0;
            velocity.y = 100;
            direction[0]=false; direction[1]=false; direction[2]=true; direction[3]=false;
            animation.play("walk_Front");
        }
        else if(!control[0] && control[1] && !control[2] && !control[3] &&  !duringDigging)         // aller vers la droite
        {
            velocity.x = 100;
            velocity.y = 0;
            direction[0]=false; direction[1]=true; direction[2]=false; direction[3]=false;
            animation.play("walk_Right");
        }
        else if(!control[0] && !control[1] && !control[2] && control[3] &&  !duringDigging)         // aller vers la gauche
        {
            velocity.x = -100;
            velocity.y = 0;
            direction[0]=false; direction[1]=false; direction[2]=false; direction[3]=true;
            animation.play("walk_Left");
        }
        else if(control[0] && control[1] && !control[2] && !control[3] &&  !duringDigging)            // aller en haut a droite
        {
            velocity.x =  100;
            velocity.y = -100;
            direction[0]=false; direction[1]=true; direction[2]=false; direction[3]=false;
            animation.play("walk_Back_Right");
        }
        else if(control[0] && !control[1] && !control[2] && control[3] &&  !duringDigging)             // aller en haut a gauche
        {
            velocity.x = -100;
            velocity.y = -100;
            direction[0]=false; direction[1]=false; direction[2]=false; direction[3]=true;
            animation.play("walk_Back_Left");
        }
        else if(!control[0] && control[1] && control[2] && !control[3] &&  !duringDigging)             // aller en bas a droite
        {
            velocity.x =  100;
            velocity.y =  100;
            direction[0]=false; direction[1]=true; direction[2]=false; direction[3]=false;
            animation.play("walk_Front_Right");
        }
        else if(!control[0] && !control[1] && control[2] && control[3] &&  !duringDigging)             // aller en bas a gauche
        {
            velocity.x = -100;
            velocity.y =  100;
            direction[0]=false; direction[1]=false; direction[2]=false; direction[3]=true;
            animation.play("walk_Front_Left");
        }
        else
        {
            velocity.x=0;
            velocity.y=0;
            animation.pause();
        }
    }
    public function checkPos():Void{
        if(Std.int(x)!=prevX || Std.int(y)!=prevY)
        {
            prevX=Std.int(x);
            prevY=Std.int(y);
            displayCoord.text="x:"+prevX+"\n";
            displayCoord.text+="y:"+prevY+"\n";
            displayCoord.setPosition(this.x+this.width,this.y);
        }
    }

    public function diggingAnimation():Void{
        if(direction[0] && !direction[1] && !direction[2] && !direction[3])
            animation.play("dig_Back");
        else if(!direction[0] && direction[1] && !direction[2] && !direction[3])
            animation.play("dig_Right");
        else if(!direction[0] && !direction[1] && direction[2] && !direction[3])
            animation.play("dig_Front");
        else if(!direction[0] && !direction[1] && !direction[2] && direction[3])
            animation.play("dig_Left");
        else trace("error");
    }   

    override public function update():Void{
        move();
        checkPos();
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
