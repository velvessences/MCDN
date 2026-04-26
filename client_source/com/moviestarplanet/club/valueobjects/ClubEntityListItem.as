package com.moviestarplanet.club.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class ClubEntityListItem
   {
      
      public var ClubEntityRelId:int;
      
      public var ClubId:int;
      
      public var EntityType:int;
      
      public var EntityId:int;
      
      public var Added:Date;
      
      public var Name:String;
      
      public var Deleted:int;
      
      public var Likes:int;
      
      public var Sells:int;
      
      public var AddedById:int;
      
      public var AddedByName:String;
      
      public var CreatorId:int;
      
      public var CreatorName:String;
      
      public var OfActorId:int;
      
      public var OfActorName:String;
      
      public var FameEarned:int;
      
      public var StarCoinsEarned:int;
      
      public var AverageRating:Number;
      
      public var WatchedCount:int;
      
      public var ExternalId:String;
      
      public var ExternalVideoId:int;
      
      public function ClubEntityListItem()
      {
         super();
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

