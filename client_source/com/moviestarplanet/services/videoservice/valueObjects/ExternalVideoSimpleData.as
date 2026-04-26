package com.moviestarplanet.services.videoservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class ExternalVideoSimpleData
   {
      
      public var ExternalVideoId:int;
      
      public var ExternalVideoActorRelId:int;
      
      public var ExternalRef:String;
      
      public var Title:String;
      
      public var WatchedCount:int;
      
      public var Likes:int;
      
      public var DateAdded:Date;
      
      public var DatePublished:Date;
      
      public var Name:String;
      
      public var ActorId:int;
      
      public var YTWatchedCount:int;
      
      public var Deleted:int;
      
      public var DeleteType:int;
      
      public var ReportCount:int;
      
      public var CategoryId:int;
      
      public var Restricted:Boolean;
      
      public var MspTvLiveEndDate:Date;
      
      public function ExternalVideoSimpleData()
      {
         super();
      }
      
      public function get filteredTitle() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Title);
      }
   }
}

