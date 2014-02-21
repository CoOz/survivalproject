package cdjv.game.survival;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
* A FlxState which can be used for the actual gameplay.
*/
class PlayState extends FlxState
{
public var surface:MapWorld;
public var zoneN:Array<Int>;
public var zoneP:String;
private var perso:Character;

override public function create():Void
{
// Set a background color
FlxG.cameras.bgColor = 0xff000000;
// Show the mouse (in case it hasn't been disabled)
#if !FLX_NO_MOUSE
FlxG.mouse.show();
#end

        //on crée un monde
        surface=new MapWorld(this);
        //modifier le param suivant la dernière position du personnage
        surface.generateMap([0,0]);
        //surface.setPosition(0,0);
        //this.add(surface);*/

        //on crée un perso
        perso = new Character(this);
        
        perso.setPosition(50,50);
        this.add(perso);
        zoneP = perso.checkZone().toString();
        trace(zoneP);

        surface.loadForCoords(perso.x,perso.y);

        FlxG.camera.target=perso;


        super.create();
}


/**
* Function that is called when this state is destroyed - you might want to
* consider setting all objects this state uses to null to help garbage collection.
*/

override public function destroy():Void
{
        super.destroy();
}

/**
* Function that is called once every frame.
*/
override public function update():Void
{
        zoneN = perso.checkZone();
        if((zoneN.toString()) != zoneP){
                //appele generateMap avec zoneN
                surface.generateMap(zoneN);
                zoneP = zoneN.toString();
        }
        super.update();
}	
}

