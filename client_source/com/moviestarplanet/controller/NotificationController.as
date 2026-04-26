package com.moviestarplanet.controller
{
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationBroadcaster;
   import com.moviestarplanet.notification.INotificationListener;
   
   public class NotificationController implements INotificationListener, INotificationBroadcaster
   {
      
      private var listeners:Array = [];
      
      public function NotificationController()
      {
         super();
      }
      
      public function listenForNotifications(param1:INotificationListener) : void
      {
         this.listeners.push(param1);
      }
      
      public function stopListening(param1:INotificationListener) : void
      {
         this.listeners.splice(this.listeners.indexOf(param1),1);
      }
      
      public function onNotification(param1:INotification) : void
      {
         var _loc2_:INotificationListener = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.listeners.length)
         {
            _loc2_ = this.listeners[_loc3_];
            _loc2_.onNotification(param1);
            _loc3_++;
         }
      }
      
      public function onFriendOnlineStatus(param1:Number, param2:String) : void
      {
         var _loc3_:INotificationListener = null;
         for each(_loc3_ in this.listeners)
         {
            _loc3_.onFriendOnlineStatus(param1,param2);
         }
      }
      
      public function destroy() : void
      {
         this.listeners = [];
      }
   }
}

