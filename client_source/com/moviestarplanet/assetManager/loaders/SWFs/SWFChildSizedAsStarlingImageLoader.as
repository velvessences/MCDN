package com.moviestarplanet.assetManager.loaders.SWFs
{
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.externalHelpers.CallManager;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   import com.moviestarplanet.assetManager.loaders.TextureAssetLoader;
   import com.moviestarplanet.assetManager.optimizedAlternatives.HelperDetails;
   import com.moviestarplanet.assetManager.optimizedAlternatives.SWFChildAsStarlingImage;
   import com.moviestarplanet.assetManager.resources.HelperDetailsResourceWrapper;
   import com.moviestarplanet.resources.GenericResourceManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class SWFChildSizedAsStarlingImageLoader extends TextureAssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      public var bitmapFormat:String = "bgra";
      
      public var generateMipmaps:Boolean = false;
      
      private var _searchForName:String = "";
      
      private var _imageWidth:int;
      
      private var _imageHeight:int;
      
      private var _scale:Number = 1;
      
      private var scaleKey:Number = this._imageWidth * 100 + this._imageHeight;
      
      private var myDisplayObject:DisplayObject;
      
      private var swfchildloader:SWFChildAsDisplayObjectLoader;
      
      public function SWFChildSizedAsStarlingImageLoader(param1:UnionRep, param2:String, param3:IAssetUrl, param4:Function = null, param5:Function = null, param6:int = -1, param7:int = -1)
      {
         isWrapper = true;
         this._searchForName = param2;
         this._imageWidth = param6;
         this._imageHeight = param7;
         assetKeyModifier = this._searchForName + this.scaleKey;
         super(param1,param3,param4,param5);
         if(param1 == null)
         {
            throw new Error("SWFChildAsSizedImageAssetLoader can only be instantiated from AssetManager");
         }
      }
      
      override public function clone() : AssetLoader
      {
         return AssetManager.createLoaderForSWFChildSizedAsStarlingImage(this._searchForName,this._imageWidth,this._imageHeight,_smartUrl,_onSuccess,_onFail);
      }
      
      override public function doLoad() : void
      {
         if(forceLoad)
         {
            this.swfchildloader = AssetManager.createLoaderForSWFChildAsDisplayObject(this._searchForName,_smartUrl,this.myOnSuccess,this.myOnFail);
            this.swfchildloader.load();
            return;
         }
         if(GenericResourceManager.hasResource(assetKey))
         {
            triggerOnSuccess();
         }
         else
         {
            this.swfchildloader = AssetManager.createLoaderForSWFChildAsDisplayObject(this._searchForName,_smartUrl,this.myOnSuccess,this.myOnFail);
            this.swfchildloader.load();
         }
      }
      
      private function myOnSuccess(param1:SWFChildAsDisplayObjectLoader) : void
      {
         this.myDisplayObject = this.swfchildloader.getDisplayObject();
         triggerOnSuccess();
      }
      
      private function myOnFail(param1:SWFAssetLoader) : void
      {
         CallManager.loaderFailed(this);
         triggerOnFail();
      }
      
      public function getImage() : SWFChildAsStarlingImage
      {
         var _loc2_:HelperDetails = null;
         if(!GenericResourceManager.getResource(assetKey))
         {
            if(this.myDisplayObject == null)
            {
               throw new Error("getScale9() has tried to create from a display object, because the resource was not available... but no display object was loaded.");
            }
            _loc2_ = new HelperDetails(assetKey,DisplayObjectContainer(this.myDisplayObject),this._scale,this._imageWidth,this._imageHeight);
            new HelperDetailsResourceWrapper(assetKey,_loc2_,this);
         }
         var _loc1_:HelperDetailsResourceWrapper = HelperDetailsResourceWrapper(GenericResourceManager.getResource(assetKey));
         return SWFChildAsStarlingImage.create(UnionRep.instance,_loc1_);
      }
      
      override §§namespace("AssetManager") function getBitmapData() : BitmapData
      {
         var _loc1_:HelperDetails = new HelperDetails(assetKey + "tempLostContextRestorer",DisplayObjectContainer(this.myDisplayObject),this._scale,this._imageWidth,this._imageHeight);
         var _loc2_:BitmapData = _loc1_.getBitmapData(DisplayObjectContainer(this.myDisplayObject));
         _loc1_.dispose();
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         if(this.swfchildloader != null)
         {
            this.swfchildloader.dispose();
         }
         super.dispose();
      }
   }
}

