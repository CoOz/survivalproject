package cdjv.game.survival;

import cdjv.game.survival.DigMapManager;
import flixel.FlxG;
import flixel.util.FlxPool;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxTileblock;
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
    public var digMan:DigMapManager;
    private var tabMap:Array<Int>;
    public var groupObj:FlxTypedGroup<FlxTileblock>;
    public var groupArbre:FlxTypedGroup<FlxTileblock>;
    private var obj:FlxTileblock;
    private var arbre:FlxTileblock;
    private var bob:Int;
    //pour le premier passage dans generateMap
    public var a:Int;
    //private var tabMapAdjacent:Array<Int>;
    public function new(scene:PlayState){
        super();
        this.scene = scene;

        tabMap = [1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,
                    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,
                    1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1,1];
    
    a = 0;
    groupMap = new FlxTypedGroup(0);
    groupObj = new FlxTypedGroup(20);
    groupArbre = new FlxTypedGroup(20);

        this.scene.add(groupMap);
        digMan=new DigMapManager(scene);
    }

    public function popAleaObject(zoneN:Array<Int>){
        var i:Int;
        i = Std.int(Math.random()*20);
        for(j in 0...i){
            obj = new FlxTileblock(Std.int(Math.random()*(800*(zoneN[0]+1))),Std.int(Math.random()*(600*(zoneN[1]+1))),24,28); // pour créer un nouveau block http://api.haxeflixel.com/
            obj.loadGraphic("assets/images/rock.png",false,false,24,28,false,null);
            groupObj.add(obj);
        }

        this.scene.add(groupObj);
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
                map2.loadMap(tabMap, "assets/images/tilesmap2.png", 40,40);
                map2.updateFrameData();
                groupMap.add(map2);
                digMan.loadMap(j,i);
            }
        //this.scene.add(groupMap);
        this.popAleaObject(zoneN);
     ///   putsomefantasy(zoneN);

    }

    public function putsomefantasy(zoneN:Array<Int>)
    {
        arbre = new FlxTileblock(10,10,200,170);
        obj.loadGraphic("assets/images/arbre.PNG",false,false,200,170,false,null);
        groupArbre.add(arbre);
        this.scene.add(groupArbre);
    }
    //générer le graphic

   /* public function generateMap(zoneN:Array<Int> ){
        if(a == 1){
            groupObj.clear();
            groupMap.clear();
        }
        else a = 1;
        //groupMap = new FlxTypedGroup(9);
        trace((zoneN[0]), zoneN[1]);
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

                digMan.loadMap(j,i);
                groupMap.add(map2);
                // afficher les map après avec un foreach
                //map2.updateFrameData();
            }
        for(i in 0...groupMap.length){
            groupMap.members[i].updateFrameData(); 
        }
        this.popAleaObject(zoneN);
    }*/
    

    public function loadForCoords(xPos:Float,yPos:Float){
        if(xPos%FlxG.game.width<10 || xPos%FlxG.game.width>FlxG.game.width-10){ //bords!


        }

        loadDigMap(xPos,yPos);
    }

    public function loadDigMap(xPos:Float, yPos:Float){
    }
}