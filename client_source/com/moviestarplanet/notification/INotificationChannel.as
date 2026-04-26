package com.moviestarplanet.notification
{
   public interface INotificationChannel
   {
      
      function connectToFriend(param1:Number) : void;
      
      function disconnect() : void;
      
      function disconnectFromFriend(param1:Number) : void;
      
      function closeChannel() : void;
      
      function sendNotificationToFriend(param1:Number, param2:INotification) : void;
      
      function sendNotificationToNonFriend(param1:int, param2:INotification) : void;
      
      function sendNotificationToOnlineFriends(param1:INotification) : void;
      
      function isFriendOnline(param1:int) : Boolean;
      
      function isChannelReady() : Boolean;
   }
}

