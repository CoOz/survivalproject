package cdjv.game.survival;

import flixel.FlxG;
import flixel.util.FlxPool;
import flixel.tile.FlxTilemap;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

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
    public var groupMap:FlxTypedGroup<FlxTilemap>;
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

    /*map = new FlxTilemap();
    //number of tiles by line
    map.widthInTiles = 20; 
    //number of tiles by column
    map.heightInTiles = 15;
    // Setting up the map.
    
    //map.startingIndex = 2;
    //map.drawIndex = 2;
    map.loadMap(tabMap, "assets/images/tile.png", 40, 40);
    map.updateFrameData();
    map.x = 0;//-335;
    map.y = 0;//-225;*/
    groupMap = new FlxTypedGroup(9);
    //groupMap.forEach(genSurfaceTest);
    
    //groupMap.updateFrameData();
    this.scene.add(groupMap);//add(map);


        /*this.scene=scene;
        tileMapPool=new FlxPool<FlxTilemap>();
        for(nbTM in 2...9)
            tileMapPool.put(new FlxTilemap());

        this.loadGraphic("assets/images/desert.jpg");
*/
    }
    /*private function genSurface(zone:Array<Int>):FlxTilemap
    { 
        var map2:FlxTilemap;
        if(zone[0] == 0 && zone[1] == 0)
        {
            map2 = new FlxTilemap();
            //number of tiles by line
            map.widthInTiles = 20; 
            //number of tiles by column
            map.heightInTiles = 15;
            map2.x = zone[0]*800;
            map2.y = zone[0]*800;
            map2.loadMap(tabMap, "assets/images/tile.png", 40, 40);
            map2.updateFrameData();
            //this.scene.add(map2);
            return(map2);
        }
        return(map2);

    }*/
    public function genSurfaceTest(map2:FlxTilemap):Void
    { 
           // Static var x = 0:Int;
            
        //if(zone[0] == 0 && zone[1] == 0)
        //{
            //map2 = new FlxTilemap();
            //number of tiles by line
            map2.widthInTiles = 20; 
            //number of tiles by column
            map.heightInTiles = 15;
            map2.x = 0 * 800;
            map2.y = 0 * 600;
            map2.loadMap(tabMap, "assets/images/tile.png", 40, 40);
            map2.updateFrameData();
            //x = x+1;
            //this.scene.add(map2);
            
        //}

    }
    public function loadForCoords(xPos:Float,yPos:Float){
        if(xPos%FlxG.game.width<10 || xPos%FlxG.game.width>FlxG.game.width-10){ //bords!


        }

        loadDigMap(xPos,yPos);
    }

    public function loadDigMap(xPos:Float,yPos:Float){

    }
}