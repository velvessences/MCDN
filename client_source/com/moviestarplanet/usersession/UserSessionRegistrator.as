package com.moviestarplanet.usersession
{
   import com.moviestarplanet.commoninterfaces.IRegistrator;
   import com.moviestarplanet.usersession.valueobjects.ActorDetailSecure;
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   import com.moviestarplanet.usersession.valueobjects.ActorDetailsVersion;
   import com.moviestarplanet.usersession.valueobjects.ActorPersonalInfo;
   import com.moviestarplanet.usersession.valueobjects.NewActorCreationData;
   import flash.net.registerClassAlias;
   
   public class UserSessionRegistrator implements IRegistrator
   {
      
      private static var hasRegistered:Boolean = false;
      
      public function UserSessionRegistrator()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         if(!hasRegistered)
         {
            registerClassAlias("MovieStarPlanet.DBML.ActorDetails",ActorDetails);
            registerClassAlias("MovieStarPlanet.DBML.ActorPersonalInfo",ActorPersonalInfo);
            registerClassAlias("MovieStarPlanet.WebService.UserSession.AMFUserSessionService+ActorDetailsVersion",ActorDetailsVersion);
            registerClassAlias("MovieStarPlanet.Webservice.UserSession.AMFUserSessionService.ActorDetailSecure",ActorDetailSecure);
            registerClassAlias("MovieStarPlanet.WebService.User.ValueObjects.NewActorCreationData",NewActorCreationData);
            hasRegistered = true;
         }
      }
   }
}

