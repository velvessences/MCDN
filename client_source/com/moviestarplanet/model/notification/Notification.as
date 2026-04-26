package com.moviestarplanet.model.notification
{
   import com.moviestarplanet.chatrooms.model.NotificationChatromObject;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.notification.INotification;
   import com.moviestarplanet.notification.INotificationLegacyObject;
   import com.moviestarplanet.notification.INotificationObject;
   import com.moviestarplanet.notifications.model.NotificationAppearanceObject;
   import com.moviestarplanet.notifications.model.NotificationAutographObject;
   import com.moviestarplanet.notifications.model.NotificationChatObject;
   import com.moviestarplanet.notifications.model.NotificationEntityObject;
   import com.moviestarplanet.notifications.model.NotificationHugObject;
   import com.moviestarplanet.notifications.model.NotificationLegacyObject;
   import com.moviestarplanet.notifications.model.NotificationObject;
   import com.moviestarplanet.notifications.model.rbp.NotificationRbpXpGiftObject;
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class Notification implements INotification
   {
      
      registerClassAlias("NotificationObject",NotificationObject);
      registerClassAlias("NotificationEntityObject",NotificationEntityObject);
      registerClassAlias("NotificationLegacyObject",NotificationLegacyObject);
      registerClassAlias("NotificationChatromObject",NotificationChatromObject);
      registerClassAlias("NotificationChatObject",NotificationChatObject);
      registerClassAlias("NotificationAppearanceObject",NotificationAppearanceObject);
      registerClassAlias("NotificationAutographObject",NotificationAutographObject);
      registerClassAlias("NotificationHugObject",NotificationHugObject);
      registerClassAlias("NotificationRbpXpGiftObject",NotificationRbpXpGiftObject);
      
      private var _actorId:int;
      
      private var _type:String;
      
      private var _notificationObj:INotificationObject;
      
      public function Notification()
      {
         super();
      }
      
      public static function fromString(param1:String) : Notification
      {
         var _loc2_:Notification = new Notification();
         _loc2_.fromStringInternal(param1);
         return _loc2_;
      }
      
      public static function fromByteArray(param1:ByteArray) : Notification
      {
         var _loc2_:Notification = new Notification();
         _loc2_.fromByteArrayInternal(param1);
         return _loc2_;
      }
      
      public static function generateMyNotification(param1:NotificationType, param2:Number, param3:String = "") : Notification
      {
         var _loc4_:Notification = new Notification();
         _loc4_.notificationObject = NotificationObject.create(param2,param3,param1.type);
         return _loc4_;
      }
      
      public static function fromObject(param1:Object) : Notification
      {
         var _loc2_:Notification = new Notification();
         if(param1 is INotificationObject)
         {
            _loc2_.notificationObject = param1 as INotificationObject;
         }
         else if(param1.hasOwnProperty("userId"))
         {
            _loc2_._actorId = param1.userId;
            _loc2_._type = param1.notificationTypeId;
         }
         else
         {
            _loc2_.fromObjectInternal(param1);
         }
         return _loc2_;
      }
      
      private function fromStringInternal(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         if(param1 != "")
         {
            _loc2_ = param1.split(":");
            _loc3_ = [];
            for each(_loc4_ in _loc2_)
            {
               _loc4_ = _loc4_.replace("!#¤",":");
               _loc3_.push(_loc4_);
            }
            this._actorId = int(_loc2_[0]);
            this._type = _loc2_[1] as String;
            if(this.type == "CHAT")
            {
               this.rawObj = {
                  "originalMessage":_loc2_[2],
                  "blacklistedMessage":_loc2_[3],
                  "whitelistedMessage":_loc2_[4]
               };
            }
            else
            {
               this.rawObj = null;
            }
         }
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get actorId() : int
      {
         return this._actorId;
      }
      
      public function get rawObj() : Object
      {
         if(this._notificationObj is INotificationLegacyObject)
         {
            return (this._notificationObj as INotificationLegacyObject).payload;
         }
         return this._notificationObj;
      }
      
      public function set rawObj(param1:Object) : void
      {
         if(param1 is INotificationObject)
         {
            this._notificationObj = param1 as INotificationObject;
         }
         else
         {
            this._notificationObj = this.parseLegacyNotificationObject(param1);
         }
      }
      
      private function parseLegacyNotificationObject(param1:Object) : INotificationObject
      {
         if(param1 != null)
         {
            if(param1.hasOwnProperty("entityType"))
            {
               return this.parseEntityObject(param1);
            }
            return NotificationLegacyObject.create(param1);
         }
         return null;
      }
      
      private function parseEntityObject(param1:Object) : INotificationObject
      {
         return NotificationEntityObject.create(param1.actorId,"",param1.type,param1.entityId,param1.entityType,param1.entitySnapshot);
      }
      
      public function set notificationObject(param1:INotificationObject) : void
      {
         if(param1 != null)
         {
            this._notificationObj = param1;
            this._type = this.notificationObject.notificationTypeId;
            this._actorId = this.notificationObject.userId;
         }
      }
      
      public function get notificationObject() : INotificationObject
      {
         return this._notificationObj;
      }
      
      private function fromByteArrayInternal(param1:ByteArray) : void
      {
         var _loc2_:Object = null;
         if(param1 != null)
         {
            try
            {
               param1.uncompress();
            }
            catch(e:Error)
            {
            }
            _loc2_ = SerializeUtils.deserialize(param1);
            this.rawObj = _loc2_;
            this._actorId = _loc2_.actorId;
            this._type = _loc2_.type;
         }
      }
      
      public function getNotificationType() : NotificationType
      {
         return NotificationType.typeByTypeStr(this.type);
      }
      
      public function toString(param1:String) : String
      {
         return this.actorId + ":" + this.type + ":::::" + param1;
      }
      
      private function getArgs() : Array
      {
         return [this.actorId,this.type];
      }
      
      public function getObject() : Object
      {
         return this.rawObj;
      }
      
      private function fromObjectInternal(param1:Object) : void
      {
         if(param1 != null)
         {
            this._actorId = int(param1.actorId);
            this._type = param1.type;
            this._notificationObj = this.parseLegacyNotificationObject(param1);
         }
      }
      
      public function get serializedString() : String
      {
         return SerializeUtils.serializeToString(this.notificationObject);
      }
      
      public function set serializedString(param1:String) : void
      {
         this.notificationObject = SerializeUtils.deserializeFromString(param1);
      }
   }
}

