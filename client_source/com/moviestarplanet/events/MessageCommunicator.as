package com.moviestarplanet.events
{
   import flash.events.EventDispatcher;
   
   public class MessageCommunicator
   {
      
      private static var comm:EventDispatcher = new EventDispatcher();
      
      public function MessageCommunicator()
      {
         super();
      }
      
      public static function subscribe(param1:String, param2:Function, param3:int = 0) : void
      {
         comm.addEventListener(param1,param2,false,param3,true);
      }
      
      public static function sendMessage(param1:String, param2:*) : void
      {
         send(new MsgEvent(param1,param2));
      }
      
      public static function send(param1:MsgEvent) : void
      {
         comm.dispatchEvent(param1);
      }
      
      public static function unscribe(param1:String, param2:Function) : void
      {
         comm.removeEventListener(param1,param2);
      }
   }
}

