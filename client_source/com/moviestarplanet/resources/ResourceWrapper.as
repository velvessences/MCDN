package com.moviestarplanet.resources
{
   public class ResourceWrapper
   {
      
      public var _assetKey:String;
      
      public function ResourceWrapper(param1:String)
      {
         super();
         GenericResourceManager.addResource(param1,this);
         this._assetKey = param1;
      }
      
      public function subscribe(param1:Object) : void
      {
         GenericResourceManager.subscribe(this._assetKey,param1);
      }
      
      final protected function isSubscribed(param1:Object) : Boolean
      {
         return GenericResourceManager.isSubscribed(this._assetKey,param1);
      }
      
      public function unsubscribe(param1:Object) : void
      {
         GenericResourceManager.unsubscribe(this._assetKey,param1);
         if(GenericResourceManager.subscriptionsLeft(this._assetKey) == 0)
         {
            this.dispose();
         }
      }
      
      protected function dispose() : void
      {
         GenericResourceManager.removeResource(this._assetKey);
      }
   }
}

