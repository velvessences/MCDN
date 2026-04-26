package com.moviestarplanet.chatutils.notifications
{
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.notifications.model.NotificationObject;
   import flash.utils.Dictionary;
   
   public class NotificationLocales
   {
      
      private static var _instance:NotificationLocales;
      
      private static const PARAM_ACTOR_NAME:String = "PARAM_ACTOR_NAME";
      
      private static const PARAM_PASSED_TO_HELPER:String = "PARAM_PASSED_TO_HELPER";
      
      private static const PARAM_CHATROOM_NAME:String = "PARAM_CHATROOM_NAME";
      
      private static const PARAM_ROMANTIC_RELATION:String = "PARAM_ROMANTIC_RELATION";
      
      [Inject]
      public var localeManager:ILocaleManager;
      
      private var noteLocales:Dictionary;
      
      public function NotificationLocales()
      {
         super();
         InjectionManager.manager().injectMe(this);
         this.init();
      }
      
      public static function getInstance() : NotificationLocales
      {
         if(_instance == null)
         {
            _instance = new NotificationLocales();
         }
         return _instance;
      }
      
      public function setLocaleOnNotificationObject(param1:NotificationObject, param2:String = "") : void
      {
         param1.localizedText = this.getLocaleText(param1.notificationTypeId,param1.userName,param2);
      }
      
      public function getLocaleText(param1:String, param2:String = "", param3:String = "") : String
      {
         var _loc4_:LocalePair = this.noteLocales[param1];
         if(_loc4_ == null)
         {
            return "";
         }
         var _loc5_:Array = [];
         if(_loc4_.paramKeys != null && _loc4_.paramKeys.length > 0)
         {
            _loc5_ = this.replaceParams(_loc4_.paramKeys,param2,param3);
         }
         return this.localeManager.getString(_loc4_.localeKey,_loc5_);
      }
      
      private function replaceParams(param1:Array, param2:String, param3:String) : Array
      {
         var _loc5_:String = null;
         var _loc4_:Array = new Array();
         for each(_loc5_ in param1)
         {
            if(_loc5_ == PARAM_ACTOR_NAME)
            {
               _loc4_.push(param2);
            }
            else
            {
               _loc4_.push(param3);
            }
         }
         return _loc4_;
      }
      
      public function init() : void
      {
         this.noteLocales = new Dictionary();
         this.noteLocales["PLAYLIST_LIKE"] = new LocalePair("HAS_LIKED_PLAYLIST",[PARAM_ACTOR_NAME]);
         this.noteLocales["FRIENDREFFERED"] = new LocalePair("ACCEPTED_INVITATION",[PARAM_ACTOR_NAME]);
         this.noteLocales["ACHIEVEMENT"] = new LocalePair("ACHIEVEMENTS_TOOLTIP",[PARAM_ACTOR_NAME]);
         this.noteLocales["PUSH_CONTENT_EMBEDDEDGAMES"] = new LocalePair("ARCADE_ACTIVITY_TOOLTIP",[PARAM_ACTOR_NAME,PARAM_PASSED_TO_HELPER]);
         this.noteLocales["PUSH_CONTENT_SCRAPBLOG"] = new LocalePair("CHECK_OUT_COOL_ARTBOOK",[]);
         this.noteLocales["PUSH_CONTENT_CLUB"] = new LocalePair("CHECK_OUT_COOL_CLUB",[]);
         this.noteLocales["PUSH_CONTENT_LOOK"] = new LocalePair("CHECK_OUT_COOL_LOOK",[]);
         this.noteLocales["PUSH_CONTENT_MOVIE"] = new LocalePair("CHECK_OUT_COOL_MOVIE",[]);
         this.noteLocales["PUSH_CONTENT_IMAGE_UPLOAD"] = new LocalePair("CHECK_OUT_COOL_PICTURE",[]);
         this.noteLocales["PUSH_CONTENT_YOUTUBE"] = new LocalePair("CHECK_OUT_COOL_YOUTUBE",[]);
         this.noteLocales["FAME_BOOSTER"] = new LocalePair("DIAMONDS_ACTIVITYBAR_FAMEBOOST_TOOLTIP",[]);
         this.noteLocales["FAME_WHEEL"] = new LocalePair("DIAMONDS_ACTIVITYBAR_FAMEWHEEL_TOOLTIP",[PARAM_PASSED_TO_HELPER]);
         this.noteLocales["SHOPPING_SPREE"] = new LocalePair("DIAMONDS_ACTIVITYBAR_SHOPPINGSPREE_TOOLTIP",[]);
         this.noteLocales["SPECIAL_GREETING"] = new LocalePair("DIAMONDS_ACTIVITYBAR_SPECIAL_GREETING_TOOLTIP",[PARAM_ACTOR_NAME,PARAM_PASSED_TO_HELPER]);
         this.noteLocales["STARCOIN_SHOOTER"] = new LocalePair("DIAMONDS_ACTIVITYBAR_STARCOIN_SHOOTER_TOOLTIP",[PARAM_ACTOR_NAME,PARAM_PASSED_TO_HELPER]);
         this.noteLocales["DIAMOND_CHARACTER_EFFECT"] = new LocalePair("DIAMONDS_SHOP_SPECIALS_SPECIALEFFECT_TOOLTIP",[PARAM_ACTOR_NAME]);
         this.noteLocales["PUSH_CONTENT_FORUM"] = new LocalePair("FORUM",[]);
         this.noteLocales["AUTOGRAPH"] = new LocalePair("GAVE_AUTOGRAPH",[PARAM_ACTOR_NAME]);
         this.noteLocales["HUG"] = new LocalePair("GAVE_HUG",[]);
         this.noteLocales["RBP_XP_GIFT"] = new LocalePair("GAVE_RBP_XP_GIFT",[]);
         this.noteLocales["GIFT"] = new LocalePair("GOT_GIFT",[PARAM_ACTOR_NAME]);
         this.noteLocales["CONTESTJOINED"] = new LocalePair("HAN_ENTERED_CONTEST",[PARAM_ACTOR_NAME]);
         this.noteLocales["FRIENDACCEPT"] = new LocalePair("HAS_ACCEPTED",[PARAM_ACTOR_NAME]);
         this.noteLocales["BESTFRIENDACCEPT"] = new LocalePair("HAS_ACCEPTED_BESTFRIEND",[PARAM_ACTOR_NAME]);
         this.noteLocales["BOYFRIENDACCEPT"] = new LocalePair("HAS_ACCEPTED_GIRL",[PARAM_ACTOR_NAME,PARAM_ROMANTIC_RELATION]);
         this.noteLocales["GUESTBOOK"] = new LocalePair("HAS_ADDED_GUESTBOOK",[PARAM_ACTOR_NAME]);
         this.noteLocales["MYLOOK_BUY"] = new LocalePair("HAS_BOUGHT_LOOK",[PARAM_ACTOR_NAME]);
         this.noteLocales["BREAKUP"] = new LocalePair("HAS_BROKEN_UP",[PARAM_ACTOR_NAME]);
         this.noteLocales["CLOTHES"] = new LocalePair("HAS_CHANGED_CLOTHES",[PARAM_ACTOR_NAME]);
         this.noteLocales["SKIN"] = new LocalePair("HAS_CHANGED_CLOTHES",[PARAM_ACTOR_NAME]);
         this.noteLocales["CHANGE_PET"] = new LocalePair("HAS_CHANGED_PET",[PARAM_ACTOR_NAME]);
         this.noteLocales["INSTANT_PET_GROW"] = new LocalePair("HAS_GROWN_PET",[PARAM_ACTOR_NAME]);
         this.noteLocales["LEVEL"] = new LocalePair("HAS_HIGHER_LEVEL",[PARAM_ACTOR_NAME]);
         this.noteLocales["FRIENDREQ"] = new LocalePair("HAS_INVITED_FRIENDS",[PARAM_ACTOR_NAME]);
         this.noteLocales["VIP_CELEBRATION"] = new LocalePair("HAS_JUST_BECOME_VIP_CLICK",[PARAM_ACTOR_NAME]);
         this.noteLocales["SCRAPBLOG_LIKE"] = new LocalePair("HAS_LIKED_ARTBOOK",[PARAM_ACTOR_NAME]);
         this.noteLocales["MYLOOK_LIKE"] = new LocalePair("HAS_LIKED_LOOK",[PARAM_ACTOR_NAME]);
         this.noteLocales["PHOTO_LIKE"] = new LocalePair("HAS_LIKED_PHOTO",[PARAM_ACTOR_NAME,PARAM_CHATROOM_NAME]);
         this.noteLocales["MYROOM_LIKE"] = new LocalePair("HAS_LIKED_ROOM",[PARAM_ACTOR_NAME]);
         this.noteLocales["MOVIERATED"] = new LocalePair("HAS_RATED_CLICK",[PARAM_ACTOR_NAME]);
         this.noteLocales["HAS_RATED_YOUR_MOVIE"] = new LocalePair("HAS_RATED_YOUR_MOVIE",[PARAM_ACTOR_NAME]);
         this.noteLocales["PROFILE"] = new LocalePair("HAS_UPDATED_PROFILE",[PARAM_ACTOR_NAME]);
         this.noteLocales["MYROOM"] = new LocalePair("HAS_UPDATED_ROOM",[PARAM_ACTOR_NAME]);
         this.noteLocales["HAS_WATCHED_YOUR_MOVIE"] = new LocalePair("HAS_WATCHED_YOUR_MOVIE",[PARAM_ACTOR_NAME]);
         this.noteLocales["YOUTUBE_NEW"] = new LocalePair("I_ADDED_THIS_VIDEO",[]);
         this.noteLocales["SCRAPBLOG_SAVE"] = new LocalePair("I_CREATED_THIS_ARTBOOK",[]);
         this.noteLocales["MYLOOK"] = new LocalePair("I_CREATED_THIS_LOOK",[]);
         this.noteLocales["MOVIE"] = new LocalePair("I_CREATED_THIS_MOVIE",[]);
         this.noteLocales["INVITETOCHATROOM"] = new LocalePair("INVITED_TO_ROOM",[PARAM_ACTOR_NAME,PARAM_CHATROOM_NAME]);
         this.noteLocales["CHATROOM"] = new LocalePair("IS_IN_THE",[PARAM_ACTOR_NAME,PARAM_CHATROOM_NAME]);
         this.noteLocales["INVITATIONBONUS"] = new LocalePair("NEW_RECIEVED_INVITATION_BONUS",[PARAM_ACTOR_NAME]);
         this.noteLocales["BESTFRIENDBREAKUP"] = new LocalePair("NO_LONGER_BFF",[PARAM_ACTOR_NAME]);
         this.noteLocales["MINIGAMEINVITE"] = new LocalePair("PRIVATE_MINIGAME_CREATED_TOOLTIP",[PARAM_ACTOR_NAME,PARAM_PASSED_TO_HELPER]);
         this.noteLocales["BIO_UPDATE"] = new LocalePair("PROFILE_BIO_ACTIVITY_UPDATE",[PARAM_ACTOR_NAME]);
         this.noteLocales["POST_ON_OTHER_WALL"] = new LocalePair("PROFILE_WALL_POST_NOTIFICATION",[PARAM_ACTOR_NAME]);
         this.noteLocales["POST_ON_YOUR_WALL"] = new LocalePair("PROFILE_WALL_POST_OTHERS",[PARAM_ACTOR_NAME]);
         this.noteLocales["SOCIALSHOPPING_INVITE"] = new LocalePair("SHOP_SOCIAL_INVITATION_TOOLTIP",[]);
         this.noteLocales["SOCIALSHOPPING_FRIEND_HAS_RECEIVED_REQUEST"] = new LocalePair("SHOP_SOCIAL_INVITATIONSENT_TOOLTIP",[]);
         this.noteLocales["TRADE_COMPLETED"] = new LocalePair("TRADE_ACTIVITY_COMPLETED",[]);
         this.noteLocales["TRADE"] = new LocalePair("TRADE_ACTIVITY_REQUEST",[PARAM_ACTOR_NAME]);
         this.noteLocales["BESTFRIENDREQ"] = new LocalePair("WANTS_TO_BE_BESTFRIEND",[PARAM_ACTOR_NAME]);
         this.noteLocales["BOYFRIENDREQ"] = new LocalePair("WANTS_TO_BE_GIRLFRIEND",[PARAM_ACTOR_NAME,PARAM_ROMANTIC_RELATION]);
         this.noteLocales["ISWRITING"] = new LocalePair("WRITING_LOCALE",[]);
         this.noteLocales["BOUGHT_DIAMONDSKIN"] = new LocalePair("DIAMONDS_ACTIVITYBAR_DIAMONDSKIN_TOOLTIP",[PARAM_ACTOR_NAME]);
         this.noteLocales["REDEEM_MAGAZINE"] = new LocalePair("MAGAZINE_REDEEM_ACTIVITY",[PARAM_ACTOR_NAME]);
         this.noteLocales["STOPPEDWRITING"] = new LocalePair("STOPPED_WRITING_LOCALE",[]);
      }
   }
}

