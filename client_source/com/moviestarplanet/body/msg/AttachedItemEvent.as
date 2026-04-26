package com.moviestarplanet.body.msg
{
   import flash.events.Event;
   
   public class AttachedItemEvent extends Event
   {
      
      public static const INSPECT:String = "INSPECT";
      
      public static const TAKEOFF:String = "TAKEOFF";
      
      public static const ITEM_ATTACHED:String = "ITEM_ATTACHED";
      
      public static const ITEM_DETACHING:String = "ITEM_DETACHING";
      
      public var data:*;
      
      public function AttachedItemEvent(param1:*, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param2,param3,param4);
         this.data = param1;
      }
   }
}

