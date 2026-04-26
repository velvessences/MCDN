package com.moviestarplanet.notification
{
   public interface INotification
   {
      
      function get type() : String;
      
      function get actorId() : int;
      
      function toString(param1:String) : String;
      
      function getObject() : Object;
      
      function get notificationObject() : INotificationObject;
      
      function get rawObj() : Object;
   }
}

