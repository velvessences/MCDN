package com.moviestarplanet.mobile.msg
{
   import flash.events.Event;
   
   public class ObjectEvent extends Event
   {
      
      public var obj:Object;
      
      public function ObjectEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.obj = param2;
      }
      
      override public function clone() : Event
      {
         return new ObjectEvent(type,this.obj,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("StringEvent","obj","type","bubbles","cancelable","eventPhase");
      }
   }
}

