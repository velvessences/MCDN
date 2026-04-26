package com.moviestarplanet.scrapitems.pattern
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   
   public interface IPatternRendererFactory
   {
      
      function prepareFactoryForLoader(param1:Loader) : void;
      
      function createRenderer(param1:MovieClip, param2:Number, param3:Number) : PatternRenderer;
      
      function dispose() : void;
   }
}

