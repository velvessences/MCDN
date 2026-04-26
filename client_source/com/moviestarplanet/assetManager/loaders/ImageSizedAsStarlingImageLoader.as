package com.moviestarplanet.assetManager.loaders
{
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.optimizedAlternatives.ImageForAssetManager;
   import com.moviestarplanet.assetManager.resources.TextureResourceWrapper;
   import com.moviestarplanet.resources.GenericResourceManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import starling.textures.Texture;
   
   public class ImageSizedAsStarlingImageLoader extends TextureAssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      private var targetWidth:Number;
      
      private var targetHeight:Number;
      
      private var _generateMipMaps:Boolean;
      
      private var _scale:Number;
      
      private var _format:String;
      
      private var _repeat:Boolean;
      
      private var _optimizeForRenderToTexture:Boolean;
      
      public function ImageSizedAsStarlingImageLoader(param1:UnionRep, param2:IAssetUrl, param3:Number, param4:Number, param5:Function = null, param6:Function = null, param7:Boolean = false, param8:Boolean = false, param9:Number = 1, param10:String = "bgra", param11:Boolean = false)
      {
         this.targetWidth = param3;
         this.targetHeight = param4;
         this._generateMipMaps = param7;
         this._optimizeForRenderToTexture = param8;
         this._scale = param9;
         this._format = param10;
         this._repeat = param11;
         super(param1,param2,param5,param6);
         if(param1 == null)
         {
            throw new Error("ImageSizedAsStarlingImageLoader can only be instantiated from AssetManager");
         }
      }
      
      override public function clone() : AssetLoader
      {
         return AssetManager.createLoaderForImageSizedAsStarlingImage(_smartUrl,this.targetWidth,this.targetHeight,_onSuccess,_onFail,false,false,this._scale);
      }
      
      override public function load() : void
      {
         if(forceLoad)
         {
            super.load();
            return;
         }
         if(GenericResourceManager.hasResource(assetKey))
         {
            triggerOnSuccess();
         }
         else
         {
            super.load();
         }
      }
      
      final public function getImage() : ImageForAssetManager
      {
         var _loc1_:TextureResourceWrapper = null;
         if(GenericResourceManager.hasResource(assetKey))
         {
            _loc1_ = TextureResourceWrapper(GenericResourceManager.getResource(assetKey));
         }
         else
         {
            _loc1_ = new TextureResourceWrapper(assetKey,this.getTexture(),this);
         }
         var _loc2_:ImageForAssetManager = ImageForAssetManager.create(UnionRep.instance,_loc1_);
         _loc2_.width = this.targetWidth;
         _loc2_.height = this.targetHeight;
         return _loc2_;
      }
      
      override §§namespace("AssetManager") function getBitmapData() : BitmapData
      {
         return (payload as Bitmap).bitmapData;
      }
      
      private function getTexture() : Texture
      {
         var _loc1_:Texture = null;
         _loc1_ = Texture.fromBitmap(payload as Bitmap);
         Bitmap(payload).bitmapData.dispose();
         return _loc1_;
      }
   }
}

