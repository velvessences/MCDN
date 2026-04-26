package com.moviestarplanet.assetManager.resources
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class BitmapResource extends Bitmap
   {
      
      private var bitmapDataResourceWrapper:BitmapDataResourceWrapper;
      
      public function BitmapResource(param1:BitmapDataResourceWrapper, param2:String = "auto", param3:Boolean = false)
      {
         this.bitmapDataResourceWrapper = param1;
         this.bitmapDataResourceWrapper.subscribe(this);
         var _loc4_:BitmapData = this.bitmapDataResourceWrapper.getBitmapData(this);
         super(_loc4_,param2,param3);
      }
      
      public function dispose() : void
      {
         if(this.bitmapDataResourceWrapper != null)
         {
            this.bitmapDataResourceWrapper.unsubscribe(this);
         }
         this.bitmapDataResourceWrapper = null;
      }
   }
}

