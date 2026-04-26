package com.moviestarplanet.assetManager.resources
{
   import com.moviestarplanet.assetManager.loaders.TextureAssetLoader;
   import com.moviestarplanet.assetManager.optimizedAlternatives.HelperDetails;
   import com.moviestarplanet.assetManager.optimizedAlternatives.ReloadableTexture;
   import com.moviestarplanet.resources.ResourceWrapper;
   
   public class HelperDetailsResourceWrapper extends ResourceWrapper
   {
      
      private var details:HelperDetails;
      
      private var loader:TextureAssetLoader;
      
      public function HelperDetailsResourceWrapper(param1:String, param2:HelperDetails, param3:TextureAssetLoader)
      {
         super(param1);
         this.details = param2;
         this.loader = param3;
         new ReloadableTexture(this.details.texture,this.loader);
      }
      
      public function getHelperDetails(param1:Object) : HelperDetails
      {
         if(isSubscribed(param1))
         {
            return this.details;
         }
         throw new Error(_assetKey + " getHelperDetails() failed because the component has not subscribed properly");
      }
      
      override protected function dispose() : void
      {
         this.details.dispose();
         this.details = null;
         super.dispose();
      }
   }
}

