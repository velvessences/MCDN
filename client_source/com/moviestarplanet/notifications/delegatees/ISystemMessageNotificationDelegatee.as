package com.moviestarplanet.notifications.delegatees
{
   import com.moviestarplanet.notification.INotification;
   
   public interface ISystemMessageNotificationDelegatee
   {
      
      function onSystemMessageNotification(param1:INotification) : Boolean;
   }
}

