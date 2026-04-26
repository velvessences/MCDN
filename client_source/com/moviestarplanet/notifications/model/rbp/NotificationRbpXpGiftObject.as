package com.moviestarplanet.notifications.model.rbp
{
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.msgservice.MsgServiceSystemMessageType;
   import com.moviestarplanet.notification.NotificationCategory;
   import com.moviestarplanet.notification.rbp.INotificationRbpXpGiftObject;
   import com.moviestarplanet.notifications.model.NotificationSystemMessageObject;
   
   public class NotificationRbpXpGiftObject extends NotificationSystemMessageObject implements INotificationRbpXpGiftObject
   {
      
      private var _exp:int;
      
      public function NotificationRbpXpGiftObject()
      {
         super();
      }
      
      public static function create(param1:int, param2:String, param3:Date, param4:int) : NotificationRbpXpGiftObject
      {
         var _loc5_:NotificationRbpXpGiftObject = NotificationSystemMessageObject.createAsClass(NotificationRbpXpGiftObject,param1,param2,NotificationType.RBP_XP_GIFT.type,MsgServiceSystemMessageType.RBP_XP_GIFT,[],param3,"",NotificationCategory.SYSTEM_MESSAGE) as NotificationRbpXpGiftObject;
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

