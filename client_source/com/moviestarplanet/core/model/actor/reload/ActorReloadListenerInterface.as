package com.moviestarplanet.core.model.actor.reload
{
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   import com.moviestarplanet.usersession.valueobjects.ActorDetailsExtended;
   
   public interface ActorReloadListenerInterface
   {
      
      function notify(param1:ActorDetails, param2:ActorDetailsExtended) : void;
   }
}

