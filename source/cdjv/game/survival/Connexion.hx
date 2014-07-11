package cdjv.game.survival;

import cdjv.game.survival.LoginManager;
import flixel.FlxG;
import flixel.FlxState;
import sockjs.SockJS;

class Connexion{
    public var connected:Bool;
    public var socket:SockJS;
    private var uid:String;
    public var scene:PlayState;

    public function new(){
        //init();
        
    }
    public function init(){
        //socket=new SockJS("http://172.20.73.235:9999/survival", {reconnect: true});
        socket=new SockJS("http://127.0.0.1:9999/survival", {reconnect: true});                     // connexion en local
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
               // scene.charMan.recoitJoueurs(message);              ALLER JOEL AU BOULOT UN PEU LA ! x)
            default:
                trace('paquet incorrect! '+message);
        }
    }
    public function setPlayState(scene:PlayState){
        this.scene = scene;

    }



}