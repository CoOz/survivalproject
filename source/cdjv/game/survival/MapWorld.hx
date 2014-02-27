package cdjv.game.survival;

import flixel.FlxG;
import flixel.util.FlxPool;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxTileblock;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxTypedGroupIterator;

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
    public var groupObj:FlxTypedGroup<FlxTileblock>;
    private var obj:FlxTileblock;

    private var bob:Int;
    //pour le premier passage dans generateMap
    public var a:Int;
    //private var tabMapAdjacent:Array<Int>;


    public function new(scene:PlayState){
        super();
        this.scene = scene;
       
        tabMap = [1,1,1,1,1,1,1,1,1,1,1,2,1,2,1,1,1,1,1,2,
                    1,1,1,1,1,1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,
                    1,1,1,2,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,2,
                    1,1,1,2,1,1,1,1,1,1,1,2,1,1,1,1,2,1,1,1,
                    1,1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,1,1,1,2,
                    1,1,1,1,1,2,1,1,1,1,2,1,1,1,1,1,1,2,1,1,
                    1,1,1,2,1,1,1,1,2,2,1,1,2,1,1,1,1,2,1,1,
                    1,1,1,1,2,1,1,1,1,1,2,1,1,1,1,1,1,2,1,1,
                    1,1,1,1,2,1,1,1,1,1,1,2,1,1,1,1,2,1,1,1,
                    1,2,1,1,1,1,1,1,1,2,1,1,1,1,2,1,1,1,1,1,
                    2,1,1,1,1,1,1,1,2,1,1,1,1,1,2,1,1,1,1,1,
                    1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,2,1,1,
                    1,1,1,1,1,1,2,1,1,1,1,1,1,1,2,1,1,1,1,1,
                    1,2,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,
                    1,1,1,1,2,1,1,1,1,1,2,2,1,1,1,2,1,1,1,2];

    
    a = 0;
    groupMap = new FlxTypedGroup(9);
    groupObj = new FlxTypedGroup(20);

    }

    /*private function recupFlxsprite(group:FlxTypedGroup, index:Int):FlxSprite{
        var bob:Array<FlxSprite>;
        bob = group.members();
        for(i in 0...index){
            bob = group.getFirstAlive();

        }    
    }*/

    /*private function recupFlxsprite(group:FlxTypedGroup, index:Int):FlxSprite{
        var bob:Array<FlxSprite>;
        bob = group.members();
        for(i in 0...index){
            bob = group.getFirstAlive();

        }    
    }*/

    private function exist(k:Int, l:Int):Bool{
        var i:Int;
        var bob:Array<FlxTileblock>;
        bob = groupObj.members;
        trace(bob);
        if(groupObj.countLiving() == -1)
            return false;
        else{
            for(i in 0...(groupObj.length -1)){
                trace(bob[i]);
                if((bob[i].x >= (k-34) && bob[i].x <= (k+34)) && (bob[i].y >= (l-33) && bob[i].y <= (l+33)))
                    return true;
            }
            return false;
        }
    }

    public function popAleaObject(zoneN:Array<Int>){
        var i,k,l:Int;
        i = Std.int(Math.random()*20);
        for(j in 0...i){
            obj = new FlxTileblock(Std.int(Math.random()*(800*(zoneN[0]+1))),Std.int(Math.random()*(600*(zoneN[1]+1))),24,28);  // pour créer un nouveau block http://api.haxeflixel.com/
            do{  
                k = Std.int(Math.random()*(800*(zoneN[0]+1)));
                l = Std.int(Math.random()*(600*(zoneN[1]+1)));                      
            }while(exist(k, l));
            obj.x = k;
            obj.y = l;
            obj.loadGraphic("assets/images/rock.png",false,false,24,28,false,null);
            groupObj.add(obj);
        }

        this.scene.add(groupObj);
   }

    public function generateMap(zoneN:Array<Int> ){
        if(a == 1){
            groupObj.clear();
            groupMap.clear();
        }
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
        this.popAleaObject(zoneN);

        //this.popAleaObject(zoneN);

    }
    //générer le graphic

    


    public function loadForCoords(xPos:Float,yPos:Float){
        if(xPos%FlxG.game.width<10 || xPos%FlxG.game.width>FlxG.game.width-10){ //bords!


        }

        loadDigMap(xPos,yPos);
    }

    public function loadDigMap(xPos:Float, yPos:Float){

    }
}