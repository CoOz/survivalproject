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
    //private var tabMapAdjacent:Array<Int>;


    public function new(scene:PlayState){
        super();
        this.scene = scene;
       // tabMapAdjacent = []
        tabMap =    [2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
                     2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2];
    //tileToFlxSprite();
    // setCustomTileMappings()

    map = new FlxTilemap();
    //number of tiles by line
    map.widthInTiles = 20; 
    //number of tiles by column
    map.heightInTiles = 15;
    // Setting up the map.
    
    //map.startingIndex = 2;
    //map.drawIndex = 2;
    map.loadMap(tabMap, "assets/images/tile.png", 40, 40);
    map.updateFrameData();
    //map.setTile(prevX+1,prevY,2,true);

    this.scene.add(map);
//add(map);


        /*this.scene=scene;
        tileMapPool=new FlxPool<FlxTilemap>();
        for(nbTM in 2...9)
            tileMapPool.put(new FlxTilemap());

        this.loadGraphic("assets/images/desert.jpg");
*/
        digMap=new DigMap(scene);
    }
    public function loadForCoords(xPos:Float,yPos:Float){
        if(xPos%FlxG.game.width<10 || xPos%FlxG.game.width>FlxG.game.width-10){ //bords!

        }

        loadDigMap(xPos,yPos);
    }

    public function loadDigMap(xPos:Float,yPos:Float){

    }
}