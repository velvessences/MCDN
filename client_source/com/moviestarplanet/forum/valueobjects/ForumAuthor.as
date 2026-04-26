package com.moviestarplanet.forum.valueobjects
{
   import com.moviestarplanet.actor.IActorBase;
   import com.moviestarplanet.actorutils.ActorUtils;
   
   public class ForumAuthor implements IActorBase
   {
      
      public var ActorId:int;
      
      public var Name:String;
      
      public var Moderator:int;
      
      public var MembershipTimeoutDate:Date;
      
      public var VipTier:int;
      
      public function ForumAuthor()
      {
         super();
      }
      
      public function get isVip() : Boolean
      {
         return ActorUtils.isVip(this.MembershipTimeoutDate);
      }
   }
}

