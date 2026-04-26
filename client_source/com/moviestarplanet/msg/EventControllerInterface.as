package com.moviestarplanet.msg
{
   import flash.events.IEventDispatcher;
   
   public interface EventControllerInterface
   {
      
      function listenForEvent(param1:IEventDispatcher, param2:String, param3:int = 0) : void;
      
      function notifyMe(param1:Function, ... rest) : void;
      
      function removeNotify() : void;
      
      function hasCompleted() : Boolean;
   }
}

