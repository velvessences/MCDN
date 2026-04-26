package com.moviestarplanet.notification
{
   public interface INotificationObject
   {
      
      function get userId() : int;
      
      function set userId(param1:int) : void;
      
      function get userName() : String;
      
      function get notificationTypeId() : String;
      
      function get notificationCatetoryId() : int;
      
      function get applicationId() : String;
      
      function get importance() : int;
      
      function get iconSubPath() : String;
      
      function get localizedText() : String;
   }
}

