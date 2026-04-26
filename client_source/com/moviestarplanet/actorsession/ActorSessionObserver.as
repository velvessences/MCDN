package com.moviestarplanet.actorsession
{
   import com.moviestarplanet.actor.IActorDetails;
   import com.moviestarplanet.actor.IActorSessionObserver;
   import com.moviestarplanet.core.controller.commands.startupcommands.MoviestarInfoUpdatedHandler;
   import com.moviestarplanet.events.MessageCommunicator;
   
   public class ActorSessionObserver implements IActorSessionObserver
   {
      
      private static var instance:ActorSessionObserver;
      
      public function ActorSessionObserver()
      {
         super();
      }
      
      public static function getInstance() : ActorSessionObserver
      {
         if(instance == null)
         {
            instance = new ActorSessionObserver();
         }
         return instance;
      }
      
      public function sessionUpdated(param1:IActorDetails) : void
      {
         MessageCommunicator.sendMessage(MoviestarInfoUpdatedHandler.UPDATE_MOVIESTAR_INFO,null);
      }
   }
}

