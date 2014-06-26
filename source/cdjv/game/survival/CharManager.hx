<<<<<<< HEAD
package cdjv.game.survival;
import flixel.FlxState;
=======
import cdjv.game.survival.Character;
import flixel.FlxG;

>>>>>>> 621aef6b1a70c86ce020ee98444a827655e4840c
class CharManager{

    public var joueurs:Map<Int,Character>;
    public var state:FlxState;    

    public function new(scene:PlayState){
        joueurs = new Map<Int,Character>();
        state = scene;

    }

    public function recoitJoueurs(paquet:String){
        var bob:Array<String>;
        var tabJoueur:Array<Array<String>>;
        bob = new Array<String>(); 
        tabJoueur = new Array<Array<String>>();
        bob = paquet.split("]");
<<<<<<< HEAD
        while(bob.length > 0){
            tabJoueur.push((bob.pop()).split(";")); // attention au premier "[" (corrigé dans le for grâce aux substring)
        }        
        for (i in 0...(tabJoueur.length-1)) {
            creeJoueur(Std.parseInt(tabJoueur[i][0].substring(1, (tabJoueur[i].length-1))), tabJoueur[i][1], Std.parseInt(tabJoueur[i][2]), Std.parseInt(tabJoueur[i][3].substring(0, (tabJoueur[i].length-2))));
=======
        while(bob.length>0){
            tabJoueur.push((bob.pop()).split(";")); // attention au premier "[" (corrigé dans le for grâce aux substring)
        }        
        for (i in 0...(tabJoueur.length-1)) {
            creeJoueur(Std.parseInt(tabJoueur[i][0].substring(1, (tabJoueur[i].length-1))), tabJoueur[i][1],
                             Std.parseInt(tabJoueur[i][2]), Std.parseInt(tabJoueur[i][3].substring(0, (tabJoueur[i].length-2))));
>>>>>>> 621aef6b1a70c86ce020ee98444a827655e4840c
        }
    }

    public function creeJoueur(id:Int,pseudo:String,x:Int,y:Int){ 
        var perso:Character;
<<<<<<< HEAD
        perso = new Character(CharManager.state, pseudo, x, y);
=======
        perso = new Character(FlxG.state, pseudo, x, y);
>>>>>>> 621aef6b1a70c86ce020ee98444a827655e4840c
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
<<<<<<< HEAD
        while(bob.length > 0){
            tabJoueur.push((bob.pop()).split(";"));
        }        
        for (i in 0...(tabJoueur.length-1) ){
            setPosition(Std.parseInt(tabJoueur[i][0].substring(1, (tabJoueur[i].length-1))), Std.parseInt(tabJoueur[i][1]), Std.parseInt(tabJoueur[i][2].substring(0, (tabJoueur[i].length-2))));
=======
        while(bob.length>0){
            tabJoueur.push((bob.pop()).split(";"));
        }        
        for (i in 0...(tabJoueur.length-1)) {
            setPosition(Std.parseInt(tabJoueur[i][0].substring(1, (tabJoueur[i].length-1))), Std.parseInt(tabJoueur[i][1]),
                             Std.parseInt(tabJoueur[i][2].substring(0, (tabJoueur[i].length-2))));
>>>>>>> 621aef6b1a70c86ce020ee98444a827655e4840c
        }

    }

    public function setPosition(id:Int,x:Int,y:Int){
        if(joueurs.exists(id))
            joueurs.get(id).setPosition(x, y);
<<<<<<< HEAD
        
=======
>>>>>>> 621aef6b1a70c86ce020ee98444a827655e4840c
    }
}