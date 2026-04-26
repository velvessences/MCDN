package com.moviestarplanet.activityservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class ActivityExternalVideo
   {
      
      public var ExternalVideoId:int;
      
      public var ExternalRef:String;
      
      public var Type:int;
      
      public var WatchedCount:int;
      
      public var Likes:int;
      
      public var Title:String;
      
      public var Deleted:int;
      
      public var CreatorId:int;
      
      public var DatePublished:Date;
      
      public function ActivityExternalVideo()
      {
         super();
      }
      
      public function get filteredTitle() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Title);
      }
   }
}

