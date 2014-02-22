package cdjv.game.survival;

import flash.events.KeyboardEvent;
import flash.events.Event;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;

import flixel.FlxObject;

import flixel.FlxObject;
import flixel.text.FlxText;

class Character extends FlxSprite{

    public var duringDigging:Bool;
    public var diggingFinish:Bool;
    public var action:Bool;

    public var prevX:Int;
    public var prevY:Int;
    public var zone:Array<Int>;
    public var control:Array<Bool>;
    public var direction:Array<Bool>;
    public var directionPos:Array<Bool>;
    public var inCollide:Bool;

    public var loadCircle:FlxSprite;
    public var displayCoord:FlxText;
    public var sceneJeu:PlayState;



    public function new(scene:PlayState){
        super();
        zone = [0,0];
        duringDigging=false;
        diggingFinish=false;
        inCollide = false;
        control=[false,false,false,false];      // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        direction=[false,false,true,false];    // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        directionPos = [true,true,true,true];
        loadCircle=new FlxSprite();
        displayCoord=new FlxText(Std.int(FlxG.width/4),20,80);
        displayCoord.alignment="left";
        displayCoord.color=0xFFFFFFFF;

        this.sceneJeu=scene;
        this.sceneJeu.add(displayCoord);
        /*Character*/
        this.loadGraphic("assets/images/char.png",true,false,32,50,false,null);
        scene.add(this);
        /*load circle */
        loadCircle.loadGraphic("assets/images/loadcircle.png",true,false,12,12,false,null);


        /* Animation : */

            /* move */
        this.animation.add("walk_Front",[0,1,2,3],10,true);
        this.animation.add("walk_Left",[4,5,6,7],10,true);
        this.animation.add("walk_Right",[8,9,10,11],10,true);
        this.animation.add("walk_Back",[12,13,14,15],10,true);
        this.animation.add("walk_Front_Left",[16,17,18,19],10,true);
        this.animation.add("walk_Back_Left",[20,21,22,23],10,true);
        this.animation.add("walk_Front_Right",[24,25,26,27],10,true);
        this.animation.add("walk_Back_Right",[28,29,30,31],10,true);

             /*action*/
        this.animation.add("dig_Front",[32,33,34,35],4,true);
        this.animation.add("dig_Left",[36,37,38,39],4,true);
        this.animation.add("dig_Right",[40,41,42,43],4,true);
        this.animation.add("dig_Back",[44,45,46,47],4,true);

            /*loading*/
        loadCircle.alpha=0;
        scene.add(loadCircle);
        /* Fin Animation */
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
        action=true;
       /* digging();
        action=false;*/
    }

    public function onMousseUP(evt:flash.events.MouseEvent):Void{
        action=false;
    }

    public function digging():Void
    {
        if(action==true && duringDigging==false && loadCircle.animation.frameIndex!=7)
        {
            loadCircle.alpha=100;
            loadCircle.animation.add("loading",[0,1,2,3,4,5,6],1,true);
            loadCircle.x=this.x;
            loadCircle.y=this.y;
            loadCircle.animation.play("loading");
            duringDigging=true;
        }
        else if (loadCircle.animation.frameIndex==7)
        {
            duringDigging=false;
            diggingFinish=true;
        }
        else if(action==false && duringDigging==true)
        {
            loadCircle.alpha=0;
            loadCircle.animation.destroyAnimations();
            duringDigging=false;
        }
    }

    public function move ():Void{
        if(control[0] && !control[1] && !control[2] && !control[3] && !duringDigging)         // aller vers le haut
        {
            this.velocity.x = 0;
            this.velocity.y = -100;
            direction[0]=true; direction[1]=false; direction[2]=false; direction[3]=false;
            this.animation.play("walk_Back");
        }
        else if(!control[0] && !control[1] && control[2] && !control[3] &&  !duringDigging)         // aller vers le bas

        {
            this.velocity.x = 0;
            this.velocity.y = 100;
            direction[0]=false; direction[1]=false; direction[2]=true; direction[3]=false;
            this.animation.play("walk_Front");
        }

        else if(!control[0] && control[1] && !control[2] && !control[3] &&  !duringDigging)         // aller vers la droite

        {
            this.velocity.x = 100;
            this.velocity.y = 0;
            direction[0]=false; direction[1]=true; direction[2]=false; direction[3]=false;
            this.animation.play("walk_Right");
        }

        else if(!control[0] && !control[1] && !control[2] && control[3] &&  !duringDigging)         // aller vers la gauche

        {
            this.velocity.x = -100;
            this.velocity.y = 0;
            direction[0]=false; direction[1]=false; direction[2]=false; direction[3]=true;
            this.animation.play("walk_Left");
        }

        else if(control[0] && control[1] && !control[2] && !control[3] &&  !duringDigging)            // aller en haut a droite

        {
            this.velocity.x =  100;
            this.velocity.y = -100;
            direction[0]=false; direction[1]=true; direction[2]=false; direction[3]=false;
            this.animation.play("walk_Back_Right");
        }

        else if(control[0] && !control[1] && !control[2] && control[3] &&  !duringDigging)             // aller en haut a gauche

        {
            this.velocity.x = -100;
            this.velocity.y = -100;
            direction[0]=false; direction[1]=false; direction[2]=false; direction[3]=true;
            this.animation.play("walk_Back_Left");
        }

        else if(!control[0] && control[1] && control[2] && !control[3] &&  !duringDigging)             // aller en bas a droite

        {
            this.velocity.x =  100;
            this.velocity.y =  100;
            direction[0]=false; direction[1]=true; direction[2]=false; direction[3]=false;
            this.animation.play("walk_Front_Right");
        }

        else if(!control[0] && !control[1] && control[2] && control[3] &&  !duringDigging)             // aller en bas a gauche

        {
            this.velocity.x = -100;
            this.velocity.y =  100;
            direction[0]=false; direction[1]=false; direction[2]=false; direction[3]=true;
            this.animation.play("walk_Front_Left");
        }
        else
        {
            this.velocity.x=0;
            this.velocity.y=0;
            this.animation.pause();
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

    /* look for position of hero in the map. THIS FUNCTION IS CANCER*/
    public function checkZone():Array<Int>
    {
        if(x < 0 && y < 0)
            return([Std.int((x-800)/800), Std.int((y-600)/600)]);
        if(x < 0  )
            return([Std.int((x-800)/800), Std.int(y/600)]);
        if(y < 0)
            return([Std.int(x/800),Std.int((y-600)/600)]);
        return([Std.int(x/800),Std.int(y/600)]); 
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
        zone = checkZone();
        digging();
        super.update();
    }

       //sceneJeu.surface.digMap.creuse(x,y);
}
