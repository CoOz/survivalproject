package cdjv.game.survival;
import flixel.FlxState;


class CharManager{

    public var joueurs:Map<Int,Character>;
    public var state:PlayState;
    public var j:Int;    
    public var flag: Int;
    public var nbpass: Int;
    public var tabpaquet:Array<String>; 
    public var tabJoueur:Array<Array<String>>;
    
    public function new(scene:PlayState){
        joueurs = new Map<Int,Character>();
        tabJoueur = new Array<Array<String>>();
        state = scene;
        nbpass=1;
        flag = 0;
    }

   /* public function recoitJoueurs(paquet:String){
        
        var bob:Array<String>;
        var tabJoueur:Array<Array<String>>;
        bob = new Array<String>(); 
        tabJoueur = new Array<Array<String>>();

        bob = StringTools.trim(paquet).split("]");
        trace(bob.pop());
        trace(bob);
        while(bob.length > 0){
            tabJoueur.push((bob.pop()).split(";")); // attention au premier "[" (corrigé dans le for grâce aux substring)
        }        
        for (i in 0...(tabJoueur.length-1)) {
            trace(tabJoueur[i]);
            creeJoueur(Std.parseInt(tabJoueur[i][0].substring(1, (tabJoueur[i].length-1))), tabJoueur[i][1], Std.parseInt(tabJoueur[i][2]), Std.parseInt(tabJoueur[i][3].substring(0, (tabJoueur[i].length-2))));
        }
    }*/

    public function recoitJoueurs(paquet:String){
            j = 0;
            paquet=paquet.substring(1,paquet.length);
            while(paquet.charAt(j)=='[')
            {
                tabpaquet = new Array<String>();
                while(paquet.charAt(j)!=']' && j<49)
                {
                    for(i in 0...4)
                    {
                        if(paquet.charAt(j)=='[' || paquet.charAt(j)==';')
                        {
                            j++;
                            tabpaquet[i]=paquet.charAt(j);
                            j++;
                        }
                        while(paquet.charAt(j)!=';' && paquet.charAt(j)!=']')
                        {
                            tabpaquet[i]+=paquet.charAt(j);
                            j++;
                        }
                    }
                    tabJoueur.insert(flag, tabpaquet);
                }
            }
            trace(tabJoueur);
            for (i in 0...(tabJoueur.length-1)) 
                creeJoueur(Std.parseInt(tabJoueur[i][0]), tabJoueur[i][1], Std.parseInt(tabJoueur[i][2]), Std.parseInt(tabJoueur[i][3]));
    }

    public function creeJoueur(id:Int,pseudo:String,x:Int,y:Int){ 
        var perso:Character;
        perso = new Character(state, pseudo, x, y);
        state.add(perso);
    }

    public function delJoueur(id:Int){
        if(joueurs.exists(id))
            joueurs.remove(id);
    }

    public function traiteSetPos(paquet:String){
        var bob:Array<String>;
        var tabJoueur:Array<Array<String>>;
        bob = new Array<String>(); 
        tabJoueur = new Array<Array<String>>();
        bob = paquet.split("]");
        while(bob.length > 0){
            tabJoueur.push((bob.pop()).split(";"));
        }        
        for (i in 0...(tabJoueur.length-1) ){
            setPosition(Std.parseInt(tabJoueur[i][0].substring(1, (tabJoueur[i].length-1))), Std.parseInt(tabJoueur[i][1]), Std.parseInt(tabJoueur[i][2].substring(0, (tabJoueur[i].length-2))));

        }

    }

    public function setPosition(id:Int,x:Int,y:Int){
        if(joueurs.exists(id))
            joueurs.get(id).setPosition(x, y);

        

    }
}