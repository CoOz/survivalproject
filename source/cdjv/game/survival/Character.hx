package cdjv.game.survival;

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


class Character extends FlxSprite{

    public var duringDigging:Bool;
    public var diggingFinish:Bool;

    public var action:Bool;
    public var run:Bool;

    public var prevX:Int;
    public var prevY:Int;
    public var poids:Int;

    public var z:Int;

    static var dig_time=5;
    static var dig_finish_time=0.5;
    public var endActionFrame:Int;

    public var zone:Array<Int>;
    public var control:Array<Bool>;
    public var direction:Array<Bool>;
    public var stuff:Array<String>;
    public var inHand:Array<String>;    // 1: left hand, 2: right hand

    public var loadCircle:FlxSprite;
    public var displayCoord:FlxText;
    public var sceneJeu:PlayState;
    public var digTime:FlxTimer;
    public var digFinishTime:FlxTimer;

    public var barre:FlxBar;


    public function new(scene:PlayState){
        super();
        zone = [0,0];
        diggingFinish=false;
        displayCoord=new FlxText(Std.int(FlxG.width/4),20,80);
        displayCoord.alignment="left";
        displayCoord.color=0x00000000;
        sceneJeu=scene;
        sceneJeu.add(displayCoord);
        setTheBasicCharPropriety(scene);
        sceneJeu.add(barre);
        /* Fin Animation */
        prevX=Std.int(x);
        prevY=Std.int(y);
        registerEvents();

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
        if(evt.keyCode == flash.ui.Keyboard.R)
            FlxG.resetGame();
        if(evt.keyCode == flash.ui.Keyboard.SHIFT)
            run=true;
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
        if(evt.keyCode == flash.ui.Keyboard.SHIFT)
            run=false;
       

        if(evt.keyCode == flash.ui.Keyboard.O)
        {
            trace(x);trace(y);
            trace(FlxG.width/2);
            trace(barre.x);
            trace(barre.y);
        }  
    }

    public function onMousseDown(evt:flash.events.MouseEvent):Void{
        duringDigging=true;
        loadCircle.alpha=100;
        loadCircle.animation.add("loading",[0,1,2,3,4,5,6],1,true);
        loadCirclePositionning();
        loadCircle.animation.play("loading");
        diggingAnimation();
        digTime=FlxTimer.start(dig_time);
    }

    public function onMousseUP(evt:flash.events.MouseEvent):Void{
            loadCircle.alpha=0;
            loadCircle.animation.destroyAnimations();
            duringDigging=false;
            animation.frameIndex=endActionFrame;
            digTime.abort();
            digTime.finished=false;
    }


    public function digging():Void
    { 
        if(duringDigging)
        {
           if(digTime.finished)
            {
                digTime.abort();
                digTime.finished=false;
                duringDigging=false;
               // sceneJeu.surface.digMap.creuse(this);         /* fait foirée */
                loadCircle.animation.destroyAnimations();
                loadCircle.animation.add("clignote",[6,0],20,true);
                loadCircle.animation.play("clignote");
                diggingFinish=true;
                digFinishTime=FlxTimer.start(dig_finish_time);
            }
        }
        if(diggingFinish)
        {
            if(digFinishTime.finished)
            {
                digFinishTime.abort();
                digFinishTime.finished=false;
                diggingFinish=false;
                loadCircle.animation.destroyAnimations();
                loadCircle.alpha=0;
            }
        }
    }

