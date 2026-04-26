package com.moviestarplanet.notifications.model
{
   import com.moviestarplanet.notification.INotificationLegacyObject;
   import com.moviestarplanet.notification.NotificationCategory;
   
   public class NotificationLegacyObject extends NotificationObject implements INotificationLegacyObject
   {
      
      private var _payload:Object;
      
      public function NotificationLegacyObject()
      {
         super();
      }
      
      public static function create(param1:Object) : NotificationLegacyObject
      {
         var _loc2_:NotificationLegacyObject = new NotificationLegacyObject();
         _loc2_.payload = param1;
         return _loc2_;
      }
      
      public function get payload() : Object
      {
         return this._payload;
      }
      
      public function set payload(param1:Object) : void
      {
         this._payload = param1;
         userId = this.payload.actorId;
         notificationTypeId = this.payload.type;
         notificationCatetoryId = NotificationCategory.UNKNOWN;
         if(param1.hasOwnProperty("localizedText"))
         {
            localizedText = param1.localizedText;
         }
         if(this.payload.hasOwnProperty("userName"))
         {
            super.userName = this.payload.userName;
         }
      }
      
      override public function set userName(param1:String) : void
      {
         super.userName = param1;
         this.payload.userName = param1;
      }
   }
}

