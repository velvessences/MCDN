package com.moviestarplanet.usersession
{
   import com.moviestarplanet.actor.IActorDetails;
   import com.moviestarplanet.actor.IActorSessionNotifier;
   import com.moviestarplanet.actor.IActorSessionObserver;
   
   public class ActorSessionNotifier implements IActorSessionNotifier
   {
      
      private static var instance:IActorSessionNotifier;
      
      private var observers:Vector.<IActorSessionObserver>;
      
      public function ActorSessionNotifier()
      {
         super();
         this.observers = new Vector.<IActorSessionObserver>();
      }
      
      public static function getInstance() : IActorSessionNotifier
      {
         if(instance == null)
         {
            instance = new ActorSessionNotifier();
         }
         return instance;
      }
      
      public function subscribe(param1:IActorSessionObserver) : void
      {
         this.observers.push(param1);
      }
      
      public function unsubscribe(param1:IActorSessionObserver) : void
      {
         var _loc2_:int = int(this.observers.indexOf(param1));
         if(_loc2_ > -1)
         {
            this.observers.splice(_loc2_,1);
         }
      }
      
      public function notify(param1:IActorDetails) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(this.observers.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.observers[_loc3_].sessionUpdated(param1);
            _loc3_++;
         }
      }
   }
}

