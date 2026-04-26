package com.moviestarplanet.Components.FontSelector
{
   import flash.events.Event;
   
   public class FontColorSelectorEvent extends Event
   {
      
      public static const FONTCOLOR_SELECTED:String = "FONTCOLOR_SELECTED";
      
      private var _color:uint;
      
      public function FontColorSelectorEvent(param1:String, param2:uint, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._color = param2;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
   }
}

