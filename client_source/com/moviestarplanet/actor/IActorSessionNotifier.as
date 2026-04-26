package com.moviestarplanet.actor
{
   public interface IActorSessionNotifier
   {
      
      function subscribe(param1:IActorSessionObserver) : void;
      
      function unsubscribe(param1:IActorSessionObserver) : void;
      
      function notify(param1:IActorDetails) : void;
   }
}

