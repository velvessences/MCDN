package com.moviestarplanet.usersession.valueobjects
{
   public class ActorDetailSecure
   {
      
      public var actorDetails:ActorDetails;
      
      public var password:String;
      
      public function ActorDetailSecure()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.actorDetails = param1.actorDetails;
         this.password = param1.password;
      }
   }
}

