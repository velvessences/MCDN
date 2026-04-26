package com.moviestarplanet.assetManager.loaders.SWFs
{
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   import com.moviestarplanet.assetManager.loaders.TextureAssetLoader;
   import com.moviestarplanet.assetManager.optimizedAlternatives.HelperDetails;
   import com.moviestarplanet.assetManager.optimizedAlternatives.SWFChildAsStarlingImage;
   import com.moviestarplanet.assetManager.resources.HelperDetailsResourceWrapper;
   import com.moviestarplanet.resources.GenericResourceManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Matrix;
   
   public class SWFScaledAsStarlingImageLoader extends TextureAssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      private static var MATRIX:Matrix = new Matrix();
      
      public var bitmapFormat:String = "bgra";
      
      public var generateMipmaps:Boolean = false;
      
      protected var myDisplayObject:DisplayObject;
      
      protected var swfLoader:AssetLoader;
      
      protected var _scale:Number = 1;
      
      protected var _trim:Boolean;
      
      public function SWFScaledAsStarlingImageLoader(param1:UnionRep, param2:Number, param3:IAssetUrl, param4:Boolean = false, param5:Function = null, param6:Function = null)
      {
         isWrapper = true;
         this._scale = param2;
         this._trim = param4;
         if(assetKeyModifier == null)
         {
            assetKeyModifier = "" + this._scale + this._trim.toString();
         }
         super(param1,param3,param5,param6);
      }
      
      override public function clone() : AssetLoader
      {
         return AssetManager.createLoaderForSWFScaledAsStarlingImage(_smartUrl,this._scale,this._trim,_onSuccess,_onFail);
      }
      
      override public function doLoad() : void
      {
         if(isDisposed)
         {
            throw new Error("doLoad should never be called if a loader was disposed properly");
         }
         if(forceLoad)
         {
            this.swfLoader = this.createSwfLoader();
            this.swfLoader.load();
         }
         else if(GenericResourceManager.hasResource(assetKey))
         {
            triggerOnSuccess();
         }
         else
         {
            this.swfLoader = this.createSwfLoader();
            this.swfLoader.load();
         }
      }
      
      protected function createSwfLoader() : SWFAsDisplayObjectLoader
      {
         return AssetManager.createLoaderForSWFAsDisplayObject(_smartUrl,this.myOnSuccess,this.myOnFail);
      }
      
      override §§namespace("AssetManager") function CallManagerSaysYouHaveLoaded() : void
      {
         triggerOnSuccess();
      }
      
      private function myOnSuccess(param1:SWFAsDisplayObjectLoader) : void
      {
         this.myDisplayObject = param1.getDisplayObject();
         triggerOnSuccess();
      }
      
      private function myOnFail(param1:SWFAsDisplayObjectLoader) : void
      {
         triggerOnFail();
      }
      
      public function getImage() : SWFChildAsStarlingImage
      {
         if(!GenericResourceManager.hasResource(assetKey))
         {
            if(this.myDisplayObject == null)
            {
               throw new Error("getScale9() has tried to create from a display object, because the resource was not available... but no display object was loaded.");
            }
            new HelperDetailsResourceWrapper(assetKey,new HelperDetails(assetKey,DisplayObjectContainer(this.myDisplayObject),this._scale,-1,-1,this._trim),this);
         }
         var _loc1_:HelperDetailsResourceWrapper = HelperDetailsResourceWrapper(GenericResourceManager.getResource(assetKey));
         return SWFChildAsStarlingImage.create(UnionRep.instance,_loc1_);
      }
      
      override public function bequeath(param1:AssetLoader) : void
      {
         this.swfLoader.bequeath((param1 as SWFScaledAsStarlingImageLoader).swfLoader);
         super.bequeath(param1);
      }
      
      override §§namespace("AssetManager") function getBitmapData() : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc1_:HelperDetails = new HelperDetails(assetKey + "tempLostContextRestorer",DisplayObjectContainer(this.myDisplayObject),this._scale,-1,-1,this._trim);
         _loc2_ = _loc1_.getBitmapData(DisplayObjectContainer(this.myDisplayObject));
         _loc1_.dispose();
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         if(this.swfLoader != null)
         {
            this.swfLoader.dispose();
         }
         super.dispose();
      }
   }
}

