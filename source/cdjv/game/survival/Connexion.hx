package cdjv.game.survival;

import cdjv.game.survival.LoginManager;
import flixel.FlxG;
import flixel.FlxState;
import sockjs.SockJS;

class Connexion{
    public var connected:Bool;
    public var socket:SockJS;
    private var uid:String;
    public var scene:Playstate;

<<<<<<< HEAD
    public function new(scene:Playstate){
        init();
        this.scene = scene;
=======
    public function new(){
  //      init();
>>>>>>> 621aef6b1a70c86ce020ee98444a827655e4840c
    }
    public function init(){
        socket=new SockJS("http://172.20.73.235:9999/survival", {reconnect: true});
        // Listen open event
        socket.onOpen(function() {
            trace("[sock]connected");
            connected=true;
        });

        // Listen message event
        socket.onMessage(function(message) {
            trace("[sock]<-"+message);
            dispatch(message);
        });

        // Listen error event
        socket.onError(function(error) {
            trace("[sock][err]"+error);
        });

        // Listen close event
        socket.onClose(function() {
            trace("[sock]close");
        });

        // Connect socket
        socket.connect();
    }
    public function send(paquet:String){
        trace("[sock]->"+paquet);
        socket.send(paquet);
    }
    public function sLogin(pseudo:String){
        trace("login "+pseudo);
        socket.send("l"+pseudo);
    }
    public function sCreuse(x:Int,y:Int){
        send("c"+x+";"+y);
    }
    public function sPos(x:Float,y:Float){
        send("p"+x+";"+y);
    }
    /** Reçoit les paquets depuis le serveur et les route vers les bonnes méthodes */
    public function dispatch(message:String){
        switch(message.charAt(0)){
            case 'l':
                var test:LoginManager=cast FlxG.state;
                test.loginOK();
            case 'j':
<<<<<<< HEAD
                charMan.recoitJoueurs(message);
=======
               // CharManager.recoitJoueurs(message);
>>>>>>> 621aef6b1a70c86ce020ee98444a827655e4840c
            default:
                trace('paquet incorrect! '+message);
        }
    }



}