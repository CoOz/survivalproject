import cdjv.game.survival.Character;

class CharManager{

    public var joueurs:Map<Int,Character>;
    

    public function new(scene:PlayState){
        joueurs = new Map<Int,Character>();

    }

    public function recoitJoueurs(paquet:String){
        var bob:Array<String>;
        var tabJoueur:Array<Array<String>>;
        bob = new Array<String>(); 
        tabJoueur = new Array<Array<String>>();
        bob = paquet.split("]");
        while(bob.length){
            tabJoueur.push((bob.pop()).split(";")); // attention au premier "[" (corrigé dans le for grâce aux substring)
        }        
        for (i in 0...(tabJoueur.length-1) {
            creeJoueur(parseInt(tabJoueur[i][0].substring(1, (tabJoueur[i].length-1))), tabJoueur[i][1], parseInt(tabJoueur[i][2]), parseInt(tabJoueur[i][3].substring(0, (tabJoueur[i].length-2))));
        }
    }

    public function creeJoueur(id:Int,pseudo:String,x:Int,y:Int){ 
        var perso:Character;
        perso = new Character(FlxG.State, pseudo, x, y);
        joueurs.set(id, perso);
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
        while(bob.length){
            tabJoueur.push((bob.pop()).split(";"));
        }        
        for (i in 0...(tabJoueur.length-1) {
            setPosition(parseInt(tabJoueur[i][0].substring(1, (tabJoueur[i].length-1))), parseInt(tabJoueur[i][1]), parseInt(tabJoueur[i][2].substring(0, (tabJoueur[i].length-2))));
        }

    }

    public function setPosition(id:Int,x:Int,y:Int){
        if(joueurs.exists(id){
            joueurs.get(id).setPosition(x, y);
        }
    }
}