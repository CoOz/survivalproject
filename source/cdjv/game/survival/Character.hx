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
    public var mainChar:Bool;
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
    public var digTime:FlxTimer;
    public var scene:PlayState;
    public var digFinishTime:FlxTimer;

    public var barre:FlxBar;
    public var life:FlxText;
    public var maxlife:FlxText;

    public var inventaire:Inventory;

    public function new(scene:PlayState, connexion: Connexion, pseudo:String, posx:Float, posy:Float, mchar:Bool){  
        super();      
        this.pseudo=pseudo;
        this.mainChar=mchar;
        this.x=posx;
        this.y=posy;
        this.scene=scene;
        trace(this.scene.id);
        this.zone = [0,0];
        this.diggingFinish=false;
        this.displayCoord=new FlxText(Std.int(FlxG.width/4),20,80);
        //this.displayCoord = new FlxText(800/4,20,80);
        this.displayCoord.alignment="left";
        this.displayCoord.color=0x00000000;
        this.scene.add(displayCoord);
        this.setTheBasicCharPropriety();
        this.prevX=Std.int(this.x);
        this.prevY=Std.int(this.y);
        if(this.mainChar==true)                     this.registerEvents();    
        if(this.mainChar==true)                     connexion.charMan.creeJoueur();
    }

    public function registerEvents():Void{
            FlxG.game.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
            FlxG.game.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
            FlxG.game.stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN,onMousseDown);
            FlxG.game.stage.addEventListener(flash.events.MouseEvent.MOUSE_UP,onMousseUP);
    }

    public function onKeyDown(evt:KeyboardEvent):Void{
        if(evt.keyCode == flash.ui.Keyboard.Z)
            this.control[0]=true;
        if(evt.keyCode == flash.ui.Keyboard.D)
            this.control[1]=true;
        if(evt.keyCode == flash.ui.Keyboard.S)
            this.control[2]=true;
        if(evt.keyCode == flash.ui.Keyboard.Q)
            this.control[3]=true;
        if(evt.keyCode == flash.ui.Keyboard.R)
            FlxG.resetGame();
        if(evt.keyCode == flash.ui.Keyboard.SHIFT)
            this.run=true;
    }

    public function onKeyUp(evt:KeyboardEvent):Void{
        if(evt.keyCode == flash.ui.Keyboard.Z)
            this.control[0]=false;
        if(evt.keyCode == flash.ui.Keyboard.D)
            this.control[1]=false;
        if(evt.keyCode == flash.ui.Keyboard.S)
            this.control[2]=false;
        if(evt.keyCode == flash.ui.Keyboard.Q)
            this.control[3]=false;
        if(evt.keyCode == flash.ui.Keyboard.SHIFT)
            this.run=false;
    }

    public function onMousseDown(evt:flash.events.MouseEvent):Void{
        if(this.alive)
        {
            this.duringDigging=true;
            this.loadCircle.alpha=100;
            this.loadCircle.animation.add("loading",[0,1,2,3,4,5,6],3,true);
            this.loadCirclePositionning();
            this.loadCircle.animation.play("loading");
            this.diggingAnimation();
            this.digTime=FlxTimer.start(dig_time);
        }
    }

    public function onMousseUP(evt:flash.events.MouseEvent):Void{
        if(this.alive)
        {
            this.loadCircle.alpha=0;
            this.loadCircle.animation.destroyAnimations();
            this.duringDigging=false;
            //animation.frameIndex=endActionFrame;
            this.digTime.abort();
            this.digTime.finished=false;
        }
    }


    public function digging():Void
    {
        if(this.mainChar==true)
        {
            if(this.duringDigging && this.alive)
            {
               if(this.digTime.finished)
                {
                    this.digTime.abort();
                    this.digTime.finished=false;
                    this.duringDigging=false;
                   // this.scene.surface.digMan.creuse(this);
                    this.loadCircle.animation.destroyAnimations();
                    this.loadCircle.animation.add("clignote",[6,0],20,true);
                    this.loadCircle.animation.play("clignote");
                    this.diggingFinish=true;
                    this.digFinishTime=FlxTimer.start(dig_finish_time);
                }
            }
            if(this.diggingFinish)
            {
                if(this.digFinishTime.finished)
                {
                    this.digFinishTime.abort();
                    this.digFinishTime.finished=false;
                    this.diggingFinish=false;
                    this.loadCircle.animation.destroyAnimations();
                    this.loadCircle.alpha=0;
                }
            }
        }
    }

    public function move ():Void
    {
        if(this.mainChar==true)
        {
            this.changeMaxVelocity();
            if(this.velocity.x !=0 || this.velocity.y!=0){
                this.zone = this.checkZone();
                var facteur:Float=.01;
                if(this.z>0) this.scale=new FlxPoint(1-this.z*facteur,1-this.z*facteur);
                else this.scale=new FlxPoint(1,1);
                FlxG.camera.zoom=1+z*facteur;
            }
            if(this.control[0] && !this.control[1] && !this.control[2] && !this.control[3] && !this.duringDigging){         // aller vers le haut
                this.direction[0]=true; this.direction[1]=false; this.direction[2]=false; this.direction[3]=false;
                this.angle=-90;
                this.animation.play("walk");         
                this.velocity.x=0;
                this.velocity.y=-maxVelocity.y;
            }
            else if(!this.control[0] && !this.control[1] && this.control[2] && !this.control[3] &&  !this.duringDigging){         // aller vers le bas
                this.direction[0]=false; this.direction[1]=false; this.direction[2]=true; this.direction[3]=false;
                this.angle=90;
                this.animation.play("walk");  
                this.velocity.x = 0;
                this.velocity.y = this.maxVelocity.y;
            }

            else if(!this.control[0] && this.control[1] && !this.control[2] && !this.control[3] &&  !this.duringDigging){         // aller vers la droite
                this.direction[0]=false; this.direction[1]=true; this.direction[2]=false; this.direction[3]=false;
                this.angle=0;
                this.animation.play("walk");  
                this.velocity.x = this.maxVelocity.x;
                this.velocity.y = 0;
            }

            else if(!this.control[0] && !this.control[1] && !this.control[2] && this.control[3] &&  !this.duringDigging){         // aller vers la gauche
                this.direction[0]=false; this.direction[1]=false; this.direction[2]=false; this.direction[3]=true;
                this.angle=180;
                this.animation.play("walk");  
                this.velocity.x = -this.maxVelocity.x;
                this.velocity.y = 0;
            }

            else if(this.control[0] && this.control[1] && !this.control[2] && !this.control[3] &&  !this.duringDigging){            // aller en haut a droite
                this.direction[0]=true; this.direction[1]=true; this.direction[2]=false; this.direction[3]=false;
                this.angle=-45;
                this.animation.play("walk");  
                this.velocity.x =  this.maxVelocity.x;
                this.velocity.y = -this.maxVelocity.y;
            }

            else if(this.control[0] && !this.control[1] && !this.control[2] && this.control[3] &&  !this.duringDigging){             // aller en haut a gauche
                this.direction[0]=true; this.direction[1]=false; this.direction[2]=false; this.direction[3]=true;
                this.angle=-125;
                this.animation.play("walk");  
                this.velocity.x = -this.maxVelocity.x;
                this.velocity.y = -this.maxVelocity.y; 
            }

            else if(!this.control[0] && this.control[1] && this.control[2] && !this.control[3] &&  !this.duringDigging){             // aller en bas a droite
                this.direction[0]=false; this.direction[1]=true; this.direction[2]=true; this.direction[3]=false;
                this.angle=45;
                this.animation.play("walk");  
                this.velocity.x = this.maxVelocity.x;
                this.velocity.y = this.maxVelocity.y;
            }

            else if(!this.control[0] && !this.control[1] && this.control[2] && this.control[3] &&  !this.duringDigging)             // aller en bas a gauche
            {
                this.direction[0]=false; this.direction[1]=false; this.direction[2]=true; this.direction[3]=true;
                this.angle=125;
                this.animation.play("walk");  
                this.velocity.x = -this.maxVelocity.x;
                this.velocity.y =  this.maxVelocity.y;
            }
            else
            {
                this.velocity.x=0;
                this.velocity.y=0;
                //this.animation.frameIndex=0;
                this.animation.pause();
            }

            if(this.animation.frameIndex!=0){
                this.scene.connexion.sPos(x,y);
            }            
            this.z=0;    //sceneJeu.surface.digMan.getProfondeur(this);
        }
    }


    public function checkPos():Void{
        if(this.mainChar==true)
        {
            /*if(Std.int(this.x)!=this.prevX || Std.int(this.y)!=this.prevY)
            {
                trace("dkdkdkk");
                this.prevX=Std.int(this.x);
                this.prevY=Std.int(this.y);
                this.displayCoord.text="x:"+this.prevX+"\n";
                this.displayCoord.text+="y:"+this.prevY+"\n";
                this.displayCoord.text+="z:"+Std.int(this.z)+"\n";
                this.displayCoord.text+=this.pseudo+" ";
                this.displayCoord.setPosition(this.x+this.width, this.y);
               // this.displayCoord.setPosition(this.x+800, this.y);
            }*/
        }
    }

    public function loadCirclePositionning():Void{
        if(this.mainChar==true)
        {
            if(this.direction[0] && !this.direction[1] && !this.direction[2] && !this.direction[3])     // vers le haut
            {
                this.loadCircle.x=this.x+this.width/2;
                this.loadCircle.y=this.y+this.height*2/3;
            }
            else if(!this.direction[0] && this.direction[1] && !this.direction[2] && !this.direction[3])   // vers la droite
            {
                this.loadCircle.x=this.x;
                this.loadCircle.y=this.y+this.height/2;

            }
            else if(!this.direction[0] && !this.direction[1] && this.direction[2] && !this.direction[3])    // vers le bas
            {
                this.loadCircle.x = this.x+width/2;
                this.loadCircle.y = this.y;
            }
            else if(!this.direction[0] && !this.direction[1] && !this.direction[2] && this.direction[3])       // vers la gauche
            {
                this.loadCircle.x = this.x+this.width-10;
                this.loadCircle.y = this.y+this.height/2;
            }
            else if(this.direction[0] && this.direction[1] && !this.direction[2] && !this.direction[3])       // haut droit
            {
                this.loadCircle.x=this.x+this.width/3;
                this.loadCircle.y=this.y+this.height/1.3;
            }
            else if(this.direction[0] && !this.direction[1] && !this.direction[2] && this.direction[3])   // haut gauche
            {
                this.loadCircle.x=this.x+2*this.width/3;
                this.loadCircle.y=this.y+this.height/1.3;
            }
            else if(!this.direction[0] && this.direction[1] && this.direction[2] && !this.direction[3])   // bas droit
            {
                this.loadCircle.x=this.x+this.width/5;
                this.loadCircle.y=this.y+this.height/5;
            }
            else if(!this.direction[0] && !this.direction[1] && this.direction[2] && this.direction[3])   // bas gauche
            {
                this.loadCircle.x=this.x+2*this.width/3;
                this.loadCircle.y=this.y+this.height/5;
            }
        }
    }
    public function setTheBasicCharPropriety():Void{
        this.zone = [0,0];

        /*Character*/
        this.run=false;
        this.duringDigging=false;
        this.control=[false,false,false,false];      // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        this.direction=[false,false,true,false];    // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche

        this.angle=90;
        this.maxVelocity.x=100;
        this.maxVelocity.y=100;

        if(this.mainChar==true) this.centerOffsets;
        this.loadGraphic("assets/images/char2.png",true,false,63,64,true,null);        
        this.animation.add("walk",[0,1,2,3,4,5,6],12,true);
        this.scene.add(this);

        /*loadcircle */
        this.loadCircle=new FlxSprite();
        this.loadCircle.loadGraphic("assets/images/loadcircle.png",true,false,12,12,false,null);
        this.scene.add(loadCircle);
        this.loadCircle.alpha=0;
        this.loadCircle.x=this.x+400;
        this.loadCircle.y=this.y+3;


        /* VIE ET BARRE DE VIE */ 
/*
        this.health=20;
        barre = new FlxBar(0,0,FlxBar.FILL_LEFT_TO_RIGHT,100,10,this,"health",0,20,true);
        barre.createFilledBar(0xFFFF0000,0xFF00FF00,false);
        barre.width=FlxG.width/10;
        barre.trackParent(Std.int((this.x+barre.width)-FlxG.width/1.8),Std.int((this.y-barre.height)-FlxG.height/2.5));
        barre.pxPerPercent=barre.width/100;
        scene.add(barre);
*/

    }


    /* look for position of hero in the map. THIS FUNCTION IS CANCER*/
    public function checkZone():Array<Int>
    {
        if(this.mainChar==true)
        {
            if(this.x < 0 && this.y < 0)
                return([Std.int((this.x-800)/800), Std.int((this.y-600)/600)]);
            if(this.x < 0  )
                return([Std.int((this.x-800)/800), Std.int(this.y/600)]);
            if(this.y < 0)
                return([Std.int(this.x/800),Std.int((this.y-600)/600)]);
            return([Std.int(this.x/800),Std.int(this.y/600)]); 
        }
        else return ([0]);
    }

    public function diggingAnimation():Void{
        if(this.mainChar==true)
        {
            if(this.direction[0] && !this.direction[1] && !this.direction[2] && !this.direction[3] && this.duringDigging)
                {this.animation.play("dig_Back");this.endActionFrame=0;}
            else if(!direction[0] && direction[1] && !direction[2] && !direction[3] && this.duringDigging)
                {this.animation.play("dig_Right");this.endActionFrame=0;}
            else if(!this.direction[0] && !this.direction[1] && this.direction[2] && !this.direction[3] && this.duringDigging)
                {this.animation.play("dig_Front");this.endActionFrame=0;}
            else if(!this.direction[0] && !this.direction[1] && !this.direction[2] && this.direction[3] && this.duringDigging)
                {this.animation.play("dig_Left");this.endActionFrame=0 ;}
           // else trace("error");
        }
    }  

    
    public function changeMaxVelocity():Void{
        if(this.run)
        {
            this.maxVelocity.x=200;
            this.maxVelocity.y=200;
        }
        else
        {
            this.maxVelocity.x=100;
            this.maxVelocity.y=100;
        }
    } 


    override public function update():Void{
        super.update();
        this.move();
        this.digging();
        this.checkPos();
    }

    public function getXCenter():Float{ 
        return this.x+this.width/2-4;
        //return this.x+800/2-4;
    }
    public function getYCenter():Float{
        return this.y+this.height/2-4;
        //return this.y+600/2-4;
    }
}

