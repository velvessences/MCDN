package com.moviestarplanet.activityservice.valueObjects
{
   public class Activity
   {
      
      public var ActivityId:int;
      
      public var ActorId:int;
      
      public var ActivityType:int;
      
      public var _Date:Date;
      
      public var EntityType:int;
      
      public var EntityId:int;
      
      private var _hasLiked:Boolean;
      
      public var ActivityMovie:com.moviestarplanet.activityservice.valueObjects.ActivityMovie;
      
      public var Actor:com.moviestarplanet.activityservice.valueObjects.ActivityActor;
      
      public var ActivityActor:com.moviestarplanet.activityservice.valueObjects.ActivityActor;
      
      public var ActivityContest:com.moviestarplanet.activityservice.valueObjects.ActivityContest;
      
      public var ActivityMood:com.moviestarplanet.activityservice.valueObjects.ActivityMood;
      
      public var ActivityLook:com.moviestarplanet.activityservice.valueObjects.ActivityLook;
      
      public var ActivityScrapBlog:com.moviestarplanet.activityservice.valueObjects.ActivityScrapBlog;
      
      public var ActivityExternalVideoActorRel:com.moviestarplanet.activityservice.valueObjects.ActivityExternalVideoActorRel;
      
      public var ActivityExternalVideoPlaylistRel:com.moviestarplanet.activityservice.valueObjects.ActivityExternalVideoPlaylistRel;
      
      public var ActivityExternalVideo:com.moviestarplanet.activityservice.valueObjects.ActivityExternalVideo;
      
      public var ActivityWallPost:com.moviestarplanet.activityservice.valueObjects.ActivityWallPost;
      
      public var ActivityImageUpload:com.moviestarplanet.activityservice.valueObjects.ActivityImageUpload;
      
      public var ActivityDesign:com.moviestarplanet.activityservice.valueObjects.ActivityDesign;
      
      public function Activity()
      {
         super();
      }
      
      public function get Type() : int
      {
         return this.ActivityType;
      }
      
      public function get MovieId() : int
      {
         return this.EntityId;
      }
      
      public function get FriendId() : int
      {
         return this.EntityId;
      }
      
      public function get ContestId() : int
      {
         return this.EntityId;
      }
      
      public function get LookId() : int
      {
         return this.EntityId;
      }
      
      public function get ScrapBlogId() : int
      {
         return this.EntityId;
      }
      
      public function get ExternalVideoActorRelId() : int
      {
         return this.EntityId;
      }
      
      public function get ExternalVideoPlaylistRelId() : int
      {
         return this.EntityId;
      }
      
      public function get WallPostId() : int
      {
         return this.EntityId;
      }
      
      public function get PhotoId() : int
      {
         return this.EntityId;
      }
      
      public function get DesignId() : int
      {
         return this.EntityId;
      }
      
      public function get hasLiked() : Boolean
      {
         return this._hasLiked;
      }
      
      public function set hasLiked(param1:Boolean) : void
      {
         this._hasLiked = param1;
      }
   }
}

