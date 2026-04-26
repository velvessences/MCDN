package com.moviestarplanet.body.skin
{
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.loader.ContentUrl;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.utils.getDefinitionByName;
   
   public class Skin
   {
      
      private static var clazzPrefix:String = "com.moviestarplanet.body.skins.";
      
      public static var skins:Object = new Object();
      
      public static var colorschemes:Object = new Object();
      
      public function Skin()
      {
         super();
      }
      
      public static function getSkin(param1:String, param2:Function) : void
      {
         var LoadSkinDone:Function = null;
         var skinMc:MovieClip = null;
         var name:String = param1;
         var callback:Function = param2;
         LoadSkinDone = function(param1:Loader):void
         {
            var _loc2_:ApplicationDomain = param1.content.loaderInfo.applicationDomain;
            var _loc3_:Class = _loc2_.getDefinition(clazzPrefix + name) as Class;
            skins[name] = _loc3_;
            colorschemes[name] = MovieClip(param1.content).colorscheme;
            callback(param1.content);
         };
         if(undefined == skins[name])
         {
            MSP_FlashLoader.RequestLoad(new ContentUrl(name,ContentUrl.SKIN),LoadSkinDone);
         }
         else
         {
            skinMc = new skins[name]();
            skinMc.colorscheme = colorschemes[name];
            callback(skinMc);
         }
      }
   }
}

