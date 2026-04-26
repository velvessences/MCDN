package com.moviestarplanet.windowpopup.popup
{
   import flash.events.Event;
   
   public class PromptEvent extends Event
   {
      
      public static var CLOSE:String = "close";
      
      public var detail:int;
      
      public function PromptEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1)
      {
         super(param1,param2,param3);
         this.detail = param4;
      }
      
      override public function clone() : Event
      {
         return new PromptEvent(type,bubbles,cancelable,this.detail);
      }
   }
}

