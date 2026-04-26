package com.moviestarplanet.notifications.model
{
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.msgservice.MsgServiceSystemMessageType;
   import com.moviestarplanet.notification.INotificationHugObject;
   import com.moviestarplanet.notification.NotificationCategory;
   
   public class NotificationHugObject extends NotificationSystemMessageObject implements INotificationHugObject
   {
      
      private var _exp:int;
      
      public function NotificationHugObject()
      {
         super();
      }
      
      public static function create(param1:int, param2:String, param3:Date, param4:int) : NotificationHugObject
      {
         var _loc5_:NotificationHugObject = NotificationSystemMessageObject.createAsClass(NotificationHugObject,param1,param2,NotificationType.HUG.type,MsgServiceSystemMessageType.BP_HUG,[],param3,"",NotificationCategory.SYSTEM_MESSAGE) as NotificationHugObject;
         _loc5_.exp = param4;
         return _loc5_;
      }
      
      public function get exp() : int
      {
         return this._exp;
      }
      
      public function set exp(param1:int) : void
      {
         this._exp = param1;
      }
   }
}

