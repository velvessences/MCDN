package com.moviestarplanet.notifications.delegatees
{
   import com.moviestarplanet.notification.INotification;
   
   public interface IChatNotificationDelegatee
   {
      
      function onChatNotification(param1:INotification) : Boolean;
   }
}

