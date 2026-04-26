package com.moviestarplanet.utils.color
{
   import flash.display.MovieClip;
   
   public interface IColorReader
   {
      
      function applyColorScheme(param1:MovieClip, param2:String, param3:String) : void;
      
      function extractColorScheme(param1:MovieClip, param2:String) : Object;
   }
}

