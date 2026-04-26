package com.moviestarplanet.activities
{
   import com.moviestarplanet.activityservice.service.ActivityAmfServiceForWeb;
   import com.moviestarplanet.activityservice.valueObjects.ActivityUpdater;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.utils.EntityTypeType;
   
   public class OldActivityCreator
   {
      
      private static var _instance:OldActivityCreator;
      
      public function OldActivityCreator(param1:SingletonBlocker)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Do not instantiate. Use \'getInstance()\'");
         }
      }
      
      public static function getInstance() : OldActivityCreator
      {
         if(_instance == null)
         {
            _instance = new OldActivityCreator(new SingletonBlocker());
         }
         return _instance;
      }
      
      public function createActivity(param1:Number, param2:int = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 0) : void
      {
         var done:Function = null;
         var activityType:Number = param1;
         var movieId:int = param2;
         var friendId:Number = param3;
         var contestId:Number = param4;
         var lookId:Number = param5;
         var scrapBlogId:Number = param6;
         var externalVideoActorRelId:Number = param7;
         var externalVideoPlaylistRelId:Number = param8;
         var wallpostId:Number = param9;
         done = function():void
         {
         };
         var activity:ActivityUpdater = new ActivityUpdater();
         activity.ActivityId = 0;
         activity.ActorId = ActorSession.getActorId();
         activity.ActivityType = activityType;
         activity._Date = new Date(2000,1,1);
         if(movieId != 0)
         {
            activity.EntityType = EntityTypeType.MOVIE;
            activity.EntityId = movieId;
         }
         else if(lookId != 0)
         {
            activity.EntityType = EntityTypeType.LOOK;
            activity.EntityId = lookId;
         }
         else if(scrapBlogId != 0)
         {
            activity.EntityType = EntityTypeType.SCRAPBLOG;
            activity.EntityId = scrapBlogId;
         }
         else if(externalVideoActorRelId != 0)
         {
            activity.EntityType = EntityTypeType.EXTERNAL_VIDEO_ACTOR_REL;
            activity.EntityId = externalVideoActorRelId;
         }
         else if(externalVideoPlaylistRelId != 0)
         {
            activity.EntityType = EntityTypeType.EXTERNAL_VIDEO_PLAYLIST_REL;
            activity.EntityId = externalVideoPlaylistRelId;
         }
         else if(wallpostId != 0)
         {
            activity.EntityType = EntityTypeType.WALLPOST;
            activity.EntityId = wallpostId;
         }
         new ActivityAmfServiceForWeb().createActivity(activity,done);
      }
   }
}

class SingletonBlocker
{
   
   public function SingletonBlocker()
   {
      super();
   }
}
