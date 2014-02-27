package cdjv.game.survival;

import flixel.util.FlxColorUtil;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.FlxSprite;

class DigMap{
    private var sprite:FlxSprite;
    private var scene:PlayState;
    private var zoneW:Int=10;
    private var zoneH:Int=10;
    private var lamap:Map<String,Int>;

    public function new(scene:PlayState){
        this.scene=scene;
        lamap=new Map<String,Int>();
        sprite=new FlxSprite();
        sprite.makeGraphic(FlxG.width,FlxG.height,0x00000000);
        sprite.x=0;sprite.y=0;
        for(i in 0...20*4){
            FlxSpriteUtil.drawLine(sprite,0,i*zoneW,800,i*zoneW,0xFF000000);
        }
        for(i in 0...15*4){
            FlxSpriteUtil.drawLine(sprite,i*zoneH,0,i*zoneH,600,0xFF000000);
        }
        //FlxSpriteUtil.drawRect(sprite,0,0,40,40,0xFFFFFFFF);
        //sprite.visible=false;
        this.scene.add(sprite);
        FlxG.game.stage.addEventListener(KeyboardEvent.KEY_DOWN,showGrid);
    }

    public function creuse(joueur:Character){
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
        trace("creuse "+xZone+" "+yZone);
        var cle:String=xZone+'-'+yZone;
        if(!lamap.exists(cle))
            lamap.set(cle,0);
        /*var alpha=(10-lamap.get(cle))*10;
        trace("a="+alpha);*/
        FlxSpriteUtil.drawRect(sprite,xZone*zoneW,yZone*zoneH,zoneW,zoneH,FlxColorUtil.makeFromARGB(30,0,0,0));
    }
    public function showGrid(key:KeyboardEvent){
        if(key.keyCode==Keyboard.K){
            sprite.visible=!sprite.visible;
            //creuse(Math.random()*100,Math.random()*100);
        }
    }
}