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
    public var map2:FlxTilemap;
    public var groupMap:FlxTypedGroup<FlxTilemap>;
    public var digMap:DigMap;
    private var tabMap:Array<Int>;
    private var groupObj:FlxTypedGroup<FlxSprite>;
    private var obj:FlxSprite;
    private var bob:Int;
    //pour le premier passage dans generateMap
    public var a:Int;
    //private var tabMapAdjacent:Array<Int>;


    public function new(scene:PlayState){
        super();
        this.scene = scene;
       

        tabMap = [2,2,1,1,1,1,2,1,1,2,1,2,1,2,1,2,1,2,1,2,
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
    
    a = 0;
    groupMap = new FlxTypedGroup(9);
    
    }
    public function generateMap(zoneN:Array<Int> ){
        if(a == 1)
            groupMap.clear();
        else a = 1;
        //groupMap = new FlxTypedGroup(9);
        trace((zoneN[0]),zoneN[1]);
        for(j in (zoneN[0]-1)...(zoneN[0]+2))
            for(i in (zoneN[1]-1)...(zoneN[1]+2))
            {
                map2 = new FlxTilemap();
                map2.widthInTiles = 20;
                //number of tiles by column
                map2.heightInTiles = 15;
                map2.x = j * 800;
                map2.y = i * 600;
                map2.loadMap(tabMap, "assets/images/tile.png", 40, 40);
                map2.updateFrameData();
                groupMap.add(map2);
            }
        this.scene.add(groupMap);

    }
    //générer le graphic
/*
    public function popAleaObject(zoneN:Array<Int>){

        i = Math.random()*20;
        for(j in 0...j){
            obj = new FlxSprite();

            obj.x = Std.int(Math.random()*(800*(zoneN[0]+1)));
            obj.y = Std.int(Math.random()*(600*(zoneN[1]+1)));
            groupObj.add(obj);
        }

        this.scene.add(groupObj);
   }*/


    public function loadForCoords(xPos:Float,yPos:Float){
        if(xPos%FlxG.game.width<10 || xPos%FlxG.game.width>FlxG.game.width-10){ //bords!


        }

        loadDigMap(xPos,yPos);
    }

    public function loadDigMap(xPos:Float,yPos:Float){

    }
}