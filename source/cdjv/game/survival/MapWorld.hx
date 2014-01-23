package cdjv.game.survival;

import flixel.FlxG;
import flixel.util.FlxPool;
import flixel.tile.FlxTilemap;
import flixel.FlxSprite;

class MapWorld extends FlxSprite{
    private var scene:PlayState;
    private var zones:Map<String,FlxTilemap>;
    private var tileMapPool:FlxPool<FlxTilemap>;
    // Loading the map.
   /* [Embed(source = "data/map.txt", mimeType = "application/octet-stream")] private var txtMap:Class;
    // Loading the map spritesheet.
    [Embed(source = "data/tile.png")] private var imgMap:Class;*/
    // Map variable
    public var map:FlxTilemap;
    public var digMap:DigMap;

    public function new(scene:PlayState){
        super();
    // Setting up the map.
        //array 20c 15l
   /* map = new FlxTilemap();
    map.startingIndex = 0;
    map.drawIndex = 0;
    map.loadMap(new txtMap, imgMap, 40, 40);*/
    //add(map);
        /*this.scene=scene;
        tileMapPool=new FlxPool<FlxTilemap>();
        for(nbTM in 0...9)
            tileMapPool.put(new FlxTilemap());

        this.loadGraphic("assets/images/desert.jpg");
*/
    }
    public function loadForCoords(xPos:Float,yPos:Float){
        if(xPos%FlxG.game.width<10 || xPos%FlxG.game.width>FlxG.game.width-10){ //bords!

        }

        loadDigMap(xPos,yPos);
    }

    public function loadDigMap(xPos:Float,yPos:Float){

    }
}