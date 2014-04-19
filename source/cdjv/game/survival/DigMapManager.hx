package cdjv.game.survival;

import flixel.group.FlxTypedGroup;

class DigMapManager{
    private var scene:PlayState;
    private var digMaps:Map<String,DigMap>;

    public function new(scene:PlayState){
        this.scene=scene;

        digMaps=new Map<String,DigMap>();
    }

    public function loadMap(zoneX:Int,zoneY:Int){
        var cle=zoneX+','+zoneY;
        if(!digMaps.exists(cle)){
            trace("loadMap",zoneX,zoneY);
            //on va la chercher sur la bdd

            //on déserialise+on génere

            digMaps.set(cle,new DigMap(this.scene,zoneX,zoneY));

        }else{
            trace("digmap existe "+cle);
        }
    }

    public function creuse(joueur:Character){
        trace("digman creuse");
        var z=joueur.checkZone().toString();
        var cle=z.substr(1,z.length-2);
        if(digMaps.exists(cle)){
            digMaps.get(cle).creuse(joueur);
        }
    }

    public function getProfondeur(joueur:Character):Int{
        var z=joueur.checkZone().toString();
        var cle=z.substr(1,z.length-2);
        if(digMaps.exists(cle)){
            return digMaps.get(cle).getProfondeur(joueur);
        }
        return 0;
    }
}