package com.moviestarplanet.model.notification
{
   import com.moviestarplanet.model.friends.ILoggedInUser;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationFactory;
   import com.moviestarplanet.notification.INotificationObject;
   
   public class NotificationFactory implements INotificationFactory
   {
      
      [Inject]
      public var loggedInUser:ILoggedInUser;
      
      public function NotificationFactory()
      {
         super();
      }
      
      public function generateNotificationWithStrictType(param1:INotificationObject) : INotification
      {
         var _loc2_:Notification = Notification.generateMyNotification(NotificationType.typeByTypeStr(param1.notificationTypeId),param1.userId);
         _loc2_.notificationObject = param1;
         return _loc2_;
      }
      
      public function generateMyNotification(param1:String) : INotification
      {
         return Notification.generateMyNotification(NotificationType.typeByTypeStr(param1),this.loggedInUser.userId,this.loggedInUser.name);
      }
      
      public function generateMyNotificationFromObject(param1:Object) : INotification
      {
         if(param1 is INotificationObject)
         {
            return this.generateNotificationWithStrictType(param1 as INotificationObject);
         }
         param1.actorId = this.loggedInUser.userId;
         return this.fromObject(param1);
      }
      
      public function fromObject(param1:Object) : INotification
      {
         return Notification.fromObject(param1);
      }
      
      public function fromString(param1:String) : INotification
      {
         return Notification.fromString(param1);
      }
   }
}

