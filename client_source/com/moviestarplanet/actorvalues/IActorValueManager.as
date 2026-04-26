package com.moviestarplanet.actorvalues
{
   public interface IActorValueManager
   {
      
      function addValue(param1:int, param2:Number, param3:Boolean = true) : void;
      
      function subscribe(param1:IObserver) : void;
      
      function subscribeAt(param1:IObserver, param2:int) : void;
      
      function unsubscribe(param1:IObserver) : void;
   }
}

