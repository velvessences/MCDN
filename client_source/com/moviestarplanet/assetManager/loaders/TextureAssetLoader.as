package com.moviestarplanet.assetManager.loaders
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import flash.display.BitmapData;
   
   public class TextureAssetLoader extends AssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      public function TextureAssetLoader(param1:UnionRep, param2:IAssetUrl, param3:Function = null, param4:Function = null)
      {
         super(param1,param2,param3,param4);
         if(param1 == null)
         {
            throw new Error("TextureAssetLoader is an abstract class");
         }
      }
      
      override public function clone() : AssetLoader
      {
         throw new Error("TextureAssetLoader .clone() NEEDS to be overwritten before using, due to this class acting like an abstract loader");
      }
      
      §§namespace("AssetManager") function getBitmapData() : BitmapData
      {
         throw new Error("TextureAssetLoader .getBitmapData() NEEDS to be overwritten before using, due to this class acting like an abstract loader");
      }
   }
}

