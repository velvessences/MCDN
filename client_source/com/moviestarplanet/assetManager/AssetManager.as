package com.moviestarplanet.assetManager
{
   import com.moviestarplanet.assetManager.assetHandlers.AssetHandlerBase;
   import com.moviestarplanet.assetManager.loaders.AssetDefinitionsLoader;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   import com.moviestarplanet.assetManager.loaders.BitmapFontTextureAtlasLoader;
   import com.moviestarplanet.assetManager.loaders.ImageScaledAsFlashBitmapLoader;
   import com.moviestarplanet.assetManager.loaders.ImageScaledAsStarlingImageLoader;
   import com.moviestarplanet.assetManager.loaders.ImageSizedAsStarlingImageLoader;
   import com.moviestarplanet.assetManager.loaders.JSONAssetLoader;
   import com.moviestarplanet.assetManager.loaders.JSONCAssetLoader;
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFAsDisplayObjectLoader;
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFAssetLoader;
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFChildAsDisplayObjectLoader;
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFChildAsStarlingScale9Loader;
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFChildScaledAsFlashBitmapLoader;
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFChildScaledAsStarlingImageLoader;
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFChildSizedAsStarlingImageLoader;
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFScaledAsStarlingImageLoader;
   import com.moviestarplanet.assetManager.loaders.XMLAssetLoader;
   import com.moviestarplanet.assetManager.loaders.postprocessing.SwfToStarlingImagePostProcessingLoader;
   import com.moviestarplanet.commoninterfaces.ILoaderPostProcessor;
   import flash.display.Stage;
   import flash.utils.ByteArray;
   
   public class AssetManager
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      public static var nativeStage:Stage;
      
      public static var assetHandler:AssetHandlerBase = new AssetHandlerBase();
      
      public function AssetManager()
      {
         super();
      }
      
      public static function createLoaderForImageScaledAsFlashBitmap(param1:IAssetUrl, param2:Number = 1, param3:Function = null, param4:Function = null) : ImageScaledAsFlashBitmapLoader
      {
         return new ImageScaledAsFlashBitmapLoader(UnionRep.instance,param1,param2,param3,param4);
      }
      
      public static function createLoaderForUnknown(param1:IAssetUrl, param2:Function = null, param3:Function = null) : AssetLoader
      {
         return new AssetLoader(UnionRep.instance,param1,param2,param3);
      }
      
      public static function createLoaderForSWF(param1:IAssetUrl, param2:Function = null, param3:Function = null) : SWFAssetLoader
      {
         return new SWFAssetLoader(UnionRep.instance,param1,param2,param3);
      }
      
      public static function createLoaderForSWFAsDisplayObject(param1:IAssetUrl, param2:Function = null, param3:Function = null) : SWFAsDisplayObjectLoader
      {
         return new SWFAsDisplayObjectLoader(UnionRep.instance,param1,param2,param3);
      }
      
      public static function createLoaderForSWFChildAsDisplayObject(param1:String, param2:IAssetUrl, param3:Function = null, param4:Function = null) : SWFChildAsDisplayObjectLoader
      {
         return new SWFChildAsDisplayObjectLoader(UnionRep.instance,param1,param2,param3,param4);
      }
      
      public static function createLoaderForSWFChildSizedAsStarlingImage(param1:String, param2:Number, param3:Number, param4:IAssetUrl, param5:Function = null, param6:Function = null) : SWFChildSizedAsStarlingImageLoader
      {
         return new SWFChildSizedAsStarlingImageLoader(UnionRep.instance,param1,param4,param5,param6,param2,param3);
      }
      
      public static function createLoaderForSWFChildScaledAsFlashBitmap(param1:String, param2:Number, param3:IAssetUrl, param4:Function = null, param5:Function = null) : SWFChildScaledAsFlashBitmapLoader
      {
         return new SWFChildScaledAsFlashBitmapLoader(UnionRep.instance,param1,param2,param3,param4,param5);
      }
      
      public static function createLoaderForSWFChildScaledAsStarlingImage(param1:String, param2:Number, param3:IAssetUrl, param4:Boolean, param5:Function = null, param6:Function = null) : SWFChildScaledAsStarlingImageLoader
      {
         return new SWFChildScaledAsStarlingImageLoader(UnionRep.instance,param1,param2,param3,param4,param5,param6);
      }
      
      public static function createLoaderForSWFScaledAsStarlingImage(param1:IAssetUrl, param2:Number, param3:Boolean = false, param4:Function = null, param5:Function = null) : SWFScaledAsStarlingImageLoader
      {
         return new SWFScaledAsStarlingImageLoader(UnionRep.instance,param2,param1,param3,param4,param5);
      }
      
      public static function createLoaderForSWFChildAsStarlingScale9(param1:String, param2:Number, param3:IAssetUrl, param4:Function = null, param5:Function = null) : SWFChildAsStarlingScale9Loader
      {
         return new SWFChildAsStarlingScale9Loader(UnionRep.instance,param1,param2,param3,param4,param5);
      }
      
      public static function createLoaderForSwfToStarlingImagePostProcessingLoader(param1:Vector.<ILoaderPostProcessor>, param2:IAssetUrl, param3:Function = null, param4:Function = null) : SwfToStarlingImagePostProcessingLoader
      {
         return new SwfToStarlingImagePostProcessingLoader(UnionRep.instance,param2,param1,param3,param4);
      }
      
      public static function createLoaderForJSONC(param1:IAssetUrl, param2:Function = null, param3:Function = null) : JSONCAssetLoader
      {
         return new JSONCAssetLoader(UnionRep.instance,param1,param2,param3);
      }
      
      public static function createLoaderForBitmapFont(param1:String, param2:IAssetUrl, param3:IAssetUrl, param4:Function = null, param5:Function = null) : BitmapFontTextureAtlasLoader
      {
         return new BitmapFontTextureAtlasLoader(UnionRep.instance,param1,param2,param3,param4,param5);
      }
      
      public static function createLoaderForJSON(param1:IAssetUrl, param2:Function = null, param3:Function = null) : JSONAssetLoader
      {
         return new JSONAssetLoader(UnionRep.instance,param1,param2,param3);
      }
      
      public static function createLoaderForXML(param1:IAssetUrl, param2:int, param3:Function = null, param4:Function = null) : XMLAssetLoader
      {
         return new XMLAssetLoader(UnionRep.instance,param1,param2,param3,param4);
      }
      
      public static function createLoaderForImageScaledAsStarlingImage(param1:IAssetUrl, param2:Number, param3:Function = null, param4:Function = null, param5:Boolean = false, param6:Boolean = false, param7:String = "bgra", param8:Boolean = false) : ImageScaledAsStarlingImageLoader
      {
         return new ImageScaledAsStarlingImageLoader(UnionRep.instance,param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public static function createLoaderForImageSizedAsStarlingImage(param1:IAssetUrl, param2:Number, param3:Number, param4:Function = null, param5:Function = null, param6:Boolean = false, param7:Boolean = false, param8:Number = 1, param9:String = "bgra", param10:Boolean = false) : ImageSizedAsStarlingImageLoader
      {
         return new ImageSizedAsStarlingImageLoader(UnionRep.instance,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
      }
      
      public static function createLoaderForAssetDefinitions(param1:IAssetUrl, param2:Function = null, param3:Function = null) : AssetDefinitionsLoader
      {
         return new AssetDefinitionsLoader(param1,param2,param3);
      }
      
      public static function hasOnLocal(param1:String) : Boolean
      {
         return assetHandler.hasOnLocal(param1);
      }
      
      public static function getLocalURL(param1:String) : String
      {
         return assetHandler.getLocalURL(param1);
      }
      
      public static function getLocalNativePath(param1:String) : String
      {
         return assetHandler.getLocalNativePath(param1);
      }
      
      public static function addFileToLocalCache(param1:String, param2:ByteArray) : void
      {
         assetHandler.tryToStoreOnLocal(param1,param2);
      }
      
      public static function restoreLostContext() : void
      {
      }
   }
}

