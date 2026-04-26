package com.moviestarplanet.assetManager.optimizedAlternatives
{
   import com.moviestarplanet.assetManager.loaders.TextureAssetLoader;
   import flash.display.BitmapData;
   import flash.utils.Timer;
   import starling.textures.Texture;
   
   public class ReloadableTexture
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      private var texture:Texture;
      
      private var storedIdleTextureLoader:TextureAssetLoader;
      
      private var texLoader:TextureAssetLoader;
      
      private var _timer:Timer;
      
      public function ReloadableTexture(param1:Texture, param2:TextureAssetLoader)
      {
         super();
         this.texture = param1;
         this.texture.root.onRestore = this.reLoadTexture;
         this.storedIdleTextureLoader = TextureAssetLoader(param2.clone());
      }
      
      private function reLoadTexture() : void
      {
         if(this.texLoader != null)
         {
            this.texLoader.dispose();
         }
         this.texLoader = TextureAssetLoader(this.storedIdleTextureLoader.clone());
         this.texLoader.forceLoad = true;
         this.texLoader._onSuccess = this.localOnSuccess;
         this.texLoader._onFail = this.localOnFail;
         this.texLoader.load();
      }
      
      private function localOnSuccess(param1:TextureAssetLoader) : void
      {
         var _loc2_:BitmapData = param1.getBitmapData();
         this.texture.root.uploadBitmapData(_loc2_);
      }
      
      private function localOnFail(param1:TextureAssetLoader) : void
      {
      }
      
      public function dispose() : void
      {
         this.texture = null;
         this.storedIdleTextureLoader = null;
         if(this.texLoader != null)
         {
            this.texLoader.dispose();
         }
      }
   }
}

