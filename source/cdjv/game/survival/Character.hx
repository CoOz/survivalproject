package cdjv.game.survival;

import flash.events.KeyboardEvent;
import flash.events.Event;
import flixel.FlxG;
import flixel.FlxSprite;

class Character extends FlxSprite{
    public var sceneJeu:PlayState;

    public function new(scene:PlayState){
        super();
        this.sceneJeu=scene;
        this.makeGraphic(2,2,0xFFFFFFFF);
        //this.loadGraphic()
        this.registerEvents();
    }

    public function registerEvents():Void{
        FlxG.game.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
        FlxG.game.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);

    }

    public function onKeyDown(evt:KeyboardEvent):Void{
        x++;

    }
    public function onKeyUp(evt:KeyboardEvent):Void{
        y++;


       //sceneJeu.surface.digMap.creuse(x,y);
    }


}