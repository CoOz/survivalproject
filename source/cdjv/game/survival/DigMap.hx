package cdjv.game.survival;

import flixel.text.FlxText;
import flixel.text.FlxText;
import flash.geom.Rectangle;
import flixel.util.FlxRect;
import flash.display.BlendMode;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.FlxSprite;

class DigMap{
    private var sprite:FlxSprite;
    private var scene:PlayState;
    private var zoneW:Int=20;
    private var zoneH:Int=20;
    private var profondeurMax:Int=16;
    private var zoneX:Int;
    private var zoneY:Int;
    private var lamap:Map<String,Int>;

    public function new(scene:PlayState,zoneX:Int,zoneY:Int){
        this.scene=scene;this.zoneX=zoneX;this.zoneY=zoneY;
        lamap=new Map<String,Int>();
        sprite=new FlxSprite();
        sprite.makeGraphic(FlxG.width,FlxG.height,0x00000000);
        sprite.x=zoneX*FlxG.width;sprite.y=zoneY*FlxG.height;
        for(i in 0...Std.int(FlxG.height/zoneH)){
            //FlxSpriteUtil.drawLine(sprite,0,i*zoneH,FlxG.width,i*zoneH,0xFF000000);
        }
        for(i in 0...Std.int(FlxG.width/zoneW)){
            //FlxSpriteUtil.drawLine(sprite,i*zoneW,0,i*zoneW,FlxG.height,0xFF000000);
            //trace(i*zoneH);
        }
        var nom:FlxText=new FlxText(sprite.x+20,sprite.y+20,300,zoneX+','+zoneY);

        sprite.blend=BlendMode.LAYER;
        //FlxSpriteUtil.drawRect(sprite,0,0,40,40,0xFFFFFFFF);

        //sprite.visible=false;
        this.scene.add(sprite);
        this.scene.add(nom);
        FlxG.game.stage.addEventListener(KeyboardEvent.KEY_DOWN,showGrid);
    }

    /** Renvoie l'index de la zone de creusage en fonction des coordonnées passées en parametres */
    public function getZoneIndex(joueur:Character):Array<Int>{
        var x:Float=0,y:Float=0;
        if(joueur.direction[0]){
            x=joueur.x+joueur.width/2-zoneW/2;
            y=joueur.y-zoneH;
        }else if(joueur.direction[1]){
            x=joueur.x+joueur.width;
            y=joueur.y+joueur.height/2;
        }else if(joueur.direction[2]){
            x=joueur.x+joueur.width/2-zoneW/2;
            y=joueur.y+joueur.height;
        }else if(joueur.direction[3]){
            x=joueur.x-zoneW;
            y=joueur.y+joueur.height/2;
        }
        var xZone=Math.round(x/zoneW);
        var yZone=Math.round(y/zoneH);
        return [xZone,yZone];
    }

    public function creuse(joueur:Character){
        var zoneIndex=getZoneIndex(joueur);
        var xZone=zoneIndex[0];
        var yZone=zoneIndex[1];
        //trace("creuse "+xZone+" "+yZone,xZone*zoneW-sprite.x,sprite.x);
        var cle:String=buildKey(xZone,yZone);
        if(!lamap.exists(cle))
            lamap.set(cle,0);
        else
            if(lamap.get(cle)<profondeurMax){
                lamap.set(cle,lamap.get(cle)+1);
                /*var alpha=(10-lamap.get(cle))*10;
                trace("a="+alpha);*/
                //FlxSpriteUtil.drawRect(sprite,xZone*zoneW-sprite.x,yZone*zoneH-sprite.y,zoneW,zoneH,FlxColorUtil.makeFromARGB(20,0,0,0));
                //FlxSpriteUtil.drawRect(sprite,xZone*zoneW-sprite.x,yZone*zoneH-sprite.y,zoneW,lamap.get(cle),FlxColorUtil.makeFromARGB(30,0,0,0));
                //FlxSpriteUtil.drawRect(sprite,xZone*zoneW-sprite.x,yZone*zoneH-sprite.y,lamap.get(cle),zoneH,FlxColorUtil.makeFromARGB(30,0,0,0));
                //FlxSpriteUtil.drawLine(sprite,xZone*zoneW-sprite.x,yZone*zoneH-sprite.y,xZone*zoneW-sprite.x+zoneW,yZone*zoneH-sprite.y,FlxColor.BLACK);
                //trace(lamap.get(cle),xZone*zoneW-sprite.x,xZone*zoneW-sprite.x+zoneW,yZone*zoneH-sprite.y);
                //drawShadows();
                drawDig(xZone,yZone,lamap.get(cle));
            }
    }

