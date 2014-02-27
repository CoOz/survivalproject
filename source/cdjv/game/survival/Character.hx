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
    public var action:Bool;
    public var inCollide:Bool;
    public var run:Bool;

    public var prevX:Int;
    public var prevY:Int;
    public var poids:Int;
    public var nbCligno:Int;

    public var zone:Array<Int>;
    public var control:Array<Bool>;
    public var direction:Array<Bool>;
    public var directionPos:Array<Bool>;

    public var loadCircle:FlxSprite;
    public var displayCoord:FlxText;
    public var sceneJeu:PlayState;


    public function new(scene:PlayState){
        super();
        displayCoord=new FlxText(Std.int(FlxG.width/4),20,80);
        displayCoord.alignment="left";
        displayCoord.color=0x00000000;
        this.sceneJeu=scene;
        this.sceneJeu.add(displayCoord);
        this.setTheBasicCharPropriety(scene);
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
        }
        if(evt.keyCode == flash.ui.Keyboard.UP)
        {
            if(poids<this.maxVelocity.y/2) poids+=2;
        }
        if(evt.keyCode == flash.ui.Keyboard.DOWN)
        {
            if(poids>0) poids-=2;
        }   
    }

    public function onMousseDown(evt:flash.events.MouseEvent):Void{
        duringDigging=true;
        loadCircle.alpha=100;
        loadCircle.animation.add("loading",[0,1,2,3,4,5,6],1,true);
        loadCircle.animation.add("clignote",[6,0],10,true);
        loadCircle.x=this.x+this.width/4;
        loadCircle.y=this.y-this.height/4;
        loadCircle.animation.play("loading");
        diggingAnimation();
    }

    public function onMousseUP(evt:flash.events.MouseEvent):Void{
            loadCircle.alpha=0;
            loadCircle.animation.destroyAnimations();
            duringDigging=false;
    }


    public function digging():Void
    {  
        if (loadCircle.animation.frameIndex==6 && nbCligno!=75)     //fini de creuser
        {
            loadCircle.animation.pause();
            loadCircle.animation.play("clignote");
            duringDigging=false;
            nbCligno++;
            if(direction[0])
                sceneJeu.surface.digMap.creuse(x,y-1);
            else if(direction[1])
                sceneJeu.surface.digMap.creuse(x+1,y);
            else if(direction[2])
                sceneJeu.surface.digMap.creuse(x,y+1);
            else if(direction[3])
                sceneJeu.surface.digMap.creuse(x-1,y);
            if(nbCligno==50)
                {
                    loadCircle.alpha=0; 
                    nbCligno=0;
                }
        }
    }

    public function move ():Void
    {
        loadCircle.x=this.x+this.width/4;
        loadCircle.y=this.y-this.height/4;
        if(control[0] && !control[1] && !control[2] && !control[3] && !duringDigging){         // aller vers le haut
            direction[0]=true; direction[1]=false; direction[2]=false; direction[3]=false;
            this.animation.play("walk_Back");
            zone = checkZone();
            if(!run)
            {
                this.velocity.x = 0;
                this.velocity.y = -this.maxVelocity.y/2+poids;
            }
            else
            {
                this.velocity.x = 0;
                this.velocity.y = -this.maxVelocity.y+poids;
            }

        }
        else if(!control[0] && !control[1] && control[2] && !control[3] &&  !duringDigging){         // aller vers le bas
            direction[0]=false; direction[1]=false; direction[2]=true; direction[3]=false;
            this.animation.play("walk_Front");
            zone = checkZone();
            if(directionPos[2])
            {
                if(!run)
                {
                    this.velocity.x = 0;
                    this.velocity.y = this.maxVelocity.y/2-poids;
                }
                else
                {
                    this.velocity.x = 0;
                    this.velocity.y = this.maxVelocity.y-poids;
                }
            }
            else 
            {
                this.velocity.x = 0;
                this.velocity.y = 0;
            }
        }

        else if(!control[0] && control[1] && !control[2] && !control[3] &&  !duringDigging){         // aller vers la droite
            direction[0]=false; direction[1]=true; direction[2]=false; direction[3]=false;
            this.animation.play("walk_Right");
            zone = checkZone();
            if(run)
            {
                this.velocity.x = maxVelocity.x/2-poids;
                this.velocity.y = 0;
            }
            else
            {
                this.velocity.x = maxVelocity.x/2-poids;
                this.velocity.y = 0;
            }
        }

        else if(!control[0] && !control[1] && !control[2] && control[3] &&  !duringDigging){         // aller vers la gauche
            direction[0]=false; direction[1]=false; direction[2]=false; direction[3]=true;
            this.animation.play("walk_Left");
            zone = checkZone();
            if(!run)
            {
                this.velocity.x = -maxVelocity.x/2+poids;
                this.velocity.y = 0;
            }
            else
            {
                this.velocity.x = -maxVelocity.x+poids;
                this.velocity.y = 0;
            }
        }

        else if(control[0] && control[1] && !control[2] && !control[3] &&  !duringDigging){            // aller en haut a droite
            direction[0]=false; direction[1]=true; direction[2]=false; direction[3]=false;
            this.animation.play("walk_Back_Right");
            zone = checkZone();
            if(!run)
            {
                this.velocity.x =  maxVelocity.x/2-poids;
                this.velocity.y = -maxVelocity.y/2+poids;
            }
            else 
            {
                this.velocity.x =  maxVelocity.x-poids;
                this.velocity.y = -maxVelocity.y+poids;
            }
        }

        else if(control[0] && !control[1] && !control[2] && control[3] &&  !duringDigging){             // aller en haut a gauche
            direction[0]=false; direction[1]=false; direction[2]=false; direction[3]=true;
            this.animation.play("walk_Back_Left");
            zone = checkZone();
            if(!run)
            {
                this.velocity.x = -maxVelocity.x/2+poids;
                this.velocity.y = -maxVelocity.y/2+poids; 
            }
            else 
            {
                this.velocity.x = -maxVelocity.x+poids;
                this.velocity.y = -maxVelocity.y+poids;  
            }
        }

        else if(!control[0] && control[1] && control[2] && !control[3] &&  !duringDigging){             // aller en bas a droite
            direction[0]=false; direction[1]=true; direction[2]=false; direction[3]=false;
            this.animation.play("walk_Front_Right");
            zone = checkZone();
            if(!run)
            {
                this.velocity.x = maxVelocity.x/2;
                this.velocity.y = maxVelocity.y/2;
            }
            else
            {
                this.velocity.x = maxVelocity.x;
                this.velocity.y = maxVelocity.y;
            }
        }

        else if(!control[0] && !control[1] && control[2] && control[3] &&  !duringDigging)             // aller en bas a gauche
        {
            direction[0]=false; direction[1]=false; direction[2]=false; direction[3]=true;
            this.animation.play("walk_Front_Left");
            zone = checkZone();
            if(!run)
            {  
                this.velocity.x = -maxVelocity.x/2+poids;
                this.velocity.y =  maxVelocity.y/2-poids;
            }
            else
            {
                this.velocity.x = -maxVelocity.x;
                this.velocity.y =  maxVelocity.y;
            }
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

    public function setTheBasicCharPropriety(scene:PlayState):Void{
        zone = [0,0];
        /*Character*/
        run=false;
        duringDigging=false;
        control=[false,false,false,false];      // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        direction=[false,false,true,false];    // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        directionPos=[true,true,true,true];    // 0: vers le haut, 1: vers la droite, 2: vers le bas, 3: vers la gauche
        poids=0;
        //
        this.maxVelocity.x=200;
        this.maxVelocity.y=200;
        this.loadGraphic("assets/images/char.png",true,false,23,45,false,null);
        this.centerOffsets;
        scene.add(this);
        /*load circle */
        loadCircle=new FlxSprite();
        loadCircle.loadGraphic("assets/images/loadcircle.png",true,false,12,12,false,null);
        scene.add(loadCircle);
        loadCircle.alpha=0;
        loadCircle.x=this.x+this.width/4;
        loadCircle.y=this.y-this.height/4;
        nbCligno=0;
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
        if(direction[0] && !direction[1] && !direction[2] && !direction[3] )
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
        digging();
        checkPos();
        super.update();
    }

}
