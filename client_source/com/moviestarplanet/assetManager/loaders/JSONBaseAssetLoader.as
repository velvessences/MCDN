package com.moviestarplanet.assetManager.loaders
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.resources.JsonResource;
   
   public class JSONBaseAssetLoader extends AssetLoader
   {
      
      public function JSONBaseAssetLoader(param1:UnionRep, param2:IAssetUrl, param3:Function = null, param4:Function = null)
      {
         super(param1,param2,param3,param4);
      }
      
      public function getJsonResource() : JsonResource
      {
         return null;
      }
   }
}