    public function drawDig(xZone:Int,yZone:Int,profondeur:Int,updateCon:Bool=true){
        trace("drawDig",xZone,yZone,profondeur);
        var deltaUp:Int=0;
        var deltaLeft:Int=0;
        var deltaUpLeft:Int=0;
        sprite.pixels.fillRect(new Rectangle(xZone*zoneW+sprite.x,yZone*zoneH+sprite.y,zoneW,zoneH),0x00000000);
        //FlxSpriteUtil.drawRect(sprite,xZone*zoneW+sprite.x,yZone*zoneH+sprite.y,zoneW,zoneH,FlxColorUtil.makeFromARGB(0,0,0,0),ls,fs,dsErase);
        FlxSpriteUtil.drawRect(sprite,xZone*zoneW+sprite.x,yZone*zoneH+sprite.y,zoneW,zoneH,FlxColorUtil.makeFromARGB(profondeur*10,0,0,0));

        /*cleCase=buildKey(xZone-1,yZone-1);
        //hautgauche
        var profUpLeft:Int=(lamap.exists(cleCase)?lamap.get(cleCase):0);
        trace(cleCase,'hautgauche',profUpLeft,profondeur);
        if(profUpLeft<profondeur){
            deltaUpLeft=profondeur-profUpLeft;
            //on affiche l'ombre avec une hauteur = delta
            //sprite.pixels.fillRect(new Rectangle(xZone*zoneW+sprite.x,yZone*zoneH+sprite.y,deltaUpLeft/2,deltaUpLeft),FlxColorUtil.makeFromARGB((profondeur*10)+50,0,0,0));
            FlxSpriteUtil.drawRect(sprite,xZone*zoneW+sprite.x,yZone*zoneH+sprite.y,deltaUpLeft/2,deltaUpLeft,FlxColorUtil.makeFromARGB(100,0,0,0));
        }*/


        var cleCase:String=buildKey(xZone,yZone-1);
        //au dessus
        var profHaut:Int=(lamap.exists(cleCase)?lamap.get(cleCase):0);
        //trace(cleCase,'dessus',profHaut,profondeur,profondeur-profHaut);
        if(profHaut<profondeur){
            deltaUp=profondeur-profHaut;
            //on affiche l'ombre avec une hauteur = delta
            //FlxSpriteUtil.drawRect(sprite,xZone*zoneW+sprite.x,yZone*zoneH+sprite.y,zoneW,profondeur-prof,FlxColorUtil.makeFromARGB(0,0,0,0));
            FlxSpriteUtil.drawRect(sprite,xZone*zoneW+sprite.x,yZone*zoneH+sprite.y,zoneW,deltaUp,FlxColorUtil.makeFromARGB(100,0,0,0));
        }
        cleCase=buildKey(xZone-1,yZone);
        //agauche
        var profLeft:Int=(lamap.exists(cleCase)?lamap.get(cleCase):0);
        //trace(cleCase,'a gauche',profLeft,profondeur);
        if(profLeft<profondeur){
            deltaLeft=profondeur-profLeft;
            //on affiche l'ombre avec une hauteur = delta
            //sprite.pixels.fillRect(new Rectangle(xZone*zoneW+sprite.x,(yZone+1)*zoneH+sprite.y,zoneW,zoneH),FlxColorUtil.makeFromARGB(prof*10,0,0,0));
            FlxSpriteUtil.drawRect(sprite,xZone*zoneW+sprite.x,yZone*zoneH+sprite.y+deltaUp,deltaLeft/2,zoneH-deltaUp,FlxColorUtil.makeFromARGB(100,0,0,0));
        }

        if(updateCon){
            cleCase=buildKey(xZone,yZone+1);
            if(lamap.exists(cleCase)){
                drawDig(xZone,yZone+1,lamap.get(cleCase),false);
            }
            cleCase=buildKey(xZone+1,yZone);
            if(lamap.exists(cleCase)){
                drawDig(xZone+1,yZone,lamap.get(cleCase),false);
            }
            /*cleCase=buildKey(xZone-1,yZone-1);
            if(lamap.exists(cleCase)){
                drawDig(xZone+1,yZone,lamap.get(cleCase),false);
            }*/
        }

    }

    public function drawShadows(){
         for(cle in lamap.keys()){
             var coords:Array<String>=cle.split(';');
             var x:Int=Std.parseInt(coords[0]);
             var y:Int=Std.parseInt(coords[1]);
             var xZone=x*zoneW+sprite.x;
             var yZone=y*zoneH+sprite.y;
             trace("draw",x,y,xZone,yZone);
             if(lamap.exists(x+';'+(y-1))){
                //case au dessus
                 trace("case au dessus");
             }else{
                 FlxSpriteUtil.drawRect(sprite,x*zoneW-sprite.x,y*zoneH-sprite.y,zoneW,lamap.get(cle),FlxColorUtil.makeFromARGB(30,0,0,0));
             }
             if(lamap.exists((x-1)+';'+y)){
                //case à gauche
                 trace("case a gauche");
             }else{
                 FlxSpriteUtil.drawRect(sprite,x*zoneW-sprite.x,y*zoneH-sprite.y,lamap.get(cle),zoneH,FlxColorUtil.makeFromARGB(30,0,0,0));

             }
             FlxSpriteUtil.drawRect(sprite,x*zoneW-sprite.x,y*zoneH-sprite.y,zoneW,zoneH,FlxColorUtil.makeFromARGB(20,0,0,0));
         }
    }

    public function buildKey(xZone:Int,yZone:Int):String{
        return xZone+';'+yZone;
    }

    public function showGrid(key:KeyboardEvent){
        if(key.keyCode==Keyboard.K){    
            sprite.visible=!sprite.visible;
            //creuse(Math.random()*100,Math.random()*100);
        }
    }

    /** Renvoie la valeur de profondeur pour les coordonnées demandées en paramètres */
    public function getProfondeur(joueur:Character):Int{
        var xZone=Math.round(joueur.getXCenter()/zoneW);
        var yZone=Math.round(joueur.getYCenter()/zoneH);

        var cle=buildKey(xZone,yZone);
        trace("getProfondeur "+cle);
        if(lamap.exists(cle)){
            return lamap.get(cle);
        }else{
            return 0;
        }
    }
}