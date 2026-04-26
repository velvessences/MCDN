package com.moviestarplanet.admin.valueobjects
{
   public class ActorReport
   {
      
      public var ActorId:int;
      
      public var Name:String;
      
      public var MembershipPurchasedDate:Date;
      
      public var MembershipTimeoutDate:Date;
      
      public var Level:int;
      
      public var Moderator:int;
      
      public var LockedUntil:Date;
      
      public var VipTier:int;
      
      public function ActorReport()
      {
         super();
      }
   }
}

