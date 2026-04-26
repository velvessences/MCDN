package com.moviestarplanet.chat
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.clientcensor.Censor;
   import com.moviestarplanet.constants.ConstantsMSPMobileSection;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.friends.FriendsManager;
   import com.moviestarplanet.globalsharedutils.messaging.MessageStyleUtility;
   import com.moviestarplanet.globalsharedutils.messaging.SystemMessagesUtility;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.messaging.module.moduleparts.messagingwindow.model.ConversationType;
   import com.moviestarplanet.messenger.session.MessengerSessionNotifier;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.model.notification.Notification;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.msg.FriendActivityEvent;
   import com.moviestarplanet.msgservice.MsgService;
   import com.moviestarplanet.msgservice.utils.ConversationIdCache;
   import com.moviestarplanet.notification.INotificationChannel;
   import com.moviestarplanet.notifications.model.NotificationChatObject;
   import com.moviestarplanet.service.PushNotificationsAMFServiceWeb;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.utils.sound.Sounds;
   import flash.utils.Dictionary;
   
   public class LiveChatHandler
   {
      
      private static var instance:LiveChatHandler;
      
      private static const SO_ACTOR_PREFIX:String = "actorId";
      
      private static var history:Dictionary = new Dictionary(true);
      
      [Inject]
      public var notificationChannel:INotificationChannel;
      
      [Inject]
      public var chatChannel:ChatChannel;
      
      private var queue:Array = new Array();
      
      public function LiveChatHandler()
      {
         super();
         this.sendQueue();
      }
      
      private static function get handler() : LiveChatHandler
      {
         if(instance == null)
         {
            instance = new LiveChatHandler();
            InjectionManager.manager().injectMe(instance);
         }
         return instance;
      }
      
      public static function sendChatTo(param1:String, param2:String, param3:Array, param4:UserBehaviorResult) : void
      {
         handler.sendChat(param1,param2,param3,param4);
      }
      
      public static function joinGroupChatConversation(param1:String) : void
      {
         handler.joinGroupChatConversationNonStatic(param1);
      }
      
      public static function sendGroupChatTo(param1:String, param2:String, param3:int, param4:UserBehaviorResult) : void
      {
         handler.sendGroupChat(param1,param2,param3,param4);
      }
      
      public static function receivedChatFrom(param1:String, param2:int, param3:String) : void
      {
         var onConversationIdGotten:Function = null;
         var message:String = param1;
         var actorId:int = param2;
         var conversationId:String = param3;
         onConversationIdGotten = function(param1:String):void
         {
            handler.receivedChat(message,actorId,param1);
         };
         if(conversationId == null)
         {
            ConversationIdCache.getInstance().getOrCreateConversationIdForActorId(actorId,onConversationIdGotten);
         }
         else
         {
            handler.receivedChat(message,actorId,conversationId);
         }
      }
      
      public static function receivedGroupChatFrom(param1:String, param2:int, param3:String) : void
      {
         handler.receivedGroupChat(param1,param2,param3);
      }
      
      public static function receivedGroupChatSystemMessageFrom(param1:String, param2:int, param3:String, param4:NotificationChatObject = null) : void
      {
         handler.receivedGroupChatSystemMessage(param1,param2,param3,param4);
      }
      
      public static function getHistory(param1:String) : Array
      {
         return history[param1];
      }
      
      public static function createGroupChatAndSendInvites(param1:String, param2:Array, param3:String) : void
      {
         handler.createGroupChatAndSendInvitesNonStatic(param1,param2,param3);
      }
      
      public static function notifiyGroupChatJoined(param1:String, param2:int, param3:Array) : void
      {
         handler.notifyGroupChatJoinedNonStatic(param1,param2,param3);
      }
      
      public static function notifiyGroupChatLeft(param1:String) : void
      {
         handler.notifyGroupChatLeftNonStatic(param1);
      }
      
      public static function addUsersToGroupChat(param1:String, param2:Array, param3:String = "") : void
      {
         handler.addUsersToGroupChat(param1,param2,param3);
         notifiyGroupChatJoined(param1,ActorSession.getActorId(),param2);
         sendPushForNewUsersAdded(param1,param2,param3);
      }
      
      private static function sendPushForNewUsersAdded(param1:String, param2:Array, param3:String) : void
      {
         var _loc4_:Array = new Array();
         var _loc5_:uint = uint(param2.length);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            if(isActorIdOfflineFriend(param2[_loc6_]))
            {
               _loc4_.push(param2[_loc6_]);
            }
            _loc6_++;
         }
         var _loc7_:int = -1;
         new PushNotificationsAMFServiceWeb().addActorsToGroupChat(_loc4_,_loc7_,param1,param3);
      }
      
      public static function isWriting(param1:int, param2:Boolean) : void
      {
         var _loc3_:String = param2 ? "ISWRITING" : "STOPPEDWRITING";
         var _loc4_:Object = {
            "actorId":ActorSession.loggedInActor.ActorId,
            "type":_loc3_
         };
         var _loc5_:Notification = Notification.fromObject(_loc4_);
         sendNotification(param1,_loc5_,true);
      }
      
      private static function sendNotification(param1:int, param2:Notification, param3:Boolean = false) : void
      {
         if(FriendsManager.getInstance().isFriend(param1))
         {
            if(handler.notificationChannel.isFriendOnline(param1) || param3)
            {
               handler.notificationChannel.sendNotificationToFriend(param1,param2);
            }
            else
            {
               new PushNotificationsAMFServiceWeb().sendMessage(param1,ActorSession.loggedInActor.Name,param2,ConstantsMSPMobileSection.FRIENDS_PROFILE_WINDOW);
            }
         }
         else
         {
            handler.notificationChannel.sendNotificationToNonFriend(param1,param2);
         }
      }
      
      public static function isActorIdOfflineFriend(param1:int) : Boolean
      {
         if(FriendsManager.getInstance().isFriend(param1))
         {
            if(!handler.notificationChannel.isFriendOnline(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function leaveConversation(param1:String) : void
      {
         handler.leaveConversationNonStatic(param1);
      }
      
      public static function hasLeft(param1:String) : Boolean
      {
         return handler.hasLeftNonStatic(param1);
      }
      
      private function createGroupChatAndSendInvitesNonStatic(param1:String, param2:Array, param3:String) : void
      {
         this.chatChannel.createGroupChatConversationAndSendInvites(param1,param2,param3);
      }
      
      private function joinGroupChatConversationNonStatic(param1:String) : void
      {
         this.chatChannel.joinGroupChatConversation(param1);
      }
      
      private function notifyGroupChatJoinedNonStatic(param1:String, param2:int, param3:Array) : void
      {
         this.chatChannel.notifyJoined(param1,param2,param3);
      }
      
      private function notifyGroupChatLeftNonStatic(param1:String) : void
      {
         this.chatChannel.notifyLeaving(param1);
      }
      
      private function addUsersToGroupChat(param1:String, param2:Array, param3:String = "") : void
      {
         var _loc4_:int = 0;
         for each(_loc4_ in param2)
         {
            this.chatChannel.addUserToGroupChat(param1,_loc4_,param3);
         }
      }
      
      private function saveToHistory(param1:int, param2:String, param3:String) : void
      {
         var _loc4_:Array = history[param3];
         var _loc5_:HistoryData = new HistoryData(param1,param2,param3);
         if(!_loc4_)
         {
            history[param3] = new Array();
            _loc4_ = history[param3];
         }
         _loc4_.push(_loc5_);
      }
      
      private function receivedChat(param1:String, param2:int, param3:String) : void
      {
         this.saveToHistory(param2,param1,param3);
         MessageCommunicator.send(this.createChatActivityEvent(FriendActivityEvent.CHAT_MESSAGE_RECEIVED,param1,param2,param3,ConversationType.ONE_TO_ONE_CHAT));
      }
      
      private function receivedGroupChat(param1:String, param2:int, param3:String) : void
      {
         this.saveToHistory(param2,param1,param3);
         MessageCommunicator.send(this.createChatActivityEvent(FriendActivityEvent.GROUPCHAT_MESSAGE_RECEIVED,param1,param2,param3,ConversationType.GROUP_CHAT));
      }
      
      private function receivedGroupChatSystemMessage(param1:String, param2:int, param3:String, param4:NotificationChatObject = null) : void
      {
         this.saveToHistory(0,param1,param3);
         MessageCommunicator.send(this.createChatActivityEvent(FriendActivityEvent.GROUPCHAT_SYSTEMMESSAGE_RECEIVED,param1,param2,param3,ConversationType.GROUP_CHAT,param4));
      }
      
      private function sendChat(param1:String, param2:String, param3:Array, param4:UserBehaviorResult) : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:Notification = null;
         var _loc11_:Object = null;
         param1 = SystemMessagesUtility.sanitizeCodeString(param1);
         for each(_loc5_ in param3)
         {
            Censor.logInput(MessageStyleUtility.removeFontCode(param1),_loc5_,"",InputLocations.DESTINATION_TYPE_USER);
         }
         _loc6_ = UserBehaviorMessageFormatter.getInstance().embedFilteredMessages(param1,param4.whitelistedMessage,param4.blacklistedMessage);
         this.sendToLog(_loc6_,param3);
         _loc7_ = ActorSession.loggedInActor.ActorId;
         _loc8_ = ActorSession.actorName;
         for each(_loc9_ in param3)
         {
            this.saveToHistory(_loc7_,param1,param2);
            _loc10_ = Notification.generateMyNotification(NotificationType.CHAT_TYPE,_loc7_,_loc8_);
            _loc11_ = {
               "actorId":_loc7_,
               "originalMessage":param1,
               "type":NotificationType.CHAT_TYPE.type,
               "whitelistedMessage":param4.whitelistedMessage,
               "blacklistedMessage":param4.blacklistedMessage,
               "userName":_loc8_,
               "conversationId":param2,
               "timestamp":param4.timestamp
            };
            _loc10_.rawObj = _loc11_;
            sendNotification(_loc9_,_loc10_);
            MessageCommunicator.send(this.createChatActivityEvent(FriendActivityEvent.CHAT_MESSAGE_SENT,UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromUserBehaviorResult(param4),_loc9_,param2,ConversationType.ONE_TO_ONE_CHAT));
         }
         SoundManager.Instance().playSoundEffect(Sounds.CHAT_SEND);
      }
      
      private function sendGroupChat(param1:String, param2:String, param3:int, param4:UserBehaviorResult) : void
      {
         param1 = SystemMessagesUtility.sanitizeCodeString(param1);
         Censor.logInputGroupChat(MessageStyleUtility.removeFontCode(param1),InputLocations.LOC_GROUPCHAT_SENDMESSAGE,param2);
         this.saveToHistory(ActorSession.loggedInActor.ActorId,param1,param2);
         this.chatChannel.sendGroupChatMessage(param2,param4);
         MessageCommunicator.send(this.createChatActivityEvent(FriendActivityEvent.GROUPCHAT_MESSAGE_SENT,UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromUserBehaviorResult(param4),param3,param2,ConversationType.GROUP_CHAT));
         SoundManager.Instance().playSoundEffect(Sounds.CHAT_SEND);
      }
      
      private function sendQueue() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:IFriend = null;
         var _loc4_:Boolean = false;
         while(this.queue.length > 0)
         {
            _loc1_ = this.queue.shift();
            for each(_loc2_ in _loc1_.actorIds)
            {
               _loc3_ = FriendsManager.getInstance().getFriend(_loc2_);
               if(_loc3_ == null)
               {
                  _loc4_ = true;
               }
               else
               {
                  _loc4_ = _loc3_.online == false;
               }
               if(true == MessengerSessionNotifier.getInstance().isSessionSet())
               {
                  MsgService.getInstance().sendMessage(_loc1_.message,_loc4_,[_loc2_],ActorSession.actorName);
               }
            }
         }
      }
      
      private function sendToLog(param1:String, param2:Array) : void
      {
         this.queue.push({
            "message":param1,
            "actorIds":param2
         });
         this.sendQueue();
      }
      
      private function createChatActivityEvent(param1:String, param2:String, param3:int, param4:String, param5:int, param6:NotificationChatObject = null) : FriendActivityEvent
      {
         return new FriendActivityEvent(param1,{
            "actorId":param3,
            "msg":param2,
            "conversationId":param4,
            "conversationType":param5,
            "notificationObj":param6
         });
      }
      
      public function leaveConversationNonStatic(param1:String) : void
      {
         this.chatChannel.leaveConversation(param1);
      }
      
      public function hasLeftNonStatic(param1:String) : Boolean
      {
         return this.chatChannel.hasLeft(param1);
      }
   }
}

