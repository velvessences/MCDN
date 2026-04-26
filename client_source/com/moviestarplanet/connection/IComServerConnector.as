package com.moviestarplanet.connection
{
   import flash.net.NetConnection;
   
   public interface IComServerConnector
   {
      
      function get userId() : int;
      
      function closeAllConnections() : void;
      
      function getNetConnection(param1:Number) : NetConnection;
      
      function getComServerConnection(param1:Number) : IComServerConnection;
      
      function callOnAllConnections(param1:String, param2:*) : void;
      
      function get isConnected() : Boolean;
      
      function get connectionList() : Array;
      
      function onLoginSuccess(param1:Number) : void;
      
      function onDoLogout() : void;
      
      function close() : void;
   }
}

