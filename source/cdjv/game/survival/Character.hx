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


class Character extends FlxSprite{

    public var pseudo:String;
    public var onCollision:Bool;

    public var duringDigging:Bool;
    public var diggingFinish:Bool;

    public var action:Bool;
    public var run:Bool;

    public var prevX:Int;
    public var prevY:Int;
    public var poids:Int;

    public var z:Int;

    /* TIMER */
    static var dig_time=2;                      // TEMPS POUR CREUSER
    static var dig_finish_time=0.5;             // TEMPS DE CLIGNOTEMENT


    public var endActionFrame:Int;

    public var zone:Array<Int>;
    public var control:Array<Bool>;
    public var direction:Array<Bool>;

    public var stuff:Array<String>;
    public var inHand:Array<String>;    // 0: left hand, 1: right hand

    public var loadCircle:FlxSprite;
    public var displayCoord:FlxText;
    public var sceneJeu:PlayState;
    public var digTime:FlxTimer;
    public var digFinishTime:FlxTimer;

    public var barre:FlxBar;


    public function new(scene:PlayState, pseudo:String, posx:Int, posy:Int){
        super();
        this.pseudo=pseudo;
        zone = [0,0];
        diggingFinish=false;
        displayCoord=new FlxText(Std.int(FlxG.width/4),20,80);
        displayCoord.alignment="left";
        displayCoord.color=0x00000000;
        sceneJeu=scene;
        sceneJeu.add(displayCoord);
        setTheBasicCharPropriety(scene, posx, posy);
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
        loadCircle.animation.add("loading",[0,1,2,3,4,5,6],3,true);
        loadCirclePositionning();
        loadCircle.animation.play("loading");
        diggingAnimation();
        digTime=FlxTimer.start(dig_time);
    }

    public function onMousseUP(evt:flash.events.MouseEvent):Void{
            loadCircle.alpha=0;
            loadCircle.animation.destroyAnimations();
            duringDigging=false;
            //animation.frameIndex=endActionFrame;
            digTime.abort();
            digTime.finished=false;
            sceneJeu.surface.digMan.creuse(this);
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
                sceneJeu.surface.digMan.creuse(this);
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
        if(!onCollision)
            barre.velocity=this.velocity;
        else
        {
            barre.velocity.x=0;
            barre.velocity.y=0;
        }
        changeMaxVelocity();
        if(velocity.x !=0 || velocity.y!=0){
            zone = checkZone();
            var facteur:Float=.01;
            if(z>0) this.scale=new FlxPoint(1-z*facteur,1-z*facteur);
            else this.scale=new FlxPoint(1,1);
            FlxG.camera.zoom=1+z*facteur;
        }
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
        z=0;//sceneJeu.surface.digMan.getProfondeur(this);

    }



    public function checkPos():Void{
        if(Std.int(x)!=prevX || Std.int(y)!=prevY)
        {
            prevX=Std.int(x);
            prevY=Std.int(y);
            displayCoord.text="x:"+prevX+"\n";
            displayCoord.text+="y:"+prevY+"\n";
            displayCoord.text+="z:"+Std.int(z)+"\n";
            displayCoord.text+=pseudo+"\n";
            displayCoord.setPosition(x+width,y);

        }
    }

    public function loadCirclePositionning():Void{
        trace(direction);    
        if(direction[0] && !direction[1] && !direction[2] && !direction[3])     // vers le haut
        {
            loadCircle.x=this.x+this.width/2;
            loadCircle.y=this.y+this.height;
        }
        else if(!direction[0] && direction[1] && !direction[2] && !direction[3])   // vers la droite
        {
            loadCircle.x=this.x;
            loadCircle.y=this.y+this.height/2;

        }
        else if(!direction[0] && direction[1] && !direction[2] && !direction[3])    //vers la droite
        {
            loadCircle.x = this.x;
            loadCircle.y = this.y+this.height/2;
        }
        else if(!direction[0] && !direction[1] && direction[2] && !direction[3])    // vers le bas
        {
            loadCircle.x = this.x+width/2;
            loadCircle.y = this.y;
        }
        else if(!direction[0] && !direction[1] && !direction[2] && direction[3])       // vers la gauche
        {
            loadCircle.x = this.x+this.width+10;
            loadCircle.y = this.y+this.height/2;
        }
        else if(direction[0] && direction[1] && !direction[2] && !direction[3])       // haut droit
        {
            loadCircle.x=this.x+this.width/3;
            loadCircle.y=this.y+this.height/1.3;
        }
        else if(direction[0] && !direction[1] && !direction[2] && direction[3])   // haut gauche
        {
            loadCircle.x=this.x+2*this.width/3;
            loadCircle.y=this.y+this.height/1.3;
        }
        else if(!direction[0] && direction[1] && direction[2] && !direction[3])   // bas droit
        {
            loadCircle.x=this.x+this.width/3;
            loadCircle.y=this.y+this.height/5;
        }
        else if(!direction[0] && !direction[1] && direction[2] && direction[3])   // bas gauche
        {
            loadCircle.x=this.x+2*this.width/3;
            loadCircle.y=this.y+this.height/5;
        }

    }
    public function setTheBasicCharPropriety(scene:PlayState, posx: Int, posy: Int):Void{
        zone = [0,0];
        /*Character*/
        run=false;
        duringDigging=false;
        control=[false,false,false,false];      // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        direction=[false,false,true,false];    // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche

        this.angle=90;
        maxVelocity.x=100;
        maxVelocity.y=100;
        this.x=posx;
        this.y=posy;

        loadGraphic("assets/images/char2.png",true,false,63,64,false,null);
        centerOffsets;
        scene.add(this);
        /*loadcircle */
        loadCircle=new FlxSprite();
        loadCircle.loadGraphic("assets/images/loadcircle.png",true,false,12,12,false,null);
        scene.add(loadCircle);
        loadCircle.alpha=0;
        loadCircle.x=this.x+this.width/2;
        loadCircle.y=this.y+3;

       /* this.scale.x=0.75;
        this.scale.y=0.75;
        updateHitbox(); */
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

        barre = new FlxBar(0,0,FlxBar.FILL_LEFT_TO_RIGHT,100,10,this,"health");
        barre.createFilledBar(0xFF000000,0x00FFFFFF,false);
        barre.x=(this.x+barre.width)-FlxG.width/2;
        barre.y=(this.y+barre.height)-FlxG.height/3;
        barre.width=FlxG.width/10;
        trace((this.x+barre.width)-FlxG.width/2);
        trace((this.y+barre.height*2)-FlxG.height/2);
        scene.add(barre);

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
            {animation.play("dig_Back");endActionFrame=0;}
        else if(!direction[0] && direction[1] && !direction[2] && !direction[3] && duringDigging)
            {animation.play("dig_Right");endActionFrame=0;}
        else if(!direction[0] && !direction[1] && direction[2] && !direction[3] && duringDigging)
            {animation.play("dig_Front");endActionFrame=0;}
        else if(!direction[0] && !direction[1] && !direction[2] && direction[3] && duringDigging)
            {animation.play("dig_Left");endActionFrame=0 ;}
       // else trace("error");
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


    override public function update():Void{
        move();
        digging();
        checkPos();
        super.update();
    }

    public function getXCenter():Float{
        return x+width/2-4;
    }
    public function getYCenter():Float{
        return y+height/2-4;
    }
}
