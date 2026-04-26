package com.moviestarplanet.assetManager.resources
{
   import com.moviestarplanet.assetManager.loaders.TextureAssetLoader;
   import com.moviestarplanet.assetManager.optimizedAlternatives.ReloadableTexture;
   import com.moviestarplanet.resources.ResourceWrapper;
   import starling.textures.Texture;
   
   public class TextureResourceWrapper extends ResourceWrapper
   {
      
      private var texture:Texture;
      
      private var loader:TextureAssetLoader;
      
      public function TextureResourceWrapper(param1:String, param2:Texture, param3:TextureAssetLoader)
      {
         super(param1);
         this.texture = param2;
         this.loader = param3;
         new ReloadableTexture(this.texture,this.loader);
      }
      
      public function getTexture(param1:Object) : Texture
      {
         if(isSubscribed(param1))
         {
            return this.texture;
         }
         throw new Error(_assetKey + " getTexture() failed because the component has not subscribed properly");
      }
      
      override protected function dispose() : void
      {
         this.texture.dispose();
         this.texture = null;
         this.loader.dispose();
         this.loader = null;
         super.dispose();
      }
   }
}

