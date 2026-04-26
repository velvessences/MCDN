package com.moviestarplanet.msg
{
   import flash.events.Event;
   
   public class MSP_Event extends Event
   {
      
      public static const MUSIC_ADDED:String = "MUSIC_ADDED";
      
      public static const BACKGROUND_ADDED:String = "BACKGROUND_ADDED";
      
      public static const ANIMATION_ADDED:String = "ANIMATION_ADDED";
      
      public static const E_MUTE_CHANGED:String = "E_MUTE_CHANGED";
      
      public static const EMAIL_SET:String = "EMAIL_SET";
      
      private var _data:Object;
      
      public function MSP_Event(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}

