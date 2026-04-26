package com.moviestarplanet.activityservice.valueObjects
{
   public class ActivityExternalVideoPlaylistRel
   {
      
      public var ExternalVideoPlaylistRelId:int;
      
      public var ExternalVideoId:int;
      
      public var PlaylistId:int;
      
      public var PositionInPlaylist:int;
      
      public var DateAdded:Date;
      
      public var ActivityExternalVideo:com.moviestarplanet.activityservice.valueObjects.ActivityExternalVideo;
      
      public function ActivityExternalVideoPlaylistRel()
      {
         super();
      }
   }
}

