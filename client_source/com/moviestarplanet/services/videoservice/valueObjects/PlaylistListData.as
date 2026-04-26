package com.moviestarplanet.services.videoservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import flash.events.EventDispatcher;
   
   public class PlaylistListData extends EventDispatcher
   {
      
      public var PlaylistId:int;
      
      public var ActorName:String;
      
      public var ActorId:int;
      
      public var Likes:int;
      
      public var SnapshotExternalRef:String;
      
      public var DateCreated:Date;
      
      public var VideoAmount:int;
      
      public var HasLiked:Boolean;
      
      public var PlaylistName:String;
      
      public function PlaylistListData()
      {
         super();
      }
      
      public function get filteredPlaylistName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.PlaylistName);
      }
   }
}

