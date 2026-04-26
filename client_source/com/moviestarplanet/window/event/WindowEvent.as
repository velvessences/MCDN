package com.moviestarplanet.window.event
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   
   public class WindowEvent extends Event
   {
      
      public static const WINDOW_OPENING:String = "WINDOW_OPENING";
      
      public static const WINDOW_OPENED:String = "WINDOW_OPENED";
      
      public static const WINDOW_CLOSING:String = "WINDOW_CLOSING";
      
      public static const WINDOW_CLOSED:String = "WINDOW_CLOSED";
      
      public static const GRAPHICS_DONE:String = "GRAPHICS_DONE";
      
      private var _window:DisplayObjectContainer;
      
      public function WindowEvent(param1:String, param2:DisplayObjectContainer = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.window = param2;
      }
      
      public function set window(param1:DisplayObjectContainer) : void
      {
         this._window = param1;
      }
      
      public function get window() : DisplayObjectContainer
      {
         return this._window;
      }
   }
}

