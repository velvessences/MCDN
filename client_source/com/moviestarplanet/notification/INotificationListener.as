package com.moviestarplanet.notification
{
   public interface INotificationListener
   {
      
      function onNotification(param1:INotification) : void;
      
      function onFriendOnlineStatus(param1:Number, param2:String) : void;
   }
}

