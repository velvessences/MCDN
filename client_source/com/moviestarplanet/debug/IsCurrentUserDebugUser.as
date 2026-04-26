package com.moviestarplanet.debug
{
   import com.moviestarplanet.model.ActorSession;
   
   public class IsCurrentUserDebugUser
   {
      
      public function IsCurrentUserDebugUser()
      {
         super();
      }
      
      public function execute() : Boolean
      {
         return ActorSession.loggedInActor != null && (ActorSession.loggedInActor.Name == "stig" || ActorSession.loggedInActor.Name == "claus" || ActorSession.loggedInActor.Name == "girldragon");
      }
   }
}

