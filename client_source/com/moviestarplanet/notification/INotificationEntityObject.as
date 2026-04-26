package com.moviestarplanet.notification
{
   public interface INotificationEntityObject extends INotificationObject
   {
      
      function get entityId() : int;
      
      function get entityType() : int;
      
      function get entitySnapshotSubPath() : String;
   }
}

