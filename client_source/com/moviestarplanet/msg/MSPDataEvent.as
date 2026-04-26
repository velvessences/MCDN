package com.moviestarplanet.msg
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class MSPDataEvent extends MsgEvent
   {
      
      public static const FRIEND_CONNECTION_STATUS_CHANGED:String = "friendConnectionStatusChanged";
      
      public static const NOTIFICATION_TO_SELF:String = "notificationToSelf";
      
      public static const ACTOR_MOOD_CHANGE:String = "actorMoodChange";
      
      public static const WALL_POST_ADDED:String = "wallPostAdded";
      
      public static const WALL_POST_DELETED:String = "wallPostDeleted";
      
      public static const FRIEND_DATA_CHANGE:String = "friendDataChange";
      
      public static const AUTOGRAPH_DATA_REFRESH:String = "autograph_data_refresh";
      
      public static const BLOCKED_BY_USER:String = "BLOCKED_BY_USER";
      
      public static const UNBLOCKED_BY_USER:String = "UNBLOCKED_BY_USER";
      
      public static const AWARD_DISTRUBTED:String = "awardDistributed";
      
      public static const FRIEND_CONNECTION_READY:String = "FRIEND_CONNECTION_READY";
      
      public static const WHITELIST_LOADED:String = "WHITELIST_LOADED";
      
      public static const LOGGED_IN_SET:String = "LOGGED_IN_SET";
      
      public static const SPECIAL_RELATIONSHIP_CHANGED:String = "SPECIAL_RELATIONSHIP_CHANGED";
      
      public static const FRIEND_REQUEST_SENT_TO_NON_FRIEND:String = "MSPDataEvent.FRIEND_REQUEST_SENT_TO_NON_FRIEND";
      
      public static const MOVIE_FROM_URL_CLOSED:String = "MSPDataEvent.MOVIE_FROM_URL_CLOSED";
      
      public function MSPDataEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

