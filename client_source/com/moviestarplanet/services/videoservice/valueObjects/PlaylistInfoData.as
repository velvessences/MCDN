package com.moviestarplanet.services.videoservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class PlaylistInfoData
   {
      
      public var ActorName:String;
      
      public var Likes:int;
      
      public var PlaylistName:String;
      
      public var StartNumber:int;
      
      public var Videos:Array;
      
      public function PlaylistInfoData()
      {
         super();
      }
      
      public function get filteredPlaylistName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.PlaylistName);
      }
   }
}

