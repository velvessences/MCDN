package com.moviestarplanet.media.youtube
{
   import flash.events.IEventDispatcher;
   
   public interface IAPIPlayerBase extends IEventDispatcher
   {
      
      function set autoPlay(param1:Boolean) : void;
      
      function set volume(param1:Number) : void;
      
      function get volume() : Number;
      
      function get duration() : Number;
      
      function get currentTime() : Number;
      
      function destroy() : void;
      
      function play() : void;
      
      function pause() : void;
      
      function stop() : void;
      
      function seekTo(param1:Number, param2:Boolean = false) : void;
      
      function setSize(param1:Number, param2:Number) : void;
   }
}