    public function move ():Void
    {
        barre.x=x-FlxG.width/2+64;
        barre.y=y-FlxG.height/2+50;
     /*   loadCircle.x=x+width/4;
        loadCircle.y=y-height/4;*/
        changeMaxVelocity();
        if(velocity.x !=0 || velocity.y!=0) zone = checkZone();
        if(control[0] && !control[1] && !control[2] && !control[3] && !duringDigging){         // aller vers le haut
            direction[0]=true; direction[1]=false; direction[2]=false; direction[3]=false;
            this.angle=-90;
            animation.play("walk");         
            velocity.x=0;
            velocity.y=-maxVelocity.y;
        }
        else if(!control[0] && !control[1] && control[2] && !control[3] &&  !duringDigging){         // aller vers le bas
            direction[0]=false; direction[1]=false; direction[2]=true; direction[3]=false;
            this.angle=90;
            animation.play("walk");  
            velocity.x = 0;
            velocity.y = maxVelocity.y;
        }

        else if(!control[0] && control[1] && !control[2] && !control[3] &&  !duringDigging){         // aller vers la droite
            direction[0]=false; direction[1]=true; direction[2]=false; direction[3]=false;
            this.angle=0;
            animation.play("walk");  
            velocity.x = maxVelocity.x;
            velocity.y = 0;
        }

        else if(!control[0] && !control[1] && !control[2] && control[3] &&  !duringDigging){         // aller vers la gauche
            direction[0]=false; direction[1]=false; direction[2]=false; direction[3]=true;
            this.angle=180;
            animation.play("walk");  
            velocity.x = -maxVelocity.x;
            velocity.y = 0;
        }

        else if(control[0] && control[1] && !control[2] && !control[3] &&  !duringDigging){            // aller en haut a droite
            direction[0]=true; direction[1]=true; direction[2]=false; direction[3]=false;
            this.angle=-45;
            animation.play("walk");  
            velocity.x =  maxVelocity.x;
            velocity.y = -maxVelocity.y;
        }

        else if(control[0] && !control[1] && !control[2] && control[3] &&  !duringDigging){             // aller en haut a gauche
            direction[0]=true; direction[1]=false; direction[2]=false; direction[3]=true;
            this.angle=-125;
            animation.play("walk");  
            velocity.x = -maxVelocity.x;
            velocity.y = -maxVelocity.y; 
        }

        else if(!control[0] && control[1] && control[2] && !control[3] &&  !duringDigging){             // aller en bas a droite
            direction[0]=false; direction[1]=true; direction[2]=true; direction[3]=false;
            this.angle=45;
            animation.play("walk");  
            velocity.x = maxVelocity.x;
            velocity.y = maxVelocity.y;
        }

        else if(!control[0] && !control[1] && control[2] && control[3] &&  !duringDigging)             // aller en bas a gauche
        {
            direction[0]=false; direction[1]=false; direction[2]=true; direction[3]=true;
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
    }



    public function checkPos():Void{
        if(Std.int(x)!=prevX || Std.int(y)!=prevY)
        {
            prevX=Std.int(x);
            prevY=Std.int(y);
            displayCoord.text="x:"+prevX+"\n";
            displayCoord.text+="y:"+prevY+"\n";
            displayCoord.setPosition(x+width,y);

        }
    }

    public function loadCirclePositionning():Void{
        if(direction[0] && !direction[1] && !direction[2] && !direction[3])     // vers le haut
        {
            loadCircle.x=this.x+width/2;
            loadCircle.y=this.y-height;
        }
        else if(direction[0] && direction[1] && direction[2] && direction[3])
        {

        }
        else if(direction[0] && direction[1] && direction[2] && direction[3])
        {

        }
        else if(direction[0] && direction[1] && direction[2] && direction[3])
        {

        }
        else if(direction[0] && direction[1] && direction[2] && direction[3])
        {

        }
        else if(direction[0] && direction[1] && direction[2] && direction[3])
        {

        }
        else if(direction[0] && direction[1] && direction[2] && direction[3])
        {

        }

    }
    public function setTheBasicCharPropriety(scene:PlayState):Void{
        zone = [0,0];
        /*Character*/
        run=false;
        duringDigging=false;
        control=[false,false,false,false];      // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        direction=[false,false,true,false];    // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        this.angle=0;
        maxVelocity.x=100;
        maxVelocity.y=100;
        loadGraphic("assets/images/char2.png",true,false,63,64,false,null);
        centerOffsets;
        scene.add(this);
        /*load circle */
        loadCircle=new FlxSprite();
        loadCircle.loadGraphic("assets/images/loadcircle.png",true,false,12,12,false,null);
        scene.add(loadCircle);
        loadCircle.alpha=0;
        loadCircle.x=x+width/4;
        loadCircle.y=y-height/4;

        this.scale.x=0.75;
        this.scale.y=0.75;
        updateHitbox(); 
        /* Animation : */

            /* move */
       /* animation.add("walk_Front",[0,1,2,3],10,true);
        animation.add("walk_Left",[4,5,6,7],10,true);
        animation.add("walk_Right",[0,1,2,3,4,5,6],10,true);
        animation.add("walk_Back",[12,13,14,15],10,true);
        animation.add("walk_Front_Left",[16,17,18,19],10,true);
        animation.add("walk_Back_Left",[20,21,22,23],10,true);
        animation.add("walk_Front_Right",[24,25,26,27],10,true);
        animation.add("walk_Back_Right",[28,29,30,31],10,true);*/
         animation.add("walk",[0,1,2,3,4,5,6],12,true);
             /*action*/
        animation.add("dig_Front",[32,33,34,35],4,true);       // creuser vers le bas
        animation.add("dig_Left",[36,37,38,39],4,true);
        animation.add("dig_Right",[40,41,42,43],4,true);
        animation.add("dig_Back",[44,45,46,47],4,true);        // creuser vers le haut

        barre = new FlxBar(x-FlxG.width/2+64,y-FlxG.height/2+50,FlxBar.FILL_LEFT_TO_RIGHT,64,10,this,"health");

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
        if(direction[0] && !direction[1] && !direction[2] && !direction[3] && duringDigging)
            {animation.play("dig_Back");endActionFrame=12;}
        else if(!direction[0] && direction[1] && !direction[2] && !direction[3] && duringDigging)
            {animation.play("dig_Right");endActionFrame=8;}
        else if(!direction[0] && !direction[1] && direction[2] && !direction[3] && duringDigging)
            {animation.play("dig_Front");endActionFrame=0;}
        else if(!direction[0] && !direction[1] && !direction[2] && direction[3] && duringDigging)
            {animation.play("dig_Left");endActionFrame=4;}
        else trace("error");
    }  

    
    public function changeMaxVelocity():Void{
        if(run)
        {
            maxVelocity.x=200;
            maxVelocity.y=200;
        }
        else
        {
            maxVelocity.x=100;
            maxVelocity.y=100;
        }
    } 

    public function test():Void{
        trace("coucou");
    }

    override public function update():Void{
        move();
        digging();
        checkPos();
        super.update();
    }


}
