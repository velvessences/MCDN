package com.moviestarplanet.assetManager.loaders.postprocessing
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   import com.moviestarplanet.assetManager.loaders.TextureAssetLoader;
   import com.moviestarplanet.assetManager.optimizedAlternatives.ImageForAssetManager;
   import com.moviestarplanet.assetManager.resources.TextureResourceWrapper;
   import com.moviestarplanet.commoninterfaces.ILoaderPostProcessor;
   import com.moviestarplanet.resources.GenericResourceManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class SwfToStarlingImagePostProcessingLoader extends TextureAssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      private static const DELIMITER_CHAR:String = "&";
      
      private static const MAX_TEXTURE_SIZE:Number = 2048;
      
      private static var safetyMarginForTexture:Number = 1;
      
      private var postProcessors:Vector.<ILoaderPostProcessor>;
      
      public function SwfToStarlingImagePostProcessingLoader(param1:UnionRep, param2:IAssetUrl, param3:Vector.<ILoaderPostProcessor>, param4:Function, param5:Function = null)
      {
         var _loc7_:String = null;
         this.postProcessors = param3;
         assetKeyModifier = "";
         var _loc6_:int = 0;
         while(_loc6_ < this.postProcessors.length)
         {
            _loc7_ = this.postProcessors[_loc6_].getKeyModifier();
            if(_loc7_ != "")
            {
               assetKeyModifier += DELIMITER_CHAR + this.postProcessors[_loc6_].getKeyModifier();
            }
            _loc6_++;
         }
         super(param1,param2,param4,param5);
      }
      
      override public function clone() : AssetLoader
      {
         return null;
      }
      
      override protected function triggerOnSuccess() : void
      {
         this.postProccessPayload();
         super.triggerOnSuccess();
      }
      
      private function postProccessPayload() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.postProcessors.length)
         {
            this.postProcessors[_loc1_].process(payload);
            _loc1_++;
         }
      }
      
      public function getImage() : Image
      {
         var _loc1_:TextureResourceWrapper = null;
         if(GenericResourceManager.hasResource(assetKey))
         {
            _loc1_ = GenericResourceManager.getResource(assetKey) as TextureResourceWrapper;
         }
         else
         {
            _loc1_ = new TextureResourceWrapper(assetKey,this.createTexture(),this);
         }
         var _loc2_:Image = ImageForAssetManager.create(UnionRep.instance,_loc1_);
         _loc2_.name = _loc2_.name = _smartUrl.getRootRelativePath();
         return _loc2_;
      }
      
      private function createTexture() : Texture
      {
         var _loc1_:DisplayObjectContainer = payload as DisplayObjectContainer;
         _loc1_.width -= safetyMarginForTexture;
         _loc1_.height -= safetyMarginForTexture;
         if(_loc1_.width + safetyMarginForTexture > MAX_TEXTURE_SIZE)
         {
            _loc1_.width = MAX_TEXTURE_SIZE - safetyMarginForTexture;
         }
         if(_loc1_.height + safetyMarginForTexture > MAX_TEXTURE_SIZE)
         {
            _loc1_.height = MAX_TEXTURE_SIZE - safetyMarginForTexture;
         }
         var _loc2_:BitmapData = new BitmapData(_loc1_.width + safetyMarginForTexture,_loc1_.height + safetyMarginForTexture,true,65280);
         _loc2_.draw(_loc1_,_loc1_.transform.matrix);
         var _loc3_:Texture = Texture.fromBitmapData(_loc2_,false,false);
         _loc2_.dispose();
         return _loc3_;
      }
      
      override public function dispose() : void
      {
         this.postProcessors = null;
         super.dispose();
      }
   }
}

