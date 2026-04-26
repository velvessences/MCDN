package com.moviestarplanet.notification
{
   public interface INotificationSystemMessageObject extends INotificationObject
   {
      
      function get systemMessageType() : int;
      
      function get affectedUserIds() : Array;
      
      function get timestamp() : Date;
   }
}

