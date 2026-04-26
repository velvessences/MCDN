package com.moviestarplanet.activityservice.valueObjects
{
   import com.moviestarplanet.actor.IActorBase;
   import com.moviestarplanet.actorutils.ActorUtils;
   
   public dynamic class ActivityActor implements IActorBase
   {
      
      public var ActorId:int;
      
      public var Name:String;
      
      public var RoomLikes:int;
      
      public var MembershipTimeoutDate:Date;
      
      public var Moderator:int;
      
      public var VipTier:int;
      
      public var Level:int;
      
      public var Activities:Object;
      
      public var Activities1:Object;
      
      public function ActivityActor()
      {
         super();
      }
      
      public function get isVip() : Boolean
      {
         return ActorUtils.isVip(this.MembershipTimeoutDate);
      }
   }
}

