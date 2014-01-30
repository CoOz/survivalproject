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
    //[Embed(source = "data/map.txt", mimeType = "application/octet-stream")] private var txtMap:Class;
    // Loading the map spritesheet.
    //[Embed(source = "data/tile.png")] private var imgMap:Class;
    // Map variable
    public var map:FlxTilemap;
    public var digMap:DigMap;
    private var tabMap:Array<Int>;


    public function new(scene:PlayState){
        super();
        this.scene = scene;
        tabMap =    [0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0
                     0,0,1,1,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0];
    map = new FlxTilemap();
    map.widthInTiles = 40;
    map.heightInTiles = 40;
    // Setting up the map.
    
    //map.startingIndex = 0;
    //map.drawIndex = 0;
    map.loadMap(tabMap, "assets/images/tile.png", 40, 40);
    map.updateFrameData();

    this.scene.add(map);
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