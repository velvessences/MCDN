package com.moviestarplanet.chat
{
   import com.moviestarplanet.chat.model.ChatHistory;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.model.friends.IFriendList;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.msgservice.IMsgServiceAutograph;
   import com.moviestarplanet.msgservice.IMsgServiceGroupChatSystemMessage;
   import com.moviestarplanet.msgservice.IMsgServiceHug;
   import com.moviestarplanet.msgservice.IMsgServiceMessage;
   import com.moviestarplanet.msgservice.IMsgServiceSystemMessage;
   import com.moviestarplanet.msgservice.IMsgServiceUserMessage;
   import com.moviestarplanet.msgservice.MsgServiceSystemMessageType;
   import com.moviestarplanet.msgservice.rbp.IMsgServiceRbpXpGift;
   import com.moviestarplanet.msgservice.valueobjects.MsgServiceAutograph;
   import com.moviestarplanet.msgservice.valueobjects.MsgServiceGroupChatSystemMessage;
   import com.moviestarplanet.msgservice.valueobjects.MsgServiceHug;
   import com.moviestarplanet.msgservice.valueobjects.MsgServiceUserMessage;
   import com.moviestarplanet.msgservice.valueobjects.rbp.MsgServiceRbpXpGift;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationAutographObject;
   import com.moviestarplanet.notification.INotificationBroadcaster;
   import com.moviestarplanet.notification.INotificationChannel;
   import com.moviestarplanet.notification.INotificationChatObject;
   import com.moviestarplanet.notification.INotificationHugObject;
   import com.moviestarplanet.notification.INotificationListener;
   import com.moviestarplanet.notification.INotificationObject;
   import com.moviestarplanet.notification.INotificationSystemMessageObject;
   import com.moviestarplanet.notification.rbp.INotificationRbpXpGiftObject;
   import com.moviestarplanet.notifications.delegatees.IChatNotificationDelegatee;
   import com.moviestarplanet.notifications.delegatees.ISystemMessageNotificationDelegatee;
   import com.moviestarplanet.notifications.delegators.IChatNotificationDelegator;
   import com.moviestarplanet.notifications.delegators.ISystemMessageNotificationDelegator;
   import com.moviestarplanet.notifications.model.NotificationChatObject;
   import com.moviestarplanet.notifications.model.NotificationLegacyObject;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.igniterealtime.xiff.events.LoginEvent;
   
   public class ChatListener implements INotificationListener, IChatNotificationDelegatee, ISystemMessageNotificationDelegatee
   {
      
      [Inject]
      public var notificationBroadcaster:INotificationBroadcaster;
      
      [Inject]
      public var chatNotificationDelegator:IChatNotificationDelegator;
      
      [Inject]
      public var systemMessageNotificationDelegator:ISystemMessageNotificationDelegator;
      
      [Inject]
      public var notificationChannel:INotificationChannel;
      
      [Inject]
      public var friendList:IFriendList;
      
      private var currentUserId:int;
      
      private var chatHistories:Dictionary;
      
      private var _currentConversationId:String;
      
      public function ChatListener()
      {
         super();
         this.chatHistories = new Dictionary();
      }
      
      public function listen(param1:int) : void
      {
         this.currentUserId = param1;
         this.notificationBroadcaster.listenForNotifications(this);
         this.chatNotificationDelegator.registerAsDelegateeAt(this,0);
         this.systemMessageNotificationDelegator.registerAsDelegateeAt(this,0);
         if(this.notificationChannel is EventDispatcher)
         {
            (this.notificationChannel as EventDispatcher).addEventListener(LoginEvent.LOGIN,this.onChannelLogin);
         }
      }
      
      public function stopListening() : void
      {
         this.notificationBroadcaster.stopListening(this);
         this.chatNotificationDelegator.unregisterAsDelegatee(this);
         this.systemMessageNotificationDelegator.unregisterAsDelegatee(this);
      }
      
      public function onNotification(param1:INotification) : void
      {
         switch(param1.type)
         {
            case NotificationType.BLOCKED_BY_USER.type:
               this.blockChat(param1,true);
               break;
            case NotificationType.UNBLOCKED_BY_USER.type:
               this.blockChat(param1,false);
         }
      }
      
      public function onChatNotification(param1:INotification) : Boolean
      {
         switch(param1.type)
         {
            case NotificationType.CHAT_TYPE.type:
               this.addChat(param1);
               break;
            case NotificationType.GROUP_CHAT.type:
               this.addChat(param1);
               break;
            case NotificationType.GROUP_CHAT_USER_LEFT.type:
               this.addSystemChat(param1,MsgServiceSystemMessageType.GROUP_CHAT_USER_LEFT);
               break;
            case NotificationType.GROUP_CHAT_USER_JOINED.type:
               this.addSystemChat(param1,MsgServiceSystemMessageType.GROUP_CHAT_USER_ADDED);
               break;
            case NotificationType.GROUP_CHAT_INVITE_RECEIVED.type:
               this.clearChatHistory(param1);
         }
         return !this.isNotificationFromCurrentConversation(param1);
      }
      
      public function onSystemMessageNotification(param1:INotification) : Boolean
      {
         this.addSystemMessageNotification(param1.notificationObject.userId,param1);
         return true;
      }
      
      public function addSystemMessageNotification(param1:int, param2:INotification) : void
      {
         var _loc3_:IMsgServiceSystemMessage = null;
         var _loc4_:INotificationSystemMessageObject = null;
         if(param2.notificationObject is INotificationSystemMessageObject)
         {
            _loc4_ = param2.notificationObject as INotificationSystemMessageObject;
            switch(_loc4_.systemMessageType)
            {
               case MsgServiceSystemMessageType.MSP_AUTOGRAPH:
                  _loc3_ = this.createAutograph(_loc4_);
                  break;
               case MsgServiceSystemMessageType.BP_HUG:
                  _loc3_ = this.createHug(_loc4_);
                  break;
               case MsgServiceSystemMessageType.RBP_XP_GIFT:
                  _loc3_ = this.createRbpXpGift(_loc4_);
            }
         }
         else
         {
            switch(param2.type)
            {
               case NotificationType.AUTOGRAPH.type:
                  _loc3_ = this.createLegacyAutograph(param2);
            }
         }
         if(_loc3_ != null)
         {
            this.addSystemMessage(param1,_loc3_);
         }
      }
      
      public function addChatLineTo(param1:Number, param2:String, param3:String, param4:String) : void
      {
         this.addChatLineByActorId(param1,this.currentUserId,param2,param3,param4);
      }
      
      public function getChatHistory(param1:String) : ChatHistory
      {
         var _loc2_:ChatHistory = this.chatHistories[param1];
         if(!_loc2_)
         {
            _loc2_ = new ChatHistory();
            this.chatHistories[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function set currentConversationId(param1:String) : void
      {
         this._currentConversationId = param1;
      }
      
      public function onFriendOnlineStatus(param1:Number, param2:String) : void
      {
      }
      
      private function addChatLineByActorId(param1:Number, param2:int, param3:String, param4:String, param5:String) : void
      {
         var _loc6_:IMsgServiceUserMessage = this.createUserMessage(param2,param3,param4,param5,new Date());
         new CreateConversationCommand().createAndReturnMessage(param1,_loc6_,this.addChatLine);
      }
      
      private function addChatLine(param1:String, param2:IMsgServiceMessage) : void
      {
         this.getChatHistory(param1).addMessage(param2);
      }
      
      private function addSystemMessage(param1:int, param2:IMsgServiceMessage) : void
      {
         new CreateConversationCommand().createAndReturnMessage(param1,param2,this.addChatLine);
      }
      
      private function createUserMessage(param1:int, param2:String, param3:String, param4:String, param5:Date) : IMsgServiceUserMessage
      {
         var _loc6_:IMsgServiceUserMessage = new MsgServiceUserMessage();
         _loc6_.blacklistMsg = param2;
         _loc6_.whitelistMsg = param3;
         _loc6_.rawMsg = param4;
         _loc6_.sender = param1;
         _loc6_.timestamp = param5;
         return _loc6_;
      }
      
      private function createSystemMessage(param1:IMsgServiceSystemMessage, param2:INotificationSystemMessageObject, ... rest) : IMsgServiceSystemMessage
      {
         param1.systemMsgType = param2.systemMessageType;
         param1.timestamp = param2.timestamp;
         if(param2.affectedUserIds != null && param2.affectedUserIds.length > 0)
         {
            param1.affectedActorIds = param2.affectedUserIds;
         }
         else
         {
            param1.affectedActorIds = [param2.userId,this.currentUserId].sort();
         }
         param1.systemMsgAgent = param2.userId;
         param1.parameters = rest;
         return param1;
      }
      
      private function createAutograph(param1:INotificationSystemMessageObject) : IMsgServiceSystemMessage
      {
         var _loc2_:INotificationAutographObject = param1 as INotificationAutographObject;
         var _loc3_:IMsgServiceAutograph = new MsgServiceAutograph();
         _loc3_.fame = _loc2_.fame;
         return this.createSystemMessage(_loc3_,param1,_loc2_.fame) as IMsgServiceAutograph;
      }
      
      private function createHug(param1:INotificationSystemMessageObject) : IMsgServiceSystemMessage
      {
         var _loc2_:INotificationHugObject = param1 as INotificationHugObject;
         var _loc3_:IMsgServiceHug = new MsgServiceHug();
         _loc3_.exp = _loc2_.exp;
         return this.createSystemMessage(_loc3_,param1,_loc2_.exp) as IMsgServiceHug;
      }
      
      private function createRbpXpGift(param1:INotificationSystemMessageObject) : IMsgServiceSystemMessage
      {
         var _loc2_:INotificationRbpXpGiftObject = param1 as INotificationRbpXpGiftObject;
         var _loc3_:IMsgServiceRbpXpGift = new MsgServiceRbpXpGift();
         _loc3_.exp = _loc2_.exp;
         return this.createSystemMessage(_loc3_,param1,_loc2_.exp) as IMsgServiceRbpXpGift;
      }
      
      private function createLegacyAutograph(param1:INotification) : IMsgServiceSystemMessage
      {
         var _loc2_:INotificationObject = param1.notificationObject as INotificationObject;
         var _loc3_:MsgServiceAutograph = new MsgServiceAutograph();
         _loc3_.systemMsgType = MsgServiceSystemMessageType.MSP_AUTOGRAPH;
         _loc3_.timestamp = new Date();
         _loc3_.affectedActorIds = [_loc2_.userId,this.currentUserId].sort();
         _loc3_.systemMsgAgent = _loc2_.userId;
         var _loc4_:IFriend = this.friendList.getFriendById(_loc2_.userId);
         var _loc5_:int = _loc4_.level * 10;
         _loc3_.fame = _loc5_;
         _loc3_.parameters = [_loc5_];
         return _loc3_;
      }
      
      private function addChat(param1:INotification) : void
      {
         var _loc2_:IMsgServiceUserMessage = null;
         var _loc3_:INotificationChatObject = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:NotificationLegacyObject = null;
         if(param1.notificationObject is INotificationChatObject)
         {
            _loc3_ = param1.notificationObject as INotificationChatObject;
            _loc2_ = this.createUserMessage(_loc3_.userId,_loc3_.blacklistedMessage,_loc3_.whitelistedMessage,_loc3_.originalMessage,_loc3_.timestamp);
            this.addChatLine(_loc3_.conversationId,_loc2_);
         }
         else
         {
            _loc7_ = param1.getObject();
            _loc8_ = param1.notificationObject as NotificationLegacyObject;
            if(_loc7_ != null)
            {
               if(_loc7_.hasOwnProperty("originalMessage"))
               {
                  _loc4_ = _loc7_.originalMessage;
               }
               if(_loc7_.hasOwnProperty("blacklistedMessage"))
               {
                  _loc5_ = _loc7_.blacklistedMessage;
               }
               if(_loc7_.hasOwnProperty("whitelistedMessage"))
               {
                  _loc6_ = _loc7_.whitelistedMessage;
               }
            }
            _loc2_ = this.createUserMessage(param1.actorId,_loc5_,_loc6_,_loc4_,_loc8_.payload["timestamp"] == null ? null : new Date(_loc8_.payload["timestamp"]));
            this.addChatLine(_loc8_.payload["conversationId"],_loc2_);
         }
      }
      
      private function addSystemChat(param1:INotification, param2:int) : void
      {
         var _loc4_:IMsgServiceGroupChatSystemMessage = null;
         var _loc3_:NotificationChatObject = param1.notificationObject as NotificationChatObject;
         switch(param2)
         {
            case MsgServiceSystemMessageType.GROUP_CHAT_USER_LEFT:
               _loc4_ = new MsgServiceGroupChatSystemMessage();
               _loc4_.systemMsgType = MsgServiceSystemMessageType.GROUP_CHAT_USER_LEFT;
               _loc4_.timestamp = _loc3_.timestamp;
               _loc4_.affectedActorIds = [];
               _loc4_.systemMsgAgent = _loc3_.userId;
               break;
            case MsgServiceSystemMessageType.GROUP_CHAT_USER_ADDED:
               _loc4_ = new MsgServiceGroupChatSystemMessage();
               _loc4_.systemMsgType = MsgServiceSystemMessageType.GROUP_CHAT_USER_ADDED;
               _loc4_.timestamp = _loc3_.timestamp;
               _loc4_.affectedActorIds = _loc3_.affectedUserIds;
               _loc4_.systemMsgAgent = _loc3_.userId;
               break;
            case MsgServiceSystemMessageType.GROUP_CHAT_CONVERSATION_RENAMED:
         }
         if(_loc4_ != null)
         {
            this.addChatLine(_loc3_.conversationId,_loc4_);
         }
      }
      
      private function clearChatHistory(param1:INotification) : void
      {
         var _loc2_:NotificationChatObject = null;
         if(param1.notificationObject is INotificationChatObject)
         {
            _loc2_ = param1.notificationObject as NotificationChatObject;
            this.getChatHistory(_loc2_.conversationId).clearChatHistory();
         }
      }
      
      private function clearAllChatHistory() : void
      {
         var _loc1_:ChatHistory = null;
         for each(_loc1_ in this.chatHistories)
         {
            _loc1_.clearChatHistory();
         }
      }
      
      private function blockChat(param1:INotification, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(param1.notificationObject is INotificationChatObject)
         {
            _loc3_ = INotificationChatObject(param1.notificationObject).conversationId;
            this.getChatHistory(_loc3_).broadcastBlocked(param2);
         }
         else
         {
            new CreateConversationCommand().createAndReturnBlocked(param1.notificationObject.userId,param2,this.broadcastBlocked);
         }
      }
      
      private function broadcastBlocked(param1:String, param2:Boolean) : void
      {
         this.getChatHistory(param1).broadcastBlocked(param2);
      }
      
      private function isNotificationFromCurrentConversation(param1:INotification) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1.type)
         {
            case NotificationType.CHAT_TYPE.type:
               if(param1.notificationObject is NotificationChatObject)
               {
                  _loc2_ = (param1.notificationObject as NotificationChatObject).conversationId == this._currentConversationId;
                  break;
               }
               if(param1.notificationObject is NotificationLegacyObject)
               {
                  _loc2_ = (param1.notificationObject as NotificationLegacyObject).payload.conversationId == this._currentConversationId;
               }
               break;
            case NotificationType.GROUP_CHAT.type:
            case NotificationType.GROUP_CHAT_USER_LEFT.type:
            case NotificationType.GROUP_CHAT_USER_JOINED.type:
               _loc2_ = (param1.notificationObject as NotificationChatObject).conversationId == this._currentConversationId;
         }
         return _loc2_;
      }
      
      private function onChannelLogin(param1:LoginEvent) : void
      {
         this.clearAllChatHistory();
      }
   }
}

