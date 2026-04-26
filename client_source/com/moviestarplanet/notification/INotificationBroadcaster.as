package com.moviestarplanet.notification
{
   public interface INotificationBroadcaster
   {
      
      function listenForNotifications(param1:INotificationListener) : void;
      
      function stopListening(param1:INotificationListener) : void;
      
      function destroy() : void;
   }
}

