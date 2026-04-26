package com.moviestarplanet.assetManager.loaders
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.resources.BitmapDataResourceWrapper;
   import com.moviestarplanet.assetManager.resources.BitmapResource;
   import com.moviestarplanet.resources.GenericResourceManager;
   import flash.display.Bitmap;
   
   public class ImageScaledAsFlashBitmapLoader extends AssetLoader
   {
      
      public function ImageScaledAsFlashBitmapLoader(param1:UnionRep, param2:IAssetUrl, param3:Number = 1, param4:Function = null, param5:Function = null)
      {
         super(param1,param2,param4,param5);
         if(param1 == null)
         {
            throw new Error("ImageScaledAsFlashBitmapLoader can only be instantiated from AssetManager");
         }
      }
      
      final public function getBitmap() : BitmapResource
      {
         var _loc1_:BitmapDataResourceWrapper = null;
         var _loc2_:Bitmap = null;
         if(!GenericResourceManager.hasResource(assetKey))
         {
            if(!(payload is Bitmap))
            {
               throw new Error("Payload is not a valid bitmap!");
            }
            _loc2_ = payload as Bitmap;
            _loc1_ = new BitmapDataResourceWrapper(assetKey,_loc2_.bitmapData);
         }
         _loc1_ = BitmapDataResourceWrapper(GenericResourceManager.getResource(assetKey));
         return new BitmapResource(_loc1_);
      }
   }
}

