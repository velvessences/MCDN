package com.moviestarplanet.utils.loader
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.loader.ILoaderUrl;
   
   public class RawUrl implements ILoaderUrl, IAssetUrl
   {
      
      private var rawUrl:String;
      
      public function RawUrl(param1:String)
      {
         super();
         this.rawUrl = param1;
      }
      
      public function toString() : String
      {
         return this.rawUrl;
      }
      
      public function allowCodeImport() : Boolean
      {
         return true;
      }
      
      public function getAbsolutePath() : String
      {
         return this.rawUrl;
      }
      
      public function getRootRelativePath() : String
      {
         return this.rawUrl;
      }
   }
}

