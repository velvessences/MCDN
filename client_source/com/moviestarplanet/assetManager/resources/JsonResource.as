package com.moviestarplanet.assetManager.resources
{
   public dynamic class JsonResource
   {
      
      private var jsonObjectResourceWrapper:JsonObjectResourceWrapper;
      
      public function JsonResource(param1:JsonObjectResourceWrapper)
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         super();
         this.jsonObjectResourceWrapper = param1;
         this.jsonObjectResourceWrapper.subscribe(this);
         var _loc2_:Object = this.jsonObjectResourceWrapper.getJson(this);
         for(_loc3_ in _loc2_)
         {
            _loc4_ = _loc2_[_loc3_];
            this[_loc3_] = _loc4_;
         }
      }
      
      public function dispose() : void
      {
         if(this.jsonObjectResourceWrapper != null)
         {
            this.jsonObjectResourceWrapper.unsubscribe(this);
         }
         this.jsonObjectResourceWrapper = null;
      }
   }
}

