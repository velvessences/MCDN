package com.moviestarplanet.services.videoservice.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import mx.collections.ArrayCollection;
   
   public class YTPlaylistData
   {
      
      public var PlaylistId:int;
      
      public var Name:String;
      
      public var Likes:int;
      
      public var DateCreated:Date;
      
      public var SnapshotExternalRef:String;
      
      public var ActorId:int;
      
      public var YTActorLikes:ArrayCollection;
      
      public var ExternalVideoPlaylistRels:ArrayCollection;
      
      public function YTPlaylistData()
      {
         super();
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

