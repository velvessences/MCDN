package com.moviestarplanet.friends.notifications
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.connection.channel.IOnlineStatusListener;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.friends.FriendsManager;
   import com.moviestarplanet.model.FriendList;
   import com.moviestarplanet.model.notification.Notification;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.msg.MSPDataEvent;
   import com.moviestarplanet.msg.MSP_Event;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationListener;
   import com.moviestarplanet.notification.INotificationObject;
   import com.moviestarplanet.notifications.model.NotificationNudgeObject;
   import com.moviestarplanet.notifications.model.NotificationObject;
   import com.moviestarplanet.session.nudge.NudgeDispatcher;
   
   public class WebNotificationListener implements INotificationListener, IOnlineStatusListener
   {
      
      public function WebNotificationListener()
      {
         super();
      }
      
      public function onFriendOnlineStatus(param1:Number, param2:String) : void
      {
         var _loc3_:INotificationObject = null;
         var _loc4_:Notification = null;
         (FriendsManager.getInstance().friendList as FriendList).setOnlineStatus(param1,param2);
         if(param2 == "disconnected")
         {
            MessageCommunicator.sendMessage(MSPEvent.FMS_COM_DISCONNECTED,param1);
         }
         else
         {
            _loc3_ = NotificationObject.create(param1,"",NotificationType.FRIENDCONNECTED.type,param2);
            _loc4_ = Notification.generateMyNotification(NotificationType.FRIENDCONNECTED,param1);
            _loc4_.notificationObject = _loc3_;
            this.onNotification(_loc4_);
         }
         FriendsManager.getInstance().webEventDispatcher.dispatchEvent(new MSP_Event(FriendsManager.ACTORCONNECTEDCHANGED,param1));
      }
      
      public function onNotification(param1:INotification) : void
      {
         var _loc2_:NotificationNudgeObject = null;
         if(param1 is Notification)
         {
            switch(param1.type)
            {
               case NotificationType.SERVER_NUDGE.type:
                  _loc2_ = param1.notificationObject as NotificationNudgeObject;
                  NudgeDispatcher.getInstance().dispacthNudge(_loc2_.command);
                  break;
               default:
                  MessageCommunicator.send(new MSPDataEvent(MSPEvent.NOTIFICATION_ATIVATED,param1));
            }
         }
      }
   }
}

