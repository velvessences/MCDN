package com.moviestarplanet.scrapitems.pattern
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   
   public class PatternRendererFactoryWeb implements IPatternRendererFactory
   {
      
      private var loadedClass:Class;
      
      public function PatternRendererFactoryWeb()
      {
         super();
      }
      
      public function prepareFactoryForLoader(param1:Loader) : void
      {
         var _loc2_:LoaderInfo = param1.content.loaderInfo;
         var _loc3_:ApplicationDomain = _loc2_.applicationDomain;
         this.loadedClass = _loc3_.getDefinition("Pattern") as Class;
      }
      
      public function createRenderer(param1:MovieClip, param2:Number, param3:Number) : PatternRenderer
      {
         return new PatternClassRenderer(this.loadedClass,param1,param2,param3);
      }
      
      public function dispose() : void
      {
      }
   }
}

