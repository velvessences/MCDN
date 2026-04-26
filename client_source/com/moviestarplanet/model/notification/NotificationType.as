package com.moviestarplanet.model.notification
{
   public class NotificationType
   {
      
      private static const allItems:Array = [];
      
      public static const AUTOGRAPH:NotificationType = new NotificationType("AUTOGRAPH","GAVE_AUTOGRAPH","img/used/blog_48.gif",["actorName"]);
      
      public static const AUTOGRAPH_NON_FRIEND:NotificationType = new NotificationType("AUTOGRAPH_NON_FRIEND","","",[]);
      
      public static const HUG:NotificationType = new NotificationType("HUG","GAVE_HUG","img/used/blog_48.gif",[]);
      
      public static const RBP_XP_GIFT:NotificationType = new NotificationType("RBP_XP_GIFT","GAVE_RBP_XP_GIFT","img/used/blog_48.gif",[]);
      
      public static const SERVER_NUDGE:NotificationType = new NotificationType("SERVER_NUDGE","","",[]);
      
      public static const GROUP_CHAT:NotificationType = new NotificationType("GROUP_CHAT","","img/32x32/message.png",["firstParam"]);
      
      public static const GROUP_CHAT_USER_JOINED:NotificationType = new NotificationType("GROUP_CHAT_USER_JOINED","","img/32x32/message.png",["conversationId","joinedActorId"]);
      
      public static const GROUP_CHAT_USER_LEFT:NotificationType = new NotificationType("GROUP_CHAT_USER_LEFT","","img/32x32/message.png",["conversationId","authorId"]);
      
      public static const GROUP_CHAT_INVITE_RECEIVED:NotificationType = new NotificationType("GROUP_CHAT_INVITE_RECEIVED","","img/32x32/message.png",["conversationId","authorId"]);
      
      public static const CHAT_TYPE:NotificationType = new NotificationType("CHAT","","img/32x32/message.png",["firstParam"]);
      
      public static const TWIT_TYPE:NotificationType = new NotificationType("TWIT","","img/used/animation_48.gif",["firstParam"]);
      
      public static const ISWRITING:NotificationType = new NotificationType("ISWRITING","WRITING_LOCALE","res/chaticon.png",[]);
      
      public static const STOPPED_WRITING:NotificationType = new NotificationType("STOPPEDWRITING","STOPPED_WRITING_LOCALE","",[]);
      
      public static const CHATROOM_ENTER:NotificationType = new NotificationType("CHATROOM","IS_IN_THE","img/used/world_48.png",["actorName","chatRoomName"]);
      
      public static const INVITETOCHATROOM:NotificationType = new NotificationType("INVITETOCHATROOM","INVITED_TO_ROOM","img/used/world_48.png",["actorName","chatRoomName"]);
      
      public static const MINIGAMEINVITE:NotificationType = new NotificationType("MINIGAMEINVITE","PRIVATE_MINIGAME_CREATED_TOOLTIP","img/32x32/Dice_32x32.png",["actorName","firstParam"]);
      
      public static const FRIENDCONNECTED:NotificationType = new NotificationType("connected","","",[]);
      
      public static const RELOADMYITEMS:NotificationType = new NotificationType("RELOADMYITEMS","","",[]);
      
      public static const UPDATE:NotificationType = new NotificationType("UPDATE","","",[]);
      
      public static const CONNECTED:NotificationType = new NotificationType("CONNECTED","","",[]);
      
      public static const FRIENDREJECT:NotificationType = new NotificationType("FRIENDREJECT","","",[]);
      
      public static const BOYFRIENDREJECT:NotificationType = new NotificationType("BOYFRIENDREJECT","","",[]);
      
      public static const BESTFRIENDREJECT:NotificationType = new NotificationType("BESTFRIENDREJECT","","",[]);
      
      public static const DELETE_FRIEND:NotificationType = new NotificationType("DELETE_FRIEND","","",[]);
      
      public static const BLOCKED_BY_USER:NotificationType = new NotificationType("BLOCKED_BY_USER","","",[]);
      
      public static const UNBLOCKED_BY_USER:NotificationType = new NotificationType("UNBLOCKED_BY_USER","","",[]);
      
      public static const TRADE_COMPLETED:NotificationType = new NotificationType("TRADE_COMPLETED","TRADE_ACTIVITY_COMPLETED","img/32x32/TradeIcon.png",[]);
      
      public static const TRADE:NotificationType = new NotificationType("TRADE","TRADE_ACTIVITY_REQUEST","img/32x32/TradeIcon.png",["actorName"]);
      
      public static const MYROOM_LIKE:NotificationType = new NotificationType("MYROOM_LIKE","HAS_LIKED_ROOM","img/32x32/Love_it_room.png",["actorName"]);
      
      public static const MYROOM:NotificationType = new NotificationType("MYROOM","HAS_UPDATED_ROOM","img/used/world_48.png",["actorName"]);
      
      public static const GUESTBOOK:NotificationType = new NotificationType("GUESTBOOK","HAS_ADDED_GUESTBOOK","img/48x48/IconExperience/book_open.png",["actorName"]);
      
      public static const POST_ON_YOUR_WALL:NotificationType = new NotificationType("POST_ON_YOUR_WALL","PROFILE_WALL_POST_OTHERS","img/48x48/IconExperience/book_open.png",["actorName"]);
      
      public static const POST_ON_OTHER_WALL:NotificationType = new NotificationType("POST_ON_OTHER_WALL","PROFILE_WALL_POST_NOTIFICATION","img/48x48/IconExperience/book_open.png",["actorName"]);
      
      public static const YOUTUBE_NEW:NotificationType = new NotificationType("YOUTUBE_NEW","I_ADDED_THIS_VIDEO","img/32x32/YouTubeActivity_32x32.png",[]);
      
      public static const PROFILE:NotificationType = new NotificationType("PROFILE","HAS_UPDATED_PROFILE","img/48x48/IconExperience/id_card.png",["actorName"]);
      
      public static const LEVEL:NotificationType = new NotificationType("LEVEL","HAS_HIGHER_LEVEL","img/48x48/IconExperience/star_yellow.png",["actorName"]);
      
      public static const INVITATIONBONUS:NotificationType = new NotificationType("INVITATIONBONUS","NEW_RECIEVED_INVITATION_BONUS","img/48x48/IconExperience/moneybag_dollar.png",["actorName"]);
      
      public static const CONTESTJOINED:NotificationType = new NotificationType("CONTESTJOINED","HAN_ENTERED_CONTEST","img/48x48/IconExperience/star_yellow.png",["actorName"]);
      
      public static const SCRAPBLOG_LIKE:NotificationType = new NotificationType("SCRAPBLOG_LIKE","HAS_LIKED_ARTBOOK","swf/scrapblog/Butterfly_Icon_love_20x20.png",["actorName"]);
      
      public static const PLAYLIST_LIKE:NotificationType = new NotificationType("PLAYLIST_LIKE","HAS_LIKED_PLAYLIST","img/32x32/YouTubeActivity_32x32.png",["actorName"]);
      
      public static const SCRAPBLOG_SAVE:NotificationType = new NotificationType("SCRAPBLOG_SAVE","I_CREATED_THIS_ARTBOOK","swf/scrapblog/Butterfly_Icon_20x20.png",[]);
      
      public static const PHOTO_LIKE:NotificationType = new NotificationType("PHOTO_LIKE","HAS_LIKED_PHOTO","swf/scrapblog/Butterfly_Icon_love_20x20.png",["actorName",""]);
      
      public static const MOVIE:NotificationType = new NotificationType("MOVIE","I_CREATED_THIS_MOVIE","img/48x48/IconExperience/movie.png",[]);
      
      public static const CLOTHES:NotificationType = new NotificationType("CLOTHES","HAS_CHANGED_CLOTHES","img/48x48/IconExperience/shoppingbasket_full.png",["actorName"]);
      
      public static const NEW_DESIGN_CREATED:NotificationType = new NotificationType("NEW_DESIGN_CREATED","DESIGN_PRODUCED","",["actorName"]);
      
      public static const SKIN:NotificationType = new NotificationType("SKIN","HAS_CHANGED_CLOTHES","img/48x48/IconExperience/shoppingbasket_full.png",["actorName"]);
      
      public static const GIFT:NotificationType = new NotificationType("GIFT","GOT_GIFT","img/32x32/Gift_small_icon.png",["actorName"]);
      
      public static const VIP_GIFT:NotificationType = new NotificationType("VIP_GIFT","GOT_GIFT","img/32x32/Gift_small_icon.png",["actorName"]);
      
      public static const MYLOOK_BUY:NotificationType = new NotificationType("MYLOOK_BUY","HAS_BOUGHT_LOOK","img/32x32/BuyLooks.png",["actorName"]);
      
      public static const MYLOOK:NotificationType = new NotificationType("MYLOOK","I_CREATED_THIS_LOOK","img/32x32/New_Look_activity.png",[]);
      
      public static const MYLOOK_LIKE:NotificationType = new NotificationType("MYLOOK_LIKE","HAS_LIKED_LOOK","img/32x32/New_Look_activity.png",["actorName"]);
      
      public static const MOVIERATED:NotificationType = new NotificationType("MOVIERATED","HAS_RATED_CLICK","img/32x32/Thumbs Up.png",["actorName"]);
      
      public static const YOUR_MOVIE_WATCHED:NotificationType = new NotificationType("HAS_WATCHED_YOUR_MOVIE","HAS_WATCHED_YOUR_MOVIE","img/32x32/Thumbs Up.png",["actorName"]);
      
      public static const YOUR_MOVIE_RATED:NotificationType = new NotificationType("HAS_RATED_YOUR_MOVIE","HAS_RATED_YOUR_MOVIE","img/32x32/Thumbs Up.png",["actorName"]);
      
      public static const FRIENDREQ:NotificationType = new NotificationType("FRIENDREQ","HAS_INVITED_FRIENDS","img/32x32/Student High School 1 Add.png",["actorName"]);
      
      public static const FRIENDREQ_RECEIVED:NotificationType = new NotificationType("FRIENDREQ_RECEIVED","HAS_INVITED_FRIENDS","img/32x32/Student High School 1 Add.png",["actorName"]);
      
      public static const BOYFRIENDREQ:NotificationType = new NotificationType("BOYFRIENDREQ","WANTS_TO_BE_GIRLFRIEND","img/48x48/IconExperience/heart.png",["actorName","ROMANTIC_RELATION"]);
      
      public static const BESTFRIENDREQ:NotificationType = new NotificationType("BESTFRIENDREQ","WANTS_TO_BE_BESTFRIEND","img/16x16/bestfriend.png",["actorName"]);
      
      public static const FRIENDACCEPT:NotificationType = new NotificationType("FRIENDACCEPT","HAS_ACCEPTED","img/32x32/Student High School 1 Check.png",["actorName"]);
      
      public static const BOYFRIENDACCEPT:NotificationType = new NotificationType("BOYFRIENDACCEPT","HAS_ACCEPTED_GIRL","img/48x48/IconExperience/heart.png",["actorName","ROMANTIC_RELATION"]);
      
      public static const BREAKUP:NotificationType = new NotificationType("BREAKUP","HAS_BROKEN_UP","img/48x48/IconExperience/heart_broken.png",["actorName"]);
      
      public static const BESTFRIENDACCEPT:NotificationType = new NotificationType("BESTFRIENDACCEPT","HAS_ACCEPTED_BESTFRIEND","img/16x16/bestfriend.png",["actorName"]);
      
      public static const BESTFRIENDBREAKUP:NotificationType = new NotificationType("BESTFRIENDBREAKUP","NO_LONGER_BFF","img/48x48/IconExperience/breakupBBF.png",["actorName"]);
      
      public static const FRIENDREFFERED:NotificationType = new NotificationType("FRIENDREFFERED","ACCEPTED_INVITATION","img/32x32/Student High School 1 Check.png",["actorName"]);
      
      public static const PUSH_CONTENT_YOUTUBE:NotificationType = new NotificationType("PUSH_CONTENT_YOUTUBE","CHECK_OUT_COOL_YOUTUBE","img/32x32/YouTubeActivity_32x32.png",[]);
      
      public static const PUSH_CONTENT_MOVIE:NotificationType = new NotificationType("PUSH_CONTENT_MOVIE","CHECK_OUT_COOL_MOVIE","img/48x48/IconExperience/movie.png",[]);
      
      public static const PUSH_CONTENT_SCRAPBLOG:NotificationType = new NotificationType("PUSH_CONTENT_SCRAPBLOG","CHECK_OUT_COOL_ARTBOOK","swf/scrapblog/Butterfly_Icon_20x20.png",[]);
      
      public static const PUSH_CONTENT_LOOK:NotificationType = new NotificationType("PUSH_CONTENT_LOOK","CHECK_OUT_COOL_LOOK","img/32x32/New_Look_activity.png",[]);
      
      public static const PUSH_CONTENT_CLUB:NotificationType = new NotificationType("PUSH_CONTENT_CLUB","CHECK_OUT_COOL_CLUB","swf/clubs/Members.swf",[]);
      
      public static const PUSH_CONTENT_FORUM:NotificationType = new NotificationType("PUSH_CONTENT_FORUM","FORUM","swf/world/frameIcons/forum icon.swf",[]);
      
      public static const PUSH_CONTENT_EMBEDDEDGAMES:NotificationType = new NotificationType("PUSH_CONTENT_EMBEDDEDGAMES","ARCADE_ACTIVITY_TOOLTIP","img/32x32/ArcadeActivity.png",["actorName","title"]);
      
      public static const PUSH_CONTENT_IMAGE_UPLOAD:NotificationType = new NotificationType("PUSH_CONTENT_IMAGE_UPLOAD","CHECK_OUT_COOL_PICTURE","swf/scrapblog/Butterfly_Icon_20x20.png",[]);
      
      public static const SOCIALSHOPPING_INVITE:NotificationType = new NotificationType("SOCIALSHOPPING_INVITE","SHOP_SOCIAL_INVITATION_TOOLTIP","img/32x32/shoppingBag.png",[]);
      
      public static const SOCIALSHOPPING_FRIEND_HAS_RECEIVED_REQUEST:NotificationType = new NotificationType("SOCIALSHOPPING_FRIEND_HAS_RECEIVED_REQUEST","SHOP_SOCIAL_INVITATIONSENT_TOOLTIP","img/32x32/shoppingBagChecked.png",[]);
      
      public static const SOCIALSHOPPING_INVITATION_ACCEPTED:NotificationType = new NotificationType("SOCIALSHOPPING_INVITATION_ACCEPTED","","",[]);
      
      public static const SOCIALSHOPPING_INVITATION_REJECTED:NotificationType = new NotificationType("SOCIALSHOPPING_INVITATION_REJECTED","","",[]);
      
      public static const SOCIALSHOPPING_CONNECTING:NotificationType = new NotificationType("SOCIALSHOPPING_CONNECTING","","",[]);
      
      public static const SOCIALSHOPPING_CONNECTED:NotificationType = new NotificationType("SOCIALSHOPPING_CONNECTED","","",[]);
      
      public static const SOCIALSHOPPING_FRIEND_LEFT:NotificationType = new NotificationType("SOCIALSHOPPING_FRIEND_LEFT","","",[]);
      
      public static const SOCIALSHOPPING_CHANGED_CLOTHES:NotificationType = new NotificationType("SOCIALSHOPPING_CHANGED_CLOTHES","","",[]);
      
      public static const VIP_CELEBRATION:NotificationType = new NotificationType("VIP_CELEBRATION","HAS_JUST_BECOME_VIP_CLICK","swf/world/frameIcons/VIP.swf",["actorName"]);
      
      public static const FAME_WHEEL:NotificationType = new NotificationType("FAME_WHEEL","DIAMONDS_ACTIVITYBAR_FAMEWHEEL_TOOLTIP","",["amount"]);
      
      public static const FAME_BOOSTER:NotificationType = new NotificationType("FAME_BOOSTER","DIAMONDS_ACTIVITYBAR_FAMEBOOST_TOOLTIP","",[]);
      
      public static const SHOPPING_SPREE:NotificationType = new NotificationType("SHOPPING_SPREE","DIAMONDS_ACTIVITYBAR_SHOPPINGSPREE_TOOLTIP","",[]);
      
      public static const INSTANT_PET_GROW:NotificationType = new NotificationType("INSTANT_PET_GROW","HAS_GROWN_PET","",["actorName"]);
      
      public static const CHANGE_PET:NotificationType = new NotificationType("CHANGE_PET","HAS_CHANGED_PET","",["actorName"]);
      
      public static const SPECIAL_GREETING:NotificationType = new NotificationType("SPECIAL_GREETING","DIAMONDS_ACTIVITYBAR_SPECIAL_GREETING_TOOLTIP","",["actorName","friendName"]);
      
      public static const STARCOIN_SHOOTER:NotificationType = new NotificationType("STARCOIN_SHOOTER","DIAMONDS_ACTIVITYBAR_STARCOIN_SHOOTER_TOOLTIP","",["actorName","roomName"]);
      
      public static const BOUGHT_DIAMONDSKIN:NotificationType = new NotificationType("BOUGHT_DIAMONDSKIN","DIAMONDS_ACTIVITYBAR_DIAMONDSKIN_TOOLTIP","",["actorName"]);
      
      public static const DIAMOND_CHARACTER_EFFECT:NotificationType = new NotificationType("DIAMOND_CHARACTER_EFFECT","DIAMONDS_SHOP_SPECIALS_SPECIALEFFECT_TOOLTIP","",["actorName"]);
      
      public static const REDEEM_MAGAZINE:NotificationType = new NotificationType("REDEEM_MAGAZINE","MAGAZINE_REDEEM_ACTIVITY","",["actorName"]);
      
      public static const INVITATION_TO_MY_ROOM_ACCEPTED:NotificationType = new NotificationType("INVITATION_TO_MY_ROOM_ACCEPTED","","",[]);
      
      public static const BIO_UPDATE:NotificationType = new NotificationType("BIO_UPDATE","PROFILE_BIO_ACTIVITY_UPDATE","",["actorName"]);
      
      public static const RECEIVE_INVITE_BONUS:NotificationType = new NotificationType("RECEIVE_INVITE_BONUS","","",[]);
      
      public static const ACHIEVEMENT:NotificationType = new NotificationType("ACHIEVEMENT","ACHIEVEMENTS_TOOLTIP","",["actorName"]);
      
      private var _type:String;
      
      private var _icon:String;
      
      private var _locale:String;
      
      private var _localeParams:Array;
      
      public function NotificationType(param1:String, param2:String, param3:String, param4:Array)
      {
         super();
         allItems.push(this);
         this._type = param1;
         this._icon = param3;
         this._localeParams = param4;
         this._locale = param2;
      }
      
      public static function typeByTypeStr(param1:String) : NotificationType
      {
         var _loc2_:NotificationType = null;
         for each(_loc2_ in allItems)
         {
            if(_loc2_._type == param1)
            {
               return _loc2_;
            }
         }
         return createGenericType(param1);
      }
      
      private static function createGenericType(param1:String) : NotificationType
      {
         return new NotificationType(param1,"","",[]);
      }
      
      public function get icon() : String
      {
         return this._icon;
      }
      
      public function get locale() : String
      {
         trace("compiling?");
         return this._locale;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get localeParams() : Array
      {
         return this._localeParams;
      }
   }
}

