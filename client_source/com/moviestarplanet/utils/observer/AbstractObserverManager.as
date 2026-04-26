package com.moviestarplanet.utils.observer
{
   import com.moviestarplanet.actorvalues.IObserver;
   
   public class AbstractObserverManager
   {
      
      protected var subscribers:Array;
      
      public function AbstractObserverManager()
      {
         super();
         this.subscribers = new Array();
      }
      
      public function subscribe(param1:IObserver) : void
      {
         this.subscribers.push(param1);
      }
      
      public function subscribeAt(param1:IObserver, param2:int) : void
      {
         this.subscribers.splice(param2,0,param1);
      }
      
      public function unsubscribe(param1:IObserver) : void
      {
         var _loc2_:* = int(this.subscribers.length - 1);
         while(_loc2_ >= 0)
         {
            if(this.subscribers[_loc2_] == param1)
            {
               this.subscribers.splice(_loc2_,1);
               break;
            }
            _loc2_--;
         }
      }
      
      public function notify(param1:Object) : void
      {
         var _loc3_:IObserver = null;
         var _loc2_:Array = this.subscribers.concat();
         for each(_loc3_ in _loc2_)
         {
            if(this.subscribers.indexOf(_loc3_) >= 0)
            {
               _loc3_.update(param1);
            }
         }
      }
   }
}

