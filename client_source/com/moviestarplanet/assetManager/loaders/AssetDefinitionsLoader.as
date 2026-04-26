package com.moviestarplanet.assetManager.loaders
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import flash.utils.ByteArray;
   
   public class AssetDefinitionsLoader extends AssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      public function AssetDefinitionsLoader(param1:IAssetUrl, param2:Function = null, param3:Function = null)
      {
         super(UnionRep.instance,param1,param2,param3);
         returnByteArray = true;
      }
      
      public function getAssetDefinitions() : Object
      {
         var _loc1_:ByteArray = payload as ByteArray;
         return JSON.parse(_loc1_.toString());
      }
   }
}

