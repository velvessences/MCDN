package com.moviestarplanet.contentservices.valueobjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class VideoListExtendedData
   {
      
      public var ExternalVideoId:int;
      
      public var ExternalRef:String;
      
      public var WatchedCount:int;
      
      public var Likes:int;
      
      public var Title:String;
      
      public var Deleted:int;
      
      public var PositionInPlaylist:int;
      
      public var PlaylistId:int;
      
      public var ActorName:String;
      
      public var ActorId:int;
      
      public var PlaylistName:String;
      
      public function VideoListExtendedData()
      {
         super();
      }
      
      public function get filteredTitle() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Title);
      }
      
      public function get filteredPlaylistName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.PlaylistName);
      }
   }
}

