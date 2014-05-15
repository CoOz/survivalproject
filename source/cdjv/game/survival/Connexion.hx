package cdjv.game.survival;

import sockjs.SockJS;

class Connexion{
    public var connected:Bool;
    public var socket:SockJS;
    private var uid:String;

    public function new(){
        init();
    }
    public function init(){
        socket=new SockJS("http://172.20.73.35:9999/survival", {reconnect: true});
        // Listen open event
        socket.onOpen(function() {
            trace("[sock]connected");
            connected=true;
        });

        // Listen message event
        socket.onMessage(function(message) {
            trace("[sock]<-"+message);
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

    }
    public function sCreuse(x:Int,y:Int){
        send("c"+x+";"+y);
    }



}