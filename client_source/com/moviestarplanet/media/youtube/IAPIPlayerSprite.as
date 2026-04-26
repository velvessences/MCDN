package com.moviestarplanet.media.youtube
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public interface IAPIPlayerSprite extends IAPIPlayerBase
   {
      
      function loadVideoById(param1:String) : void;
      
      function set playbackQuality(param1:String) : void;
      
      function get playbackQuality() : String;
      
      function mute() : void;
      
      function unMute() : void;
      
      function isMuted() : Boolean;
      
      function get availableQualityLevels() : Array;
      
      function get isPlaying() : Boolean;
      
      function getDisplayObject() : DisplayObject;
      
      function get active() : Boolean;
      
      function set active(param1:Boolean) : void;
      
      function get appContainer() : DisplayObjectContainer;
      
      function set appContainer(param1:DisplayObjectContainer) : void;
   }
}

