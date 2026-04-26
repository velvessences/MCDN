package com.moviestarplanet.friends.notifications
{
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationListener;
   
   public class DummyNotificationListener implements INotificationListener
   {
      
      public function DummyNotificationListener()
      {
         super();
      }
      
      public function onFriendOnlineStatus(param1:Number, param2:String) : void
      {
      }
      
      public function onNotification(param1:INotification) : void
      {
      }
   }
}

