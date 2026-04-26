package com.moviestarplanet.notifications.model
{
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.msgservice.MsgServiceSystemMessageType;
   import com.moviestarplanet.notification.INotificationAutographObject;
   import com.moviestarplanet.notification.NotificationCategory;
   
   public class NotificationAutographObject extends NotificationSystemMessageObject implements INotificationAutographObject
   {
      
      private var _fame:int;
      
      public function NotificationAutographObject()
      {
         super();
      }
      
      public static function create(param1:int, param2:String, param3:Date, param4:int) : NotificationAutographObject
      {
         var _loc5_:NotificationAutographObject = NotificationSystemMessageObject.createAsClass(NotificationAutographObject,param1,param2,NotificationType.AUTOGRAPH.type,MsgServiceSystemMessageType.MSP_AUTOGRAPH,[],param3,"",NotificationCategory.SYSTEM_MESSAGE) as NotificationAutographObject;
         _loc5_.fame = param4;
         return _loc5_;
      }
      
      public function get fame() : int
      {
         return this._fame;
      }
      
      public function set fame(param1:int) : void
      {
         this._fame = param1;
      }
   }
}

