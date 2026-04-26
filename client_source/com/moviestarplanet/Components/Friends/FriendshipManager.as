package com.moviestarplanet.Components.Friends
{
   import com.moviestarplanet.Components.FriendType;
   import com.moviestarplanet.activities.OldActivityCreator;
   import com.moviestarplanet.chat.ChatChannel;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.chatutils.notifications.NotificationLocales;
   import com.moviestarplanet.configurations.FeatureToggle;
   import com.moviestarplanet.constants.friendship.ConstantsRelationshipStatus;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.friends.FriendsManager;
   import com.moviestarplanet.friendship.service.FriendshipServiceWeb;
   import com.moviestarplanet.friendship.valueobjects.AcceptToBeMySpecialFriendArgs;
   import com.moviestarplanet.friendship.valueobjects.ActorSpecialRelationshipStatus;
   import com.moviestarplanet.friendship.valueobjects.AskToBeMySpecialFriendArgs;
   import com.moviestarplanet.friendship.valueobjects.RejectMySpecialFriendArgs;
   import com.moviestarplanet.games.EmbeddedGames.EmbeddedGamesModuleManager;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.model.notification.Notification;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationChannel;
   import com.moviestarplanet.notification.INotificationObject;
   import com.moviestarplanet.notification.INotificationSystemMessageObject;
   import com.moviestarplanet.notifications.model.NotificationAppearanceObject;
   import com.moviestarplanet.notifications.model.NotificationEntityObject;
   import com.moviestarplanet.notifications.model.NotificationLegacyObject;
   import com.moviestarplanet.notifications.model.NotificationObject;
   import com.moviestarplanet.platform.ApplicationId;
   import com.moviestarplanet.service.PushNotificationsAMFServiceWeb;
   import com.moviestarplanet.utils.GiftCategories;
   import com.moviestarplanet.utils.sound.Sounds;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import com.moviestarplanet.windowpopup.popup.PromptEvent;
   import flash.net.SharedObject;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mx.controls.Alert;
   
   public class FriendshipManager
   {
      
      private static var _instance:FriendshipManager;
      
      public static const MAX_NUM_BESTFRIENDS:int = 3;
      
      public static const BREAKUP:String = "BREAKUP";
      
      public static const FRIENDACCEPT:String = "FRIENDACCEPT";
      
      public static const FRIENDREJECT:String = "FRIENDREJECT";
      
      public static const FRIENDREQ:String = "FRIENDREQ";
      
      public static const BOYFRIENDACCEPT:String = "BOYFRIENDACCEPT";
      
      public static const BOYFRIENDREJECT:String = "BOYFRIENDREJECT";
      
      public static const BOYFRIENDREQ:String = "BOYFRIENDREQ";
      
      public static const BESTFRIENDBREAKUP:String = "BESTFRIENDBREAKUP";
      
      public static const BESTFRIENDACCEPT:String = "BESTFRIENDACCEPT";
      
      public static const BESTFRIENDREJECT:String = "BESTFRIENDREJECT";
      
      public static const BESTFRIENDREQ:String = "BESTFRIENDREQ";
      
      public static const ACCEPTBESTFRIEND:String = "ACCEPTBESTFRIEND";
      
      public static const REJECTBESTFRIEND:String = "REJECTBESTFRIEND";
      
      public static const ACCEPTBOYFRIEND:String = "ACCEPTBOYFRIEND";
      
      public static const REJECTBOYFRIEND:String = "REJECTBOYFRIEND";
      
      public static const ACCEPTFRIENDSHIP:String = "ACCEPTFRIENDSHIP";
      
      public static const REJECTFRIENDSHIP:String = "REJECTFRIENDSHIP";
      
      public static const STOPFRIENDSHIP:String = "STOPFRIENDSHIP";
      
      public static const REQUESTFRIENDSHIP:String = "REQUESTFRIENDSHIP";
      
      private var friendRequestOnlineTimerList:Object;
      
      private const IS_ONLINE_TIMEOUT:Number = 10000;
      
      [Inject]
      public var notificationChannel:INotificationChannel;
      
      [Inject]
      public var chatChannel:ChatChannel;
      
      private var sharedObjectInvitationBonus:SharedObject;
      
      private var _lastActivityType:String = "";
      
      public function FriendshipManager(param1:Class)
      {
         super();
         if(param1 != SingletonBlocker)
         {
            throw new Error("FriendsMFriendshipManageranager is a singleton class, use FriendshipManager.getInstance instead!");
         }
         InjectionManager.manager().injectMe(this);
         this.friendRequestOnlineTimerList = new Object();
         MessageCommunicator.subscribe(MSPEvent.NOTIFICATION_ATIVATED,this.onNotificationReceived);
      }
      
      public static function getInstance() : FriendshipManager
      {
         if(_instance == null)
         {
            _instance = new FriendshipManager(SingletonBlocker);
         }
         return _instance;
      }
      
      public function DispatchFriendRejectEvent(param1:Number) : void
      {
         MessageCommunicator.sendMessage(FRIENDREJECT,param1);
      }
      
      public function DispatchBoyFriendRejectEvent(param1:Number) : void
      {
         MessageCommunicator.sendMessage(BOYFRIENDREJECT,param1);
      }
      
      public function DispatchBestFriendRejectEvent(param1:Number) : void
      {
         MessageCommunicator.sendMessage(BESTFRIENDREJECT,param1);
      }
      
      public function FriendRequest(param1:Number) : void
      {
         MessageCommunicator.sendMessage(FRIENDREQ,param1);
      }
      
      public function BestFriendRequest(param1:Number) : void
      {
         MessageCommunicator.sendMessage(BESTFRIENDREQ,param1);
      }
      
      public function BoyFriendRequest(param1:Number) : void
      {
         MessageCommunicator.sendMessage(BOYFRIENDREQ,param1);
      }
      
      public function FriendAccepted(param1:int) : void
      {
         var done:Function = null;
         var friendID:int = param1;
         done = function():void
         {
            MessageCommunicator.sendMessage(FRIENDACCEPT,friendID);
         };
         ActorReload.getInstance().requestReload(done);
      }
      
      public function BoyFriendAccepted(param1:int, param2:String, param3:int, param4:Boolean) : void
      {
         var done:Function = null;
         var boyfriendId:int = param1;
         var boyFriendName:String = param2;
         var boyfriendLevel:int = param3;
         var isVip:Boolean = param4;
         done = function():void
         {
            MessageCommunicator.sendMessage(BOYFRIENDACCEPT,boyfriendId);
         };
         if(!FriendsManager.getInstance().hasFriend(boyfriendId))
         {
            FriendsManager.getInstance().addFriend(ActorSession.getActorId(),boyfriendId,boyFriendName,true,boyfriendLevel,isVip);
         }
         ActorReload.getInstance().requestReload(done);
      }
      
      public function DispatchBoyFriendAcceptEvent(param1:int) : void
      {
         var done:Function = null;
         var idOfActorAccepting:int = param1;
         done = function():void
         {
            MessageCommunicator.sendMessage(BOYFRIENDACCEPT,idOfActorAccepting);
         };
         ActorReload.getInstance().requestReload(done);
      }
      
      public function BestFriendAccepted(param1:int, param2:String, param3:int, param4:Boolean = false) : void
      {
         var done:Function = null;
         var bestfriendId:int = param1;
         var bestFriendName:String = param2;
         var bestfriendLevel:int = param3;
         var isVip:Boolean = param4;
         done = function():void
         {
            MessageCommunicator.sendMessage(BESTFRIENDACCEPT,bestfriendId);
         };
         if(!FriendsManager.getInstance().hasFriend(bestfriendId))
         {
            FriendsManager.getInstance().addFriend(ActorSession.getActorId(),bestfriendId,bestFriendName,true,bestfriendLevel,isVip);
         }
         ActorReload.getInstance().requestReload(done);
      }
      
      private function DispatchBestFriendAcceptEvent(param1:int) : void
      {
         var done:Function = null;
         var idOfActorAccepting:int = param1;
         done = function():void
         {
            SendBestFriendAcceptBack(idOfActorAccepting);
            MessageCommunicator.sendMessage(BESTFRIENDACCEPT,idOfActorAccepting);
         };
         ActorReload.getInstance().requestReload(done);
      }
      
      private function DispatchRelationshipAcceptEvent(param1:int) : void
      {
         var done:Function = null;
         var idOfActorAccepting:int = param1;
         done = function():void
         {
            SendBoyFriendAcceptBack(idOfActorAccepting);
            MessageCommunicator.sendMessage(ACCEPTBOYFRIEND,idOfActorAccepting);
         };
         ActorReload.getInstance().requestReload(done);
      }
      
      public function BreakUp(param1:int) : void
      {
         this.DispatchBreakupEvent(param1);
         var _loc2_:Notification = Notification.generateMyNotification(NotificationType.BREAKUP,ActorSession.getActorId(),ActorSession.actorName);
         this.notificationChannel.sendNotificationToFriend(param1,_loc2_);
      }
      
      public function DispatchBreakupEvent(param1:int) : void
      {
         var done:Function = null;
         var idOftheActorBreakingUpWith:int = param1;
         done = function():void
         {
            MessageCommunicator.sendMessage(BREAKUP,idOftheActorBreakingUpWith);
         };
         ActorReload.getInstance().requestReload(done);
      }
      
      public function BreakUpBestFriend(param1:int) : void
      {
         this.DispatchBreakupBestFriendEvent(param1);
         var _loc2_:Notification = Notification.generateMyNotification(NotificationType.BESTFRIENDBREAKUP,ActorSession.getActorId(),ActorSession.actorName);
         this.notificationChannel.sendNotificationToFriend(param1,_loc2_);
      }
      
      public function DispatchBreakupBestFriendEvent(param1:int) : void
      {
         var done:Function = null;
         var idOftheActorBreakingUpWith:int = param1;
         done = function():void
         {
            MessageCommunicator.sendMessage(BESTFRIENDBREAKUP,idOftheActorBreakingUpWith);
         };
         ActorReload.getInstance().requestReload(done);
      }
      
      public function RequestBoyFriendReturnedFromWebService(param1:Number) : void
      {
         var _loc2_:NotificationObject = this.createBasicNotificationObject("BOYFRIENDREQ");
         if(ActorSession.isFemale)
         {
            _loc2_.localizedText = MSPLocaleManagerWeb.getInstance().getString("WANTS_TO_BE_GIRLFRIEND",[ActorSession.actorName]);
         }
         else
         {
            _loc2_.localizedText = MSPLocaleManagerWeb.getInstance().getString("WANTS_TO_BE_BOYFRIEND",[ActorSession.actorName]);
         }
         var _loc3_:Boolean = FriendsManager.getInstance().hasFriend(param1);
         if(_loc3_)
         {
            this.sendActivityEventToFriend(_loc2_,param1);
         }
         else
         {
            this.sendActivityEventToNonFriend(_loc2_,param1);
         }
      }
      
      public function RequestBestFriendReturnedFromWebService(param1:Number) : void
      {
         var _loc2_:INotificationObject = this.createBasicNotificationObject("BESTFRIENDREQ");
         var _loc3_:Boolean = FriendsManager.getInstance().hasFriend(param1);
         if(_loc3_)
         {
            this.sendActivityEventToFriend(_loc2_,param1);
         }
         else
         {
            this.sendActivityEventToNonFriend(_loc2_,param1);
         }
      }
      
      public function RequestFriendshipReturnedFromWebService(param1:Number) : void
      {
         this.startRequestTimer(param1);
         this.sendActivityEventToNonFriend(this.createBasicNotificationObject("FRIENDREQ"),param1);
      }
      
      private function startRequestTimer(param1:int) : void
      {
         if(this.friendRequestOnlineTimerList[param1])
         {
            return;
         }
         this.friendRequestOnlineTimerList[param1] = setTimeout(this.sendRequestThroughPush,this.IS_ONLINE_TIMEOUT,param1);
      }
      
      private function onNotificationReceived(param1:MsgEvent) : void
      {
         var _loc2_:INotification = param1.data as INotification;
         var _loc3_:int = _loc2_.actorId;
         switch(_loc2_.type)
         {
            case NotificationType.FRIENDREQ_RECEIVED.type:
               if(this.friendRequestOnlineTimerList[_loc3_])
               {
                  clearTimeout(this.friendRequestOnlineTimerList[_loc3_]);
                  delete this.friendRequestOnlineTimerList[_loc3_];
               }
               break;
            case NotificationType.FRIENDREQ.type:
               this.sendActivityEventToNonFriend(this.createBasicNotificationObject(NotificationType.FRIENDREQ_RECEIVED.type),_loc3_);
         }
      }
      
      private function sendRequestThroughPush(param1:int) : void
      {
         delete this.friendRequestOnlineTimerList[param1];
         new PushNotificationsAMFServiceWeb().SendFriendRequest(param1,33);
      }
      
      public function RejectFriendShip(param1:Number) : void
      {
         var done:Function = null;
         var friendId:Number = param1;
         done = function():void
         {
            SendFriendshipRejectBackToFriend(friendId);
            MessageCommunicator.sendMessage(REJECTFRIENDSHIP,friendId);
         };
         new FriendshipServiceWeb().RejectFriendship(ActorSession.getActorId(),friendId,done);
      }
      
      public function StopFriendShip(param1:Number) : void
      {
         var done:Function = null;
         var friendId:Number = param1;
         done = function():void
         {
            RemoveFriendshipOnFriend(friendId);
            StopFriendShipInner(friendId);
         };
         new FriendshipServiceWeb().DeleteFriendship(ActorSession.getActorId(),friendId,done);
      }
      
      public function StopFriendShipInner(param1:int) : void
      {
         FriendsManager.getInstance().removeFriend(param1);
         MessageCommunicator.sendMessage(STOPFRIENDSHIP,param1);
         ActorReload.getInstance().requestReload();
      }
      
      public function sendAcceptBackToFriend(param1:Number, param2:String, param3:Boolean) : void
      {
         var _loc4_:IFriend = FriendsManager.getInstance().getFriend(param1);
         if(_loc4_ == null)
         {
            return;
         }
         this.sendActivityEventToFriend(this.createBasicNotificationObject(param2),param1);
         if(param3)
         {
            OldActivityCreator.getInstance().createActivity(2,0,param1);
         }
      }
      
      public function SendBoyFriendAcceptBack(param1:Number) : void
      {
         var _loc2_:NotificationObject = this.createBasicNotificationObject("BOYFRIENDACCEPT");
         _loc2_.localizedText = MSPLocaleManagerWeb.getInstance().getString("HAS_ACCEPTED_GIRL",[ActorSession.actorName]);
         this.sendActivityEventToFriend(_loc2_,param1);
      }
      
      public function SendBestFriendAcceptBack(param1:Number) : void
      {
         this.sendAcceptBackToFriend(param1,"BESTFRIENDACCEPT",false);
      }
      
      public function SendFriendshipRefferedBackToFriend(param1:Number) : void
      {
         this.sendAcceptBackToFriend(param1,"FRIENDREFFERED",true);
      }
      
      public function SendFriendshipAcceptBackToFriend(param1:Number) : void
      {
         this.sendAcceptBackToFriend(param1,"FRIENDACCEPT",true);
      }
      
      public function SendFriendshipRejectBackToFriend(param1:Number) : void
      {
         this.sendActivityEventToNonFriend(this.createBasicNotificationObject("FRIENDREJECT"),param1);
      }
      
      public function SendBoyFriendshipRejectBackToFriend(param1:int) : void
      {
         if(FriendsManager.getInstance().hasFriend(param1))
         {
            this.sendActivityEventToFriend(this.createBasicNotificationObject("BOYFRIENDREJECT"),param1);
         }
         else
         {
            this.sendActivityEventToNonFriend(this.createBasicNotificationObject("BOYFRIENDREJECT"),param1);
         }
      }
      
      public function SendBestFriendshipRejectBackToFriend(param1:int) : void
      {
         if(FriendsManager.getInstance().hasFriend(param1))
         {
            this.sendActivityEventToFriend(this.createBasicNotificationObject("BESTFRIENDREJECT"),param1);
         }
         else
         {
            this.sendActivityEventToNonFriend(this.createBasicNotificationObject("BESTFRIENDREJECT"),param1);
         }
      }
      
      private function sendActivityEventToFriend(param1:INotificationObject, param2:int) : void
      {
         this.sendNotificationToFriend(param1,param2);
      }
      
      private function sendActivityEventToNonFriend(param1:INotificationObject, param2:int) : void
      {
         var _loc3_:INotification = this.createNotification(param1);
         this.notificationChannel.sendNotificationToNonFriend(param2,_loc3_);
      }
      
      public function sendBasicEventToFriends(param1:String) : void
      {
         this.sendNotificationToFriends(this.createBasicNotificationObject(param1));
      }
      
      public function sendBasicEventToFriend(param1:String, param2:int) : void
      {
         this.sendNotificationToFriend(this.createBasicNotificationObject(param1),param2);
      }
      
      public function sendGiftEventToFriend(param1:int, param2:int) : void
      {
         this.sendNotificationToFriend(this.createGiftNotificationObject(param2),param1);
      }
      
      public function sendAppearanceEventToFriends(param1:String, param2:Object) : void
      {
         this.sendNotificationToFriends(this.createAppearanceNotificationObject(param1,param2));
      }
      
      public function convertLegacyEntityObjectAndSendToFriends(param1:Object) : void
      {
         this.sendNotificationToFriends(this.convertLegacyEntityObject(param1));
      }
      
      public function convertLegacyEntityObjectAndSendToFriend(param1:Object, param2:int) : void
      {
         this.sendNotificationToFriend(this.convertLegacyEntityObject(param1),param2);
      }
      
      private function convertLegacyEntityObject(param1:Object) : INotificationObject
      {
         var _loc2_:NotificationObject = NotificationEntityObject.create(ActorSession.loggedInActor.ActorId,ActorSession.loggedInActor.Name,param1.type,param1.entityId,param1.entityType,param1.entitySnapshot,ApplicationId.APPLICATION_WEB,1);
         if(param1.hasOwnProperty("localizedText"))
         {
            _loc2_.localizedText = param1.localizedText;
         }
         else
         {
            NotificationLocales.getInstance().setLocaleOnNotificationObject(_loc2_);
         }
         return _loc2_;
      }
      
      public function sendLegacyObjectEventToFriend(param1:Object, param2:int) : void
      {
         this.sendNotificationToFriend(this.convertLegacyObject(param1),param2);
      }
      
      public function sendLegacyObjectEventToFriends(param1:Object) : void
      {
         this.sendNotificationToFriends(this.convertLegacyObject(param1));
      }
      
      private function convertLegacyObject(param1:Object) : INotificationObject
      {
         var _loc2_:NotificationObject = NotificationLegacyObject.create(param1);
         _loc2_.userName = ActorSession.actorName;
         return _loc2_;
      }
      
      private function createBasicNotificationObject(param1:String) : NotificationObject
      {
         return NotificationObject.create(ActorSession.loggedInActor.ActorId,ActorSession.loggedInActor.Name,param1);
      }
      
      private function createGiftNotificationObject(param1:int) : NotificationObject
      {
         var _loc2_:NotificationType = NotificationType.GIFT;
         if(param1 == GiftCategories.vip_certificate && FeatureToggle.getFeatureActive(FeatureToggle.EXTENDED_GIFTING))
         {
            _loc2_ = NotificationType.VIP_GIFT;
         }
         return NotificationObject.create(ActorSession.loggedInActor.ActorId,ActorSession.loggedInActor.Name,_loc2_.type);
      }
      
      private function createAppearanceNotificationObject(param1:String, param2:Object) : NotificationObject
      {
         return NotificationAppearanceObject.create(ActorSession.loggedInActor.ActorId,ActorSession.loggedInActor.Name,param1,param2);
      }
      
      private function createNotification(param1:INotificationObject) : INotification
      {
         var _loc2_:Notification = Notification.generateMyNotification(NotificationType.typeByTypeStr(param1.notificationTypeId),param1.userId,ActorSession.actorName);
         _loc2_.notificationObject = param1;
         return _loc2_;
      }
      
      public function sendNotificationToFriend(param1:INotificationObject, param2:int) : void
      {
         this.notificationChannel.sendNotificationToFriend(param2,this.createNotification(param1));
      }
      
      public function sendNotificationToFriends(param1:INotificationObject) : void
      {
         this._lastActivityType = param1.notificationTypeId;
         this.notificationChannel.sendNotificationToOnlineFriends(this.createNotification(param1));
      }
      
      private function sendActivityEventToFriends(param1:INotificationObject) : void
      {
         var _loc2_:INotification = this.createNotification(param1);
         this._lastActivityType = _loc2_.type;
         this.notificationChannel.sendNotificationToOnlineFriends(_loc2_);
      }
      
      public function SendUnblockEvent(param1:Number) : void
      {
         this.sendActivityEventToNonFriend(this.createBasicNotificationObject(NotificationType.UNBLOCKED_BY_USER.type),param1);
      }
      
      public function SendBlockEventToNonFriend(param1:Number) : void
      {
         this.sendActivityEventToNonFriend(this.createBasicNotificationObject(NotificationType.BLOCKED_BY_USER.type),param1);
      }
      
      public function SendInvitationBonusToFriend(param1:Number) : void
      {
         var _loc2_:INotification = null;
         if(FriendsManager.getInstance().hasFriend(param1))
         {
            _loc2_ = Notification.generateMyNotification(NotificationType.RECEIVE_INVITE_BONUS,ActorSession.loggedInActor.ActorId,ActorSession.loggedInActor.Name);
            this.notificationChannel.sendNotificationToFriend(param1,_loc2_);
         }
      }
      
      public function SendAutographEventToNonFriend(param1:Number) : void
      {
         this.sendActivityEventToNonFriend(this.createBasicNotificationObject(NotificationType.AUTOGRAPH_NON_FRIEND.type),param1);
      }
      
      public function sendSystemMessageNotificationToFriend(param1:Number, param2:INotificationSystemMessageObject) : void
      {
         this.chatChannel.sendSystemMessage(param1,param2);
      }
      
      private function playRequestSound() : void
      {
         SoundManager.Instance().playSoundEffect(Sounds.REQUEST_SENT);
      }
      
      public function requestToBe(param1:AskToBeMySpecialFriendArgs, param2:Function) : void
      {
         this.playRequestSound();
         new FriendshipServiceWeb().AskToBeMySpecialFriend(param1,param2);
      }
      
      public function get breakupStringId() : String
      {
         var _loc1_:Boolean = ActorSession.loggedInActor.SkinSWF == "femaleskin";
         var _loc2_:Boolean = ActorSession.loggedInActor.BoyFriend.SkinSWF == "femaleskin";
         if(_loc1_)
         {
            if(_loc2_)
            {
               return "BF_ALREADY_GIRL_GIRL";
            }
            return "BF_ALREADY_GIRL_BOY";
         }
         if(_loc2_)
         {
            return "BF_ALREADY_BOY_GIRL";
         }
         return "BF_ALREADY_BOY_BOY";
      }
      
      public function AcceptBoyfriend(param1:int, param2:Function = null, param3:String = "", param4:int = -1, param5:Boolean = false) : void
      {
         var onClose:Function = null;
         var boyfriendId:int = param1;
         var callBack:Function = param2;
         var boyfriendName:String = param3;
         var boyfriendLevel:int = param4;
         var isVip:Boolean = param5;
         onClose = function(param1:PromptEvent = null):void
         {
            if(param1.detail == Alert.YES)
            {
               doAccept();
               BreakUp(ActorSession.loggedInActor.GetBoyfriendInRelationship().FriendId);
            }
         };
         var doAccept:Function = function():void
         {
            var done:Function = null;
            done = function():void
            {
               if(callBack != null)
               {
                  callBack();
               }
               DispatchRelationshipAcceptEvent(boyfriendId);
            };
            if(!FriendsManager.getInstance().hasFriend(boyfriendId))
            {
               FriendsManager.getInstance().addFriend(ActorSession.getActorId(),boyfriendId,boyfriendName,true,boyfriendLevel,isVip);
            }
            new FriendshipServiceWeb().AcceptBoyfriend(ActorSession.getActorId(),boyfriendId,FriendType.BOYFRIEND,done);
         };
         if(ActorSession.loggedInActor.GetBoyfriendInRelationship() != null && ActorSession.loggedInActor.GetBoyfriendInRelationship().ActorId != boyfriendId)
         {
            if(EmbeddedGamesModuleManager.getInstance().isPlaying)
            {
               EmbeddedGamesModuleManager.getInstance().closeGame();
            }
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString(this.breakupStringId,[ActorSession.loggedInActor.BoyFriend.Name]),MSPLocaleManagerWeb.getInstance().getString("BREAK_UP") + "?",Alert.YES | Alert.NO,null,onClose);
         }
         else
         {
            doAccept();
         }
      }
      
      public function AcceptBestfriend(param1:int, param2:String = "", param3:int = -1, param4:Boolean = false) : void
      {
         var onClose:Function = null;
         var doAccept:Function = null;
         var bestfriendId:int = param1;
         var bestFriendName:String = param2;
         var bestfriendLevel:int = param3;
         var isVip:Boolean = param4;
         onClose = function(param1:PromptEvent = null):void
         {
            if(param1.detail == Alert.YES)
            {
               doAccept();
               BreakUpBestFriend(ActorSession.loggedInActor.BestFriendId);
            }
         };
         doAccept = function():void
         {
            var acceptArgs:AcceptToBeMySpecialFriendArgs;
            var done:Function = null;
            done = function():void
            {
               DispatchBestFriendAcceptEvent(bestfriendId);
            };
            if(!FriendsManager.getInstance().hasFriend(bestfriendId))
            {
               FriendsManager.getInstance().addFriend(ActorSession.getActorId(),bestfriendId,bestFriendName,true,bestfriendLevel,isVip);
            }
            acceptArgs = new AcceptToBeMySpecialFriendArgs();
            acceptArgs.ActorId = ActorSession.getActorId();
            acceptArgs.FriendToAcceptId = bestfriendId;
            acceptArgs.FriendToBreakUpId = 0;
            acceptArgs.FriendType = FriendType.BESTFRIEND;
            new FriendshipServiceWeb().AcceptMySpecialFriend(acceptArgs,done);
         };
         if(ActorSession.loggedInActor.IsBestFriend(bestfriendId))
         {
            if(EmbeddedGamesModuleManager.getInstance().isPlaying)
            {
               EmbeddedGamesModuleManager.getInstance().closeGame();
            }
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("BESTFRIEND_ALREADY",[""]),MSPLocaleManagerWeb.getInstance().getString("BREAK_UP") + "?",Alert.YES | Alert.NO,null,onClose);
         }
         else if(ActorSession.loggedInActor.GetNumBestFriends() == MAX_NUM_BESTFRIENDS)
         {
            if(EmbeddedGamesModuleManager.getInstance().isPlaying)
            {
               EmbeddedGamesModuleManager.getInstance().closeGame();
            }
            FriendshipContainer.showBestFriendSelectorPopUp(ActorSession.loggedInActor.ActorId,bestfriendId,doAccept);
         }
         else
         {
            doAccept();
         }
      }
      
      public function RejectBoyfriend(param1:Number) : void
      {
         var done:Function = null;
         var boyfriendId:Number = param1;
         done = function():void
         {
            SendBoyFriendshipRejectBackToFriend(boyfriendId);
            MessageCommunicator.sendMessage(REJECTBOYFRIEND,boyfriendId);
         };
         ActorSession.loggedInActor.SetBoyfriendStatus(boyfriendId,ConstantsRelationshipStatus.DECLINED);
         new FriendshipServiceWeb().RejectBoyfriend(ActorSession.getActorId(),boyfriendId,FriendType.BOYFRIEND,done);
      }
      
      public function RejectBestfriend(param1:Number) : void
      {
         var done:Function = null;
         var bestfriendId:Number = param1;
         done = function():void
         {
            SendBestFriendshipRejectBackToFriend(bestfriendId);
            MessageCommunicator.sendMessage(REJECTBESTFRIEND,bestfriendId);
         };
         var rejectArgs:RejectMySpecialFriendArgs = new RejectMySpecialFriendArgs();
         rejectArgs.ActorId = ActorSession.getActorId();
         rejectArgs.FriendToRejectId = bestfriendId;
         rejectArgs.FriendType = FriendType.BESTFRIEND;
         new FriendshipServiceWeb().RejectMySpecialFriend(rejectArgs,done);
         ActorSession.loggedInActor.SetBestFriendStatus(bestfriendId,ActorSpecialRelationshipStatus.DECLINED);
      }
      
      public function AcceptFriendShip(param1:Number, param2:Function, param3:String = "", param4:int = -1, param5:Boolean = false) : void
      {
         var done:Function = null;
         var friendId:Number = param1;
         var doneCallback:Function = param2;
         var friendName:String = param3;
         var friendLevel:int = param4;
         var isVip:Boolean = param5;
         done = function(param1:String):void
         {
            if(param1 != null && param1.length > 0)
            {
               if(EmbeddedGamesModuleManager.getInstance().isPlaying)
               {
                  EmbeddedGamesModuleManager.getInstance().closeGame();
               }
               Prompt.show(param1,MSPLocaleManagerWeb.getInstance().getString("CANNOT_FRIENDS"));
               doneCallback(param1);
               return;
            }
            FriendsManager.getInstance().addFriend(ActorSession.getActorId(),friendId,friendName,true,friendLevel,isVip);
            MessageCommunicator.sendMessage(ACCEPTFRIENDSHIP,friendId);
            ActorReload.getInstance().requestReload();
            SendFriendshipAcceptBackToFriend(friendId);
            doneCallback(param1);
         };
         new FriendshipServiceWeb().ApproveFriendship(ActorSession.getActorId(),friendId,done);
      }
      
      public function RemoveFriendshipOnFriend(param1:int) : void
      {
         var _loc2_:Notification = Notification.generateMyNotification(NotificationType.DELETE_FRIEND,ActorSession.getActorId(),ActorSession.actorName);
         this.notificationChannel.sendNotificationToFriend(param1,_loc2_);
      }
      
      public function get lastActivityType() : String
      {
         return this._lastActivityType;
      }
      
      public function resetLastActivityType() : void
      {
         this._lastActivityType = "";
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
