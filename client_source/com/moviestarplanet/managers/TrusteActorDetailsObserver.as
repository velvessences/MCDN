package com.moviestarplanet.managers
{
   import com.moviestarplanet.actor.IActorDetails;
   import com.moviestarplanet.actor.IActorSessionObserver;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.configurations.TrusteConfig;
   import com.moviestarplanet.model.ActorSession;
   
   public class TrusteActorDetailsObserver implements IActorSessionObserver
   {
      
      public function TrusteActorDetailsObserver()
      {
         super();
      }
      
      public function sessionUpdated(param1:IActorDetails) : void
      {
         TrusteConfig.getInstance().setup(ActorSession.age,Config.GetCountry.toLowerCase());
      }
   }
}

