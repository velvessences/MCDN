package com.moviestarplanet.assetManager.loaders
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.resources.JsonObjectResourceWrapper;
   import com.moviestarplanet.assetManager.resources.JsonResource;
   import com.moviestarplanet.resources.GenericResourceManager;
   import flash.utils.ByteArray;
   
   public class JSONAssetLoader extends JSONBaseAssetLoader
   {
      
      public function JSONAssetLoader(param1:UnionRep, param2:IAssetUrl, param3:Function = null, param4:Function = null)
      {
         super(param1,param2,param3,param4);
         this.returnByteArray = true;
         if(param1 == null)
         {
            throw new Error("JSONAssetLoader can only be instantiated from AssetManager");
         }
      }
      
      final public function getJSON() : JsonResource
      {
         var _loc1_:JsonObjectResourceWrapper = null;
         var _loc2_:Object = null;
         if(!GenericResourceManager.hasResource(assetKey))
         {
            _loc2_ = JSON.parse((payload as ByteArray).toString());
            (payload as ByteArray).clear();
            payload = null;
            new JsonObjectResourceWrapper(assetKey,_loc2_);
         }
         _loc1_ = JsonObjectResourceWrapper(GenericResourceManager.getResource(assetKey));
         return new JsonResource(_loc1_);
      }
      
      override public function getJsonResource() : JsonResource
      {
         return this.getJSON();
      }
   }
}

