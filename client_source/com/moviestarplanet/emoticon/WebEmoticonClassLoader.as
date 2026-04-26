package com.moviestarplanet.emoticon
{
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   import flash.display.Sprite;
   
   public class WebEmoticonClassLoader extends EmoticonLoader
   {
      
      public function WebEmoticonClassLoader()
      {
         super("emoticons");
      }
      
      override protected function getNewLoader() : IMSP_Loader
      {
         return new MSP_SWFLoader();
      }
      
      override protected function cloneEmoticonSprite(param1:Sprite) : Sprite
      {
         var _loc2_:Class = Object(param1).constructor;
         return new _loc2_();
      }
   }
}

