package com.moviestarplanet.services.videoservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class VideoListData
   {
      
      public var ExternalVideoId:int;
      
      public var ExternalRef:String;
      
      public var WatchedCount:int;
      
      public var Likes:int;
      
      public var Title:String;
      
      public var Deleted:int;
      
      public var PositionInPlaylist:int;
      
      public var PlaylistId:int;
      
      public var MspTvLiveEndDate:Date;
      
      public function VideoListData()
      {
         super();
      }
      
      public function get filteredTitle() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Title);
      }
   }
}

