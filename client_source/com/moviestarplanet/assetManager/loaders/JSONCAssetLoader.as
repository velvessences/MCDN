package com.moviestarplanet.assetManager.loaders
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.resources.JsonObjectResourceWrapper;
   import com.moviestarplanet.assetManager.resources.JsonResource;
   import com.moviestarplanet.resources.GenericResourceManager;
   import flash.utils.ByteArray;
   
   public class JSONCAssetLoader extends JSONBaseAssetLoader
   {
      
      public function JSONCAssetLoader(param1:UnionRep, param2:IAssetUrl, param3:Function = null, param4:Function = null)
      {
         super(param1,param2,param3,param4);
         this.returnByteArray = true;
         if(param1 == null)
         {
            throw new Error("JSONCAssetLoader can only be instantiated from AssetManager");
         }
      }
      
      final public function getJSONC() : JsonResource
      {
         var jsonObjectResourceWrapper:JsonObjectResourceWrapper = null;
         var payloadBytes:ByteArray = null;
         var jsonObject:Object = null;
         if(!GenericResourceManager.hasResource(assetKey))
         {
            payloadBytes = payload as ByteArray;
            payloadBytes.position = 0;
            try
            {
               payloadBytes.uncompress();
            }
            catch(error:Error)
            {
               trace("this data is not compressed...(we use it as is):",error.message);
            }
            jsonObject = payloadBytes.readObject();
            payloadBytes.clear();
            payload = null;
            new JsonObjectResourceWrapper(assetKey,jsonObject);
         }
         jsonObjectResourceWrapper = JsonObjectResourceWrapper(GenericResourceManager.getResource(assetKey));
         return new JsonResource(jsonObjectResourceWrapper);
      }
      
      override public function getJsonResource() : JsonResource
      {
         return this.getJSONC();
      }
   }
}

