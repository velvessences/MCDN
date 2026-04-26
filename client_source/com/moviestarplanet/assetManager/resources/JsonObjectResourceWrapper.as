package com.moviestarplanet.assetManager.resources
{
   import com.moviestarplanet.resources.ResourceWrapper;
   
   public class JsonObjectResourceWrapper extends ResourceWrapper
   {
      
      private var jsonObject:Object;
      
      public function JsonObjectResourceWrapper(param1:String, param2:Object)
      {
         this.jsonObject = param2;
         super(param1);
      }
      
      public function getJson(param1:Object) : Object
      {
         if(isSubscribed(param1))
         {
            return this.jsonObject;
         }
         throw new Error(_assetKey + " getJson() failed because the component has not subscribed properly");
      }
      
      override protected function dispose() : void
      {
         this.jsonObject = null;
         super.dispose();
      }
   }
}

