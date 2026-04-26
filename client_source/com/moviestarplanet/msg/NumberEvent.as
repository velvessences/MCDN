package com.moviestarplanet.msg
{
   import flash.events.Event;
   
   public class NumberEvent extends Event
   {
      
      public var num:Number;
      
      public function NumberEvent(param1:String, param2:Number, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.num = param2;
      }
      
      override public function clone() : Event
      {
         return new NumberEvent(type,this.num,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("NumberEvent","num","type","bubbles","cancelable","eventPhase");
      }
   }
}

