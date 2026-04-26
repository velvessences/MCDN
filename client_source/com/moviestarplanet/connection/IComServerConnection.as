package com.moviestarplanet.connection
{
   import flash.net.NetConnection;
   
   public interface IComServerConnection
   {
      
      function get uri() : String;
      
      function closeConnection() : void;
      
      function connect(param1:int, param2:Function = null) : void;
      
      function get netConnection() : NetConnection;
      
      function get connected() : Boolean;
   }
}

