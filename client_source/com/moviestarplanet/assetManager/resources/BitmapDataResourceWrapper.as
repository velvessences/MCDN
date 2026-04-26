package com.moviestarplanet.assetManager.resources
{
   import com.moviestarplanet.assetManager.loaders.TextureAssetLoader;
   import com.moviestarplanet.resources.ResourceWrapper;
   import flash.display.BitmapData;
   
   public class BitmapDataResourceWrapper extends ResourceWrapper
   {
      
      private var bmd:BitmapData;
      
      private var loader:TextureAssetLoader;
      
      public function BitmapDataResourceWrapper(param1:String, param2:BitmapData)
      {
         this.bmd = param2;
         super(param1);
      }
      
      public function getBitmapData(param1:Object) : BitmapData
      {
         if(isSubscribed(param1))
         {
            return this.bmd;
         }
         throw new Error(_assetKey + " getBitmapData() failed because the component has not subscribed properly");
      }
      
      override protected function dispose() : void
      {
         this.bmd.dispose();
         this.bmd = null;
         super.dispose();
      }
   }
}

