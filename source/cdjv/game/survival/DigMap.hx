package cdjv.game.survival;

import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.FlxSprite;

class DigMap{
    private var sprite:FlxSprite;
    private var scene:PlayState;

    public function new(scene:PlayState){
        this.scene=scene;
        sprite=new FlxSprite();
        sprite.makeGraphic(FlxG.width,FlxG.height,0x00000000);
        sprite.x=0;sprite.y=0;
        for(i in 0...20*4){
            FlxSpriteUtil.drawLine(sprite,0,i*10,800,i*10,0xFF000000);
        }
        for(i in 0...15*4){
            FlxSpriteUtil.drawLine(sprite,i*10,0,i*10,600,0xFF000000);
        }
        //FlxSpriteUtil.drawRect(sprite,0,0,40,40,0xFFFFFFFF);

        this.scene.add(sprite);
    }

    public function creuse(x:Float,y:Float){

    }
}