package com.moviestarplanet.assetManager.loaders.SWFs
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   
   public class SWFAssetLoader extends AssetLoader
   {
      
      public function SWFAssetLoader(param1:UnionRep, param2:IAssetUrl, param3:Function = null, param4:Function = null)
      {
         super(param1,param2,param3,param4);
         if(param1 == null)
         {
            throw new Error("SWFAssetLoader can only be instantiated from AssetManager");
         }
      }
      
      public function getSWF() : DisplayObjectContainer
      {
         var _loc1_:DisplayObjectContainer = null;
         if(payload is DisplayObjectContainer)
         {
            _loc1_ = payload as DisplayObjectContainer;
         }
         else
         {
            if(!(payload is Loader))
            {
               throw new Error("getSWF() could not figure out what you want");
            }
            _loc1_ = new DisplayObjectContainer();
            _loc1_.addChild(payload);
            _loc1_.width = (payload as Loader).width;
            _loc1_.height = (payload as Loader).height;
         }
         return _loc1_;
      }
   }
}

