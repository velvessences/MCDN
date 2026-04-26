package com.moviestarplanet.msg
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class ActionEvent extends MsgEvent
   {
      
      public static const FRIENDSHIP_ACCEPTED:String = "FRIENDSHIP_ACCEPTED";
      
      public static const FRIENDSHIP_REQUEST:String = "FRIENDSHIP_REQUEST";
      
      public static const BUY_CLOTHES:String = "BUY_CLOTHES";
      
      public static const BUY_PET:String = "BUY_PET";
      
      public static const COMPLETE_ROUND_GAME:String = "COMPLETE_ROUND_GAME";
      
      public static const CREATE_SCRAPBLOG:String = "CREATE_SCRAPBLOG";
      
      public static const SCRAPBLOG_SAVED:String = "SCRAPBLOG_SAVED";
      
      public static const SCRAPBLOG_ITEM_ADDED:String = "SCRAPBLOG_ITEM_ADDED";
      
      public static const SCRAPBLOG_DELETED:String = "SCRAPBLOG_DELETED";
      
      public static const MOVIE_STAR_POPUP_OPENED_SELF:String = "MOVIE_STAR_POPUP_OPENED_SELF";
      
      public static const CLOTHES_CLICKED_IN_DRESSING_ROOM:String = "CLOTHES_CLICKED_IN_DRESSING_ROOM";
      
      public static const CLOTHES_CHANGED:String = "CLOTHES_CHANGED";
      
      public static const CREATE_NEW_LOOK_SELF:String = "CREATE_NEW_LOOK_SELF";
      
      public static const SAVED_NEW_LOOK_SELF:String = "SAVED_NEW_LOOK_SELF";
      
      public static const YOUTUBE_VIDEO_OPENED:String = "YOUTUBE_VIDEO_OPENED";
      
      public static const YOUTUBE_VIDEO_LIKED:String = "YOUTUBE_VIDEO_LIKED";
      
      public static const BUY_ITEM:String = "BUY_ITEM";
      
      public static const MY_ROOM_STUFF_ADDED:String = "MY_ROOM_STUFF_ADDED";
      
      public static const MY_ROOM_SAVED:String = "MY_ROOM_SAVED";
      
      public static const TRADE_ACTIVE:String = "TRADE_ACTIVE";
      
      public static const WISHLIST_GIFT_GIVEN:String = "WISHLIST_GIFT_GIVEN";
      
      public static const NEWS_BUTTON_CLICKED:String = "NEWS_BUTTON_CLICKED";
      
      public static const BLOCKED_AN_ACTOR:String = "BLOCKED_AN_ACTOR";
      
      public static const UNBLOCKED_AN_ACTOR:String = "UNBLOCKED_AN_ACTOR";
      
      public static const OPEN_ARCADE_GAME:String = "OPEN_ARCADE_GAME";
      
      public static const CLOSE_ARCADE_GAME:String = "CLOSE_ARCADE_GAME";
      
      public static const FAVORITE_ARTBOOK_SELECTED:String = "FAVORITE_ARTBOOK_SELECTED";
      
      public static const WALL_POST_ADDED:String = "WALL_POST_ADDED";
      
      public static const YOUTUBE_ADDED_TO_PLAYLIST:String = "YOUTUBE_ADDED_TO_PLAYLIST";
      
      public static const MINIMIZE_YOUTUBE:String = "MINIMIZE_YOUTUBE";
      
      public static const OPEN_CHAT_ROOM_INVITER:String = "OPEN_CHAT_ROOM_INVITER";
      
      public static const INVITE_FRIEND_TO_MY_ROOM:String = "INVITE_FRIEND";
      
      public static const INVITATION_TO_MY_ROOM_ACCEPTED:String = "INVITATION_ACCEPTED";
      
      public static const SIGN_AUTOGRAPH:String = "SIGN_AUTOGRAPH";
      
      public static const AUTOGRAPH_RECEIVED:String = "AUTOGRAPH_RECEIVED";
      
      public static const BUY_ANIMATION:String = "BUY_ANIMATION";
      
      public static const PLAY_ANIMATION:String = "PLAY_ANIMATION";
      
      public static const CLICK_MY_PROFILE:String = "CLICK_MY_PROFILE";
      
      public static const CLOSE_BUTTON_CLICKED_ARCADE_GAME:String = "CLOSE_BUTTON_CLICKED_ARCADE_GAME";
      
      public static const CLOSE_ARTBOOK:String = "CLOSE_ARTBOOK";
      
      public static const HIDE_BIO:String = "HIDE_BIO";
      
      public static const UNHIDE_BIO:String = "UNHIDE_BIO";
      
      public static const MINIMIZE_AVATAR_WIDGET:String = "MINIMIZE_AVATAR_WIDGET";
      
      public static const MAXIMIZE_AVATAR_WIDGET:String = "MAXIMIZE_AVATAR_WIDGET";
      
      public static const HIDE_AVATAR_ON_ACTIVITYBAR:String = "HIDE_AVATAR_ON_ACTIVITYBAR";
      
      public static const SHOW_AVATAR_ON_ACTIVITYBAR:String = "SHOW_AVATAR_ON_ACTIVITYBAR";
      
      public static const LOOK_WORN_EFFECT:String = "LOOK_WORN_EFFECT";
      
      public static const RESOURCEBAR_VISIBLE:String = "RESOURCEBAR_VISIBLE";
      
      public static const RESOURCEBAR_VIEW_TYPE:String = "RESOURCEBAR_VIEW";
      
      public static const SHOW_PARENT_EMAIL_POPUP:String = "SHOW_PARENT_EMAIL_POPUP";
      
      public function ActionEvent(param1:String, param2:* = null)
      {
         super(param1,param2);
      }
   }
}

