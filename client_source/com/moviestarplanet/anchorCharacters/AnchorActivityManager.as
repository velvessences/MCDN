package com.moviestarplanet.anchorCharacters
{
   import com.moviestarplanet.anchorCharacters.service.AMFSponsoredCharacterService;
   import com.moviestarplanet.anchorCharacters.service.AMFSponsoredCharacterServiceMobile;
   import com.moviestarplanet.anchorCharacters.valueobjects.AnchorCharacterActivityVO;
   import com.moviestarplanet.anchorCharacters.valueobjects.AnchorCharacterInfoVO;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.model.friends.IFriendList;
   import com.moviestarplanet.model.notification.Notification;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.notification.INotificationObject;
   import com.moviestarplanet.notifications.model.NotificationEntityObject;
   import com.moviestarplanet.notifications.model.NotificationObject;
   import flash.utils.setTimeout;
   
   public class AnchorActivityManager
   {
      
      private static var anchorId:int;
      
      private static var name:String;
      
      private static var isFemale:Boolean;
      
      private static var _sponsoredFriendRequests:Array;
      
      private static var _sponsoredFriendReactivations:Array;
      
      private static var _afterSponsoredReactivationCallback:Function;
      
      private static const LOOK:int = 1;
      
      private static const MOVIE:int = 3;
      
      private static const ARTBOOK:int = 7;
      
      public static const MOVIESTAR:int = 8;
      
      private static const WAYD:int = 13;
      
      private static const IMAGE_UPLOAD:int = 28;
      
      private static const TIME_BEFORE_ACTIVITY_IS_SHOWN:int = 60 * 1000 * 2;
      
      public static const MOBILE_ANCHOR_LOGGED_ON:String = "MOBILE_ANCHOR_LOGGED_ON";
      
      public static const MOBILE_ANCHOR_LOGGED_OFF:String = "MOBILE_ANCHOR_LOGGED_OFF";
      
      public static const MOBILE_ANCHOR_EVENT:String = "MOBILE_ANCHOR_EVENT";
      
      public static const MOBILE_SPCHAR_FRIEND_REQUEST:String = "MOBILE_SPCHAR_FRIEND_REQUEST";
      
      public static const MOBILE_SPCHAR_FRIEND_REQUEST_BUNDLE:String = "MOBILE_SPCHAR_FRIEND_REQUEST_BUNDLE";
      
      public static const SPCHAR_FRIEND_REACTIVATION_BUNDLE:String = "SPCHAR_FRIEND_REACTIVATION_BUNDLE";
      
      private static var isOnMobile:Boolean = false;
      
      private static var _hasShownSponsoredFriendRequests:Boolean = false;
      
      public static var isAnchorAdded:Boolean = false;
      
      private static var waitingCallbacks:Array = new Array();
      
      private static var _sendSponsoredFriendReqsAllowed:Boolean = false;
      
      public function AnchorActivityManager()
      {
         super();
      }
      
      public static function loginAnchorMobile(param1:Boolean) : void
      {
         if(isAnchorAdded)
         {
            return;
         }
         setupAnchorData(param1);
         var _loc2_:SnapshotUrl = new SnapshotUrl(anchorId,MOVIESTAR,"moviestar");
         var _loc3_:Object = {
            "actorId":anchorId,
            "name":name,
            "snapshot":_loc2_.toString()
         };
         isOnMobile = true;
         isAnchorAdded = true;
         MessageCommunicator.send(new MsgEvent(MOBILE_ANCHOR_LOGGED_ON,_loc3_));
         onAnchorAdded();
      }
      
      public static function loginAnchor(param1:Boolean) : void
      {
         if(isAnchorAdded)
         {
            return;
         }
         setupAnchorData(param1);
         var _loc2_:INotificationObject = NotificationObject.create(anchorId,name,NotificationType.FRIENDCONNECTED.type,"APPLICATION_WEB");
         var _loc3_:Notification = Notification.generateMyNotification(NotificationType.FRIENDCONNECTED,anchorId);
         _loc3_.notificationObject = _loc2_;
         isOnMobile = false;
         isAnchorAdded = true;
         MessageCommunicator.send(new MsgEvent(MSPEvent.NOTIFICATION_ATIVATED,_loc3_));
         onAnchorAdded();
      }
      
      public static function logOutSpecialCharacter(param1:int) : void
      {
         var _loc2_:INotificationObject = NotificationObject.create(param1,"",NotificationType.DELETE_FRIEND.type,"APPLICATION_WEB");
         var _loc3_:Notification = Notification.generateMyNotification(NotificationType.DELETE_FRIEND,param1);
         _loc3_.notificationObject = _loc2_;
         MessageCommunicator.send(new MsgEvent(MSPEvent.NOTIFICATION_ATIVATED,_loc3_));
      }
      
      public static function logInSpecialCharacters(param1:Array, param2:Boolean = false) : void
      {
         var updateDone:Function = null;
         var list:Array = param1;
         var mobile:Boolean = param2;
         updateDone = function():void
         {
            processSpecialCharacters(list);
         };
         isOnMobile = mobile;
         AnchorCharacters.updateSpCharListCache(updateDone);
      }
      
      private static function processSpecialCharacters(param1:Array) : void
      {
         var _loc4_:SnapshotUrl = null;
         var _loc5_:Object = null;
         var _loc6_:INotificationObject = null;
         var _loc7_:Notification = null;
         var _loc2_:IFriendList = InjectionManager.manager().getInstance(IFriendList);
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(AnchorCharacters.isSpecialCharacter(param1[_loc3_].actorId) && AnchorCharacters.getSpecialCharacterInfo(param1[_loc3_].actorId).IsOnline)
            {
               if(isOnMobile)
               {
                  _loc4_ = new SnapshotUrl(anchorId,MOVIESTAR,"moviestar");
                  _loc5_ = {
                     "actorId":param1[_loc3_].actorId,
                     "name":param1[_loc3_].name,
                     "snapshot":_loc4_.toString()
                  };
                  MessageCommunicator.send(new MsgEvent(MOBILE_ANCHOR_LOGGED_ON,_loc5_));
               }
               else
               {
                  _loc6_ = NotificationObject.create(param1[_loc3_].actorId,name,NotificationType.FRIENDCONNECTED.type,"APPLICATION_WEB");
                  _loc7_ = Notification.generateMyNotification(NotificationType.FRIENDCONNECTED,param1[_loc3_].actorId);
                  _loc7_.notificationObject = _loc6_;
                  MessageCommunicator.send(new MsgEvent(MSPEvent.NOTIFICATION_ATIVATED,_loc7_));
               }
               _loc2_.setOnlineStatus(param1[_loc3_].actorId,"APPLICATION_WEB");
            }
            _loc3_++;
         }
         onAnchorAdded();
      }
      
      public static function friendRequestAnchor(param1:Boolean) : void
      {
         setupAnchorData(param1);
         var _loc2_:INotificationObject = NotificationObject.create(anchorId,name,NotificationType.FRIENDREQ.type,"APPLICATION_WEB");
         var _loc3_:Notification = Notification.generateMyNotification(NotificationType.FRIENDREQ,anchorId);
         _loc3_.notificationObject = _loc2_;
         isOnMobile = false;
         MessageCommunicator.send(new MsgEvent(MSPEvent.NOTIFICATION_ATIVATED,_loc3_));
      }
      
      private static function setupAnchorData(param1:Boolean) : void
      {
         isFemale = param1;
         anchorId = AnchorCharacters.getMyAnchorId(param1);
         name = AnchorCharacters.getNameForId(anchorId);
      }
      
      private static function onAnchorAdded() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in waitingCallbacks)
         {
            _loc1_.callback();
         }
         waitingCallbacks = new Array();
      }
      
      public static function tellMeWhenAnchorAdded(param1:Function, param2:int, param3:String = "") : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Object = null;
         if(isAnchorAdded)
         {
            param1();
         }
         else
         {
            for each(_loc5_ in waitingCallbacks)
            {
               if(_loc5_.actorId == param2 && _loc5_.type == param3)
               {
                  _loc4_ = true;
                  break;
               }
            }
            if(!_loc4_)
            {
               waitingCallbacks.push({
                  "actorId":param2,
                  "callback":param1,
                  "type":param3
               });
            }
         }
      }
      
      public static function reset() : void
      {
         waitingCallbacks = new Array();
         isAnchorAdded = false;
      }
      
      public static function get activeAnchorId() : int
      {
         return anchorId;
      }
      
      public static function get activeAnchorName() : String
      {
         return name;
      }
      
      public static function setSpCharFriendReactivationData(param1:Array) : void
      {
         var _loc2_:Object = null;
         _sponsoredFriendReactivations = param1;
         if(_afterSponsoredReactivationCallback != null)
         {
            _loc2_ = {
               "array":_sponsoredFriendReactivations,
               "callback":_afterSponsoredReactivationCallback
            };
            MessageCommunicator.send(new MsgEvent(SPCHAR_FRIEND_REACTIVATION_BUNDLE,_loc2_));
            _afterSponsoredReactivationCallback = null;
         }
      }
      
      public static function setSpCharFriendRequestData(param1:Array) : void
      {
         _sponsoredFriendRequests = param1;
         if(_sendSponsoredFriendReqsAllowed)
         {
            sendSponsoredCharacterFriendRequests();
         }
      }
      
      public static function checkForSponsoredCharacterFriendRequests() : void
      {
         _sendSponsoredFriendReqsAllowed = true;
         if(_sponsoredFriendRequests)
         {
            sendSponsoredCharacterFriendRequests();
         }
      }
      
      private static function sendSponsoredCharacterFriendRequests() : void
      {
         var afterUpdate:Function = null;
         afterUpdate = function():void
         {
            var _loc1_:Array = null;
            var _loc2_:int = 0;
            if(_sponsoredFriendRequests != null && _sponsoredFriendRequests.length > 0)
            {
               _loc1_ = new Array();
               for each(_loc2_ in _sponsoredFriendRequests)
               {
                  _loc1_.push(AnchorCharacters.getSpecialCharacterInfo(_loc2_));
               }
               if(isOnMobile)
               {
                  MessageCommunicator.send(new MsgEvent(MOBILE_SPCHAR_FRIEND_REQUEST_BUNDLE,_loc1_));
               }
               else
               {
                  handleSponsCharFriendRequestsWeb(_loc1_);
               }
            }
         };
         if(_hasShownSponsoredFriendRequests)
         {
            return;
         }
         _hasShownSponsoredFriendRequests = true;
         MessageCommunicator.subscribe(MSPEvent.DO_LOGOUT,onLoggedOut);
         AnchorCharacters.updateSpCharListCache(afterUpdate);
      }
      
      private static function onLoggedOut(param1:MsgEvent) : void
      {
         _sponsoredFriendRequests = null;
         _sendSponsoredFriendReqsAllowed = false;
         _hasShownSponsoredFriendRequests = false;
         MessageCommunicator.unscribe(MSPEvent.DO_LOGOUT,onLoggedOut);
      }
      
      public static function checkForReactivatedSponsoredCharacters(param1:Function) : void
      {
         var afterUpdate:Function = null;
         var callback:Function = param1;
         afterUpdate = function():void
         {
            var _loc1_:Object = null;
            if(_sponsoredFriendReactivations == null)
            {
               _afterSponsoredReactivationCallback = callback;
            }
            else
            {
               _loc1_ = {
                  "array":_sponsoredFriendReactivations,
                  "callback":callback
               };
               MessageCommunicator.send(new MsgEvent(SPCHAR_FRIEND_REACTIVATION_BUNDLE,_loc1_));
            }
         };
         AnchorCharacters.updateSpCharListCache(afterUpdate);
      }
      
      private static function handleSponsCharFriendRequestsWeb(param1:Array) : void
      {
         var sfri:AnchorCharacterInfoVO = null;
         var sendSponsFriendRequest:Function = null;
         var sponsFriendReqInfo:Array = param1;
         sendSponsFriendRequest = function():void
         {
            var _loc2_:int = int(arguments[0]);
            var _loc3_:String = arguments[1];
            if(isFriendsWith(_loc2_))
            {
               return;
            }
            new AMFSponsoredCharacterService().updateLastInviteSent(_loc2_);
            var _loc4_:INotificationObject = NotificationObject.create(_loc2_,_loc3_,NotificationType.FRIENDREQ.type,"APPLICATION_WEB");
            var _loc5_:Notification = Notification.generateMyNotification(NotificationType.FRIENDREQ,anchorId);
            _loc5_.notificationObject = _loc4_;
            MessageCommunicator.send(new MsgEvent(MSPEvent.NOTIFICATION_ATIVATED,_loc5_));
         };
         var delay:int = 0;
         for each(sfri in sponsFriendReqInfo)
         {
            setTimeout(sendSponsFriendRequest,delay,sfri.ActorId,sfri.Name);
            delay += 120000;
         }
      }
      
      private static function isFriendsWith(param1:int) : Boolean
      {
         var _loc5_:IFriend = null;
         var _loc2_:IFriendList = InjectionManager.manager().getInstance(IFriendList);
         var _loc3_:int = int(_loc2_.friendList.length);
         var _loc4_:Vector.<IFriend> = _loc2_.friendList;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = _loc4_[_loc6_];
            if(_loc5_.userId == param1)
            {
               return true;
            }
            _loc6_++;
         }
         return false;
      }
      
      public static function checkSpecialCharacterActivities(param1:Array) : void
      {
         var _loc3_:AnchorCharacterActivityVO = null;
         if(param1.length == 0)
         {
            return;
         }
         var _loc2_:int = TIME_BEFORE_ACTIVITY_IS_SHOWN;
         for each(_loc3_ in param1)
         {
            setTimeout(checkAnchorActivities,_loc2_,_loc3_.ActivityType,_loc3_.ActivityId,_loc3_.ActivityText,_loc3_.ActorId);
            _loc2_ += TIME_BEFORE_ACTIVITY_IS_SHOWN;
         }
      }
      
      private static function checkAnchorActivities() : void
      {
         var _loc2_:int = int(arguments[0]);
         var _loc3_:int = int(arguments[1]);
         var _loc4_:String = arguments[2];
         var _loc5_:int = int(arguments[3]);
         if(isOnMobile == false && (arguments[0] == -1 || isAnchorAdded == false))
         {
            return;
         }
         switch(_loc2_)
         {
            case ARTBOOK:
               AnchorCreateArtbook(_loc3_,_loc5_);
               break;
            case MOVIE:
               AnchorCreateMovie(_loc3_,_loc5_);
               break;
            case LOOK:
               AnchorCreateLook(_loc3_,_loc5_);
               break;
            case IMAGE_UPLOAD:
               AnchorCreatePhoto(_loc3_,_loc4_,_loc5_);
               break;
            case WAYD:
               AnchorCreateWAYD(_loc4_,_loc5_);
         }
      }
      
      public static function AnchorCreateArtbook(param1:int, param2:int) : void
      {
         sendContentEvent(param2,NotificationType.SCRAPBLOG_SAVE,param1,ARTBOOK,"scrapblog");
      }
      
      public static function AnchorCreateLook(param1:int, param2:int) : void
      {
         sendContentEvent(param2,NotificationType.MYLOOK,param1,LOOK,"look");
      }
      
      public static function AnchorCreateMovie(param1:int, param2:int) : void
      {
         sendContentEvent(param2,NotificationType.MOVIE,param1,MOVIE,"movie");
      }
      
      public static function AnchorCreatePhoto(param1:int, param2:String, param3:int) : void
      {
         sendContentEvent(param3,NotificationType.PUSH_CONTENT_IMAGE_UPLOAD,param1,IMAGE_UPLOAD,"pictureUpload",param2);
      }
      
      public static function AnchorCreateWAYD(param1:String, param2:int) : void
      {
         var _loc3_:String = isFemale ? "girl pose" : "boy pose";
         var _loc4_:Object = {
            "actorId":param2,
            "animation":_loc3_,
            "diamond":false,
            "faceExpr":"neutral",
            "clickItem":"none",
            "text":param1,
            "type":"TWIT",
            "userName":name,
            "userBehaviorResult":{
               "blacklistedMessage":param1,
               "isSafe":true,
               "message":param1,
               "whitelistedMessage":param1
            }
         };
         var _loc5_:Notification = Notification.fromObject(_loc4_);
         var _loc6_:NotificationObject = _loc5_.notificationObject as NotificationObject;
         _loc6_.localizedText = param1;
         if(isOnMobile)
         {
            new AMFSponsoredCharacterServiceMobile().updateLastStatusSeen(param2);
            MessageCommunicator.send(new MsgEvent(MOBILE_ANCHOR_EVENT,_loc5_));
         }
         else
         {
            new AMFSponsoredCharacterService().updateLastStatusSeen(param2);
            MessageCommunicator.send(new MsgEvent(MSPEvent.NOTIFICATION_ATIVATED,_loc5_));
         }
      }
      
      private static function sendContentEvent(param1:int, param2:NotificationType, param3:int, param4:int, param5:String, param6:String = "") : void
      {
         var _loc7_:String = createSubPath(param3,param5,param6,param1);
         var _loc8_:INotificationObject = NotificationEntityObject.create(param1,name,param2.type,param3,param4,_loc7_,"APPLICATION_WEB");
         var _loc9_:Notification = Notification.generateMyNotification(param2,param1);
         _loc9_.notificationObject = _loc8_;
         if(isOnMobile)
         {
            new AMFSponsoredCharacterServiceMobile().updateLastStatusSeen(param1);
            MessageCommunicator.send(new MsgEvent(MOBILE_ANCHOR_EVENT,_loc9_));
         }
         else
         {
            new AMFSponsoredCharacterService().updateLastStatusSeen(param1);
            MessageCommunicator.send(new MsgEvent(MSPEvent.NOTIFICATION_ATIVATED,_loc9_));
         }
      }
      
      private static function createSubPath(param1:int, param2:String, param3:String, param4:int) : String
      {
         if(param3 == "")
         {
            return param2 + "_" + SnapshotUrl.fileNameFromIds([param1]) + ".jpg";
         }
         return param2 + "_" + SnapshotUrl.fileNameFromIds([param4]) + "_" + param3 + ".jpg";
      }
      
      private static function loginBrandAnchor(param1:int) : void
      {
      }
   }
}

