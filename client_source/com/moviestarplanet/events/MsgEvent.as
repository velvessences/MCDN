package com.moviestarplanet.events
{
   import flash.events.Event;
   
   public class MsgEvent extends Event
   {
      
      protected var _data:*;
      
      public function MsgEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param3,false);
         this._data = param2;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      override public function clone() : Event
      {
         return new MsgEvent(type,this._data,bubbles);
      }
   }
}

