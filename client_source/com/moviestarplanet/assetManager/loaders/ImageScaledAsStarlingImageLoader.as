package com.moviestarplanet.assetManager.loaders
{
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.optimizedAlternatives.ImageForAssetManager;
   import com.moviestarplanet.assetManager.resources.TextureResourceWrapper;
   import com.moviestarplanet.resources.GenericResourceManager;
   import flash.display.AVM1Movie;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import starling.textures.Texture;
   
   public class ImageScaledAsStarlingImageLoader extends TextureAssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      public var useGPUAutoOptimization:Boolean = true;
      
      private var _generateMipMaps:Boolean;
      
      private var _scale:Number;
      
      private var _format:String;
      
      private var _repeat:Boolean;
      
      private var _optimizeForRenderToTexture:Boolean;
      
      public function ImageScaledAsStarlingImageLoader(param1:UnionRep, param2:IAssetUrl, param3:Number = 1, param4:Function = null, param5:Function = null, param6:Boolean = false, param7:Boolean = false, param8:String = "bgra", param9:Boolean = false)
      {
         super(param1,param2,param4,param5);
         this._generateMipMaps = param6;
         this._optimizeForRenderToTexture = param7;
         this._scale = param3;
         this._format = param8;
         this._repeat = param9;
         if(param1 == null)
         {
            throw new Error("ImageScaledAsStarlingImageLoader can only be instantiated from AssetManager");
         }
      }
      
      override public function clone() : AssetLoader
      {
         return AssetManager.createLoaderForImageScaledAsStarlingImage(_smartUrl,this._scale,_onSuccess,_onFail);
      }
      
      override public function load() : void
      {
         if(forceLoad)
         {
            super.load();
            return;
         }
         if(this.useGPUAutoOptimization && GenericResourceManager.hasResource(assetKey))
         {
            triggerOnSuccess();
         }
         else
         {
            super.load();
         }
      }
      
      final public function getImage(param1:Boolean = false, param2:Number = 1) : ImageForAssetManager
      {
         var _loc3_:TextureResourceWrapper = null;
         if(GenericResourceManager.hasResource(assetKey))
         {
            _loc3_ = TextureResourceWrapper(GenericResourceManager.getResource(assetKey));
         }
         else
         {
            _loc3_ = new TextureResourceWrapper(assetKey,this.getTexture(),this);
         }
         return ImageForAssetManager.create(UnionRep.instance,_loc3_);
      }
      
      public function getTexture() : Texture
      {
         var _loc1_:Texture = null;
         if(payload is Bitmap)
         {
            _loc1_ = Texture.fromBitmapData(this.getBitmapData(),this._generateMipMaps,this._optimizeForRenderToTexture,this._scale,this._format,this._repeat);
         }
         else if(!(payload is MovieClip))
         {
            if(payload is Loader && payload.content is AVM1Movie)
            {
            }
         }
         return _loc1_;
      }
      
      override §§namespace("AssetManager") function getBitmapData() : BitmapData
      {
         return Bitmap(payload).bitmapData;
      }
   }
}

