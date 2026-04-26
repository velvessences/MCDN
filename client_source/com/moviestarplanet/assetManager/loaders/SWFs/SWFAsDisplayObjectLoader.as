package com.moviestarplanet.assetManager.loaders.SWFs
{
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class SWFAsDisplayObjectLoader extends AssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      private var swfchildloader:SWFAssetLoader;
      
      protected var mySprite:DisplayObjectContainer;
      
      public function SWFAsDisplayObjectLoader(param1:UnionRep, param2:IAssetUrl, param3:Function = null, param4:Function = null)
      {
         isWrapper = true;
         assetKeyModifier = "";
         super(param1,param2,param3,param4);
         if(param1 == null)
         {
            throw new Error("SWFChildAsDisplayObjectLoader can only be instantiated from AssetManager");
         }
      }
      
      override public function doLoad() : void
      {
         this.swfchildloader = AssetManager.createLoaderForSWF(_smartUrl,this.myOnSuccess,this.myOnFail);
         this.swfchildloader.load();
      }
      
      override §§namespace("AssetManager") function CallManagerSaysYouHaveLoaded() : void
      {
      }
      
      private function myOnSuccess(param1:SWFAssetLoader) : void
      {
         this.mySprite = param1.getSWF();
         triggerOnSuccess();
      }
      
      private function myOnFail(param1:SWFAssetLoader) : void
      {
         triggerOnFail();
      }
      
      public function getDisplayObject() : DisplayObject
      {
         if(this.mySprite != null)
         {
            return this.mySprite;
         }
         throw new Error(_urlFullPath + " displayObject is null - this is an error");
      }
      
      override public function dispose() : void
      {
         this.mySprite = null;
         if(this.swfchildloader != null)
         {
            this.swfchildloader.autoDisposeLoader = false;
            this.swfchildloader.dispose();
            this.swfchildloader = null;
         }
         super.dispose();
      }
   }
}

