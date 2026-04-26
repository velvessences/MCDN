package com.moviestarplanet.activityservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class ActivityMovie
   {
      
      public var MovieId:int;
      
      public var Name:String;
      
      public var ActorId:int;
      
      public var State:int;
      
      public var WatchedTotalCount:int;
      
      public var WatchedActorCount:int;
      
      public var RatedCount:int;
      
      public var RatedTotalScore:int;
      
      public var StarCoinsEarned:int;
      
      public var PublishedDate:Date;
      
      public var Complexity:int;
      
      public function ActivityMovie()
      {
         super();
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

