package com.moviestarplanet.valueObjects
{
   public class WallPostItem
   {
      
      public var WallPostId:int;
      
      public var WallActorId:int;
      
      public var WallActorName:String;
      
      public var PostActorId:int;
      
      public var PostActorName:String;
      
      public var Message:String;
      
      public var CreatedDate:Date;
      
      public var Likes:int;
      
      public var Comments:int;
      
      public var WallActorMembershipTimeoutDate:Date;
      
      public var PostActorMembershipTimeoutDate:Date;
      
      public var WallActorVipTier:int;
      
      public var PostActorVipTier:int;
      
      public var IsBrag:Boolean;
      
      public var MessageWhitelisted:String;
      
      public var MessageBlacklisted:String;
      
      public function WallPostItem()
      {
         super();
      }
   }
}

