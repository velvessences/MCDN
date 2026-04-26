package com.moviestarplanet.chat
{
   import com.moviestarplanet.model.friends.IFriendList;
   import com.moviestarplanet.model.friends.ILoggedInUser;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationChannel;
   import com.moviestarplanet.notification.INotificationFactory;
   import com.moviestarplanet.notification.INotificationObject;
   import com.moviestarplanet.notification.INotificationSystemMessageObject;
   import com.moviestarplanet.notifications.model.NotificationChatObject;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.xmppConnection.channel.GroupChatChannel;
   import flash.utils.Dictionary;
   
   public class ChatChannel
   {
      
      [Inject]
      public var chatListener:ChatListener;
      
      [Inject]
      public var groupChatChannel:GroupChatChannel;
      
      [Inject]
      public var notificationFactory:INotificationFactory;
      
      [Inject]
      public var notificationChannel:INotificationChannel;
      
      [Inject]
      public var loggedInUser:ILoggedInUser;
      
      [Inject]
      public var friendList:IFriendList;
      
      private var leftConversations:Dictionary;
      
      public function ChatChannel()
      {
         super();
         this.leftConversations = new Dictionary();
      }
      
      public function sendChatMessage(param1:int, param2:UserBehaviorResult) : void
      {
         this.chatListener.addChatLineTo(param1,param2.blacklistedMessage,param2.whitelistedMessage,param2.message);
         var _loc3_:Object = {
            "originalMessage":param2.message,
            "type":"CHAT",
            "whitelistedMessage":param2.whitelistedMessage,
            "blacklistedMessage":param2.blacklistedMessage
         };
         var _loc4_:INotification = this.notificationFactory.generateMyNotificationFromObject(_loc3_);
         this.notificationChannel.sendNotificationToFriend(param1,_loc4_);
      }
      
      public function sendGroupChatMessage(param1:String, param2:UserBehaviorResult) : void
      {
         if(this.hasLeft(param1) == false)
         {
            this.groupChatChannel.sendBehaviourmodifiedTextToGroupChat(param1,param2.blacklistedMessage,param2.whitelistedMessage,param2.message,param2.timestamp);
         }
      }
      
      public function sendSystemMessage(param1:int, param2:INotificationSystemMessageObject) : void
      {
         var _loc3_:INotification = this.notificationFactory.generateMyNotificationFromObject(param2);
         this.chatListener.addSystemMessageNotification(param1,_loc3_);
         if(this.friendList.getFriendById(param1))
         {
            this.notificationChannel.sendNotificationToFriend(param1,_loc3_);
         }
      }
      
      public function hasLeft(param1:String) : Boolean
      {
         if(this.leftConversations[param1])
         {
            return true;
         }
         return false;
      }
      
      public function createGroupChatConversation(param1:String) : void
      {
         this.setLeftStatus(param1,true);
         this.groupChatChannel.createGroupChat(param1);
      }
      
      public function joinGroupChatConversation(param1:String) : void
      {
         this.setLeftStatus(param1,true);
         this.groupChatChannel.joinRoomByConversationId(param1);
      }
      
      public function addUserToGroupChat(param1:String, param2:int, param3:String = "") : void
      {
         this.groupChatChannel.addUserToGroupChat(param1,param2,param3);
      }
      
      public function createGroupChatConversationAndSendInvites(param1:String, param2:Array, param3:String) : void
      {
         this.setLeftStatus(param1,true);
         this.groupChatChannel.createGroupChatWithParticipants(param1,param2,param3);
      }
      
      public function leaveConversation(param1:String) : void
      {
         this.setLeftStatus(param1,false);
         this.groupChatChannel.leaveConversation(param1,true);
      }
      
      public function joinPrioritizedConversations(param1:Array) : void
      {
         this.groupChatChannel.joinPrioritizedConversations(param1);
      }
      
      public function notifyLeaving(param1:String) : void
      {
         this.setLeftStatus(param1,false);
         var _loc2_:INotificationObject = this.createNotificationObject(param1,this.loggedInUser.userId,this.loggedInUser.name,NotificationType.GROUP_CHAT_USER_LEFT);
         this.groupChatChannel.sendNotificationObjectToGroupChat(param1,_loc2_);
      }
      
      private function setLeftStatus(param1:String, param2:Boolean = false) : void
      {
         if(param2 == true)
         {
            this.leftConversations[param1] = null;
            delete this.leftConversations[param1];
         }
         else
         {
            this.leftConversations[param1] = true;
         }
      }
      
      public function notifyJoined(param1:String, param2:int, param3:Array = null) : void
      {
         var _loc4_:INotificationObject = this.createNotificationObject(param1,param2,"",NotificationType.GROUP_CHAT_USER_JOINED,param3);
         this.groupChatChannel.sendNotificationObjectToGroupChat(param1,_loc4_);
      }
      
      private function createNotificationObject(param1:String, param2:int, param3:String, param4:NotificationType, param5:Array = null) : INotificationObject
      {
         return NotificationChatObject.create(param2,param3,param4.type,param1,"","","",param5);
      }
   }
}

