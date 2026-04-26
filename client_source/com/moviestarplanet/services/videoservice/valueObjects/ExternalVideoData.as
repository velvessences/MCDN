package com.moviestarplanet.services.videoservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import mx.collections.ArrayCollection;
   
   public class ExternalVideoData
   {
      
      public var Approved:int;
      
      public var AutoBlockDate:Date;
      
      public var CreatorId:int;
      
      public var DateAdded:Date;
      
      public var DatePublished:Date;
      
      public var Deleted:int;
      
      public var EverythingIsAwesome:Boolean;
      
      public var ExternalRef:String;
      
      public var ExternalVideoActorRels:ArrayCollection;
      
      public var ExternalVideoId:int;
      
      public var ExternalVideoPlaylistRels:ArrayCollection;
      
      public var IPOfReporter:int;
      
      public var Likes:int;
      
      public var MspTvIconVisible:Boolean;
      
      public var MspTvPromotionVisible:Boolean;
      
      public var MspTvLiveStartDate:Date;
      
      public var MspTvLiveEndDate:Date;
      
      public var MspTvStickyStartDate:Date;
      
      public var MspTvStickyEndDate:Date;
      
      public var ReportCount:int;
      
      public var ReportIP:int;
      
      public var ReportResetCount:int;
      
      public var Title:String;
      
      public var Type:int;
      
      public var WatchedCount:int;
      
      public var YTActorLikes:ArrayCollection;
      
      public var CategoryId:int;
      
      public var DeleteType:int;
      
      public var CommentCount:int;
      
      public var IsMobileBlocked:int;
      
      public var LastMobileBlockCheck:Date;
      
      public function ExternalVideoData()
      {
         super();
      }
      
      public function get filteredTitle() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Title);
      }
   }
}

