package com.moviestarplanet.Forms
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2380")]
   public class ResizableTitleWindow_closeSkin extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
      
      public var dataClass:Class = ResizableTitleWindow_closeSkin_dataClass;
      
      public function ResizableTitleWindow_closeSkin()
      {
         super();
         initialWidth = 362 / 20;
         initialHeight = 362 / 20;
      }
      
      override public function get movieClipData() : ByteArray
      {
         if(bytes == null)
         {
            bytes = ByteArray(new this.dataClass());
         }
         return bytes;
      }
   }
}

