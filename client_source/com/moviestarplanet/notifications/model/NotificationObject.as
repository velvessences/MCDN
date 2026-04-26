package com.moviestarplanet.notifications.model
{
   import com.moviestarplanet.notification.INotificationObject;
   
   public class NotificationObject implements INotificationObject
   {
      
      private var _userId:int;
      
      private var _userName:String;
      
      private var _typeId:String;
      
      private var _categoryId:int;
      
      private var _appIs:String;
      
      private var _importance:int;
      
      private var _iconSubPath:String;
      
      private var _localizedText:String;
      
      public function NotificationObject()
      {
         super();
      }
      
      public static function create(param1:int, param2:String, param3:String, param4:String = "", param5:int = -1, param6:int = 1, param7:String = "", param8:String = "") : NotificationObject
      {
         return createAsClass(NotificationObject,param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public static function createAsClass(param1:Class, param2:int, param3:String, param4:String, param5:String = "", param6:int = -1, param7:int = 1, param8:String = "", param9:String = "") : NotificationObject
      {
         var _loc10_:NotificationObject = new param1();
         _loc10_.userId = param2;
         _loc10_.userName = param3;
         _loc10_.notificationTypeId = param4;
         _loc10_.applicationId = param5;
         _loc10_.notificationCatetoryId = param6;
         _loc10_.importance = param7;
         _loc10_.iconSubPath = param8;
         _loc10_.localizedText = param9;
         return _loc10_;
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function get notificationTypeId() : String
      {
         return this._typeId;
      }
      
      public function get notificationCatetoryId() : int
      {
         return this._categoryId;
      }
      
      public function get applicationId() : String
      {
         return this._appIs;
      }
      
      public function get importance() : int
      {
         return this._importance;
      }
      
      public function get iconSubPath() : String
      {
         return this._iconSubPath;
      }
      
      public function get localizedText() : String
      {
         return this._localizedText;
      }
      
      public function set userId(param1:int) : void
      {
         this._userId = param1;
      }
      
      public function set userName(param1:String) : void
      {
         this._userName = param1;
      }
      
      public function set notificationTypeId(param1:String) : void
      {
         this._typeId = param1;
      }
      
      public function set notificationCatetoryId(param1:int) : void
      {
         this._categoryId = param1;
      }
      
      public function set applicationId(param1:String) : void
      {
         this._appIs = param1;
      }
      
      public function set importance(param1:int) : void
      {
         this._importance = param1;
      }
      
      public function set iconSubPath(param1:String) : void
      {
         this._iconSubPath = param1;
      }
      
      public function set localizedText(param1:String) : void
      {
         this._localizedText = param1;
      }
      
      public function get actorId() : int
      {
         return this.userId;
      }
      
      public function get type() : String
      {
         return this.notificationTypeId;
      }
      
      public function set actorId(param1:int) : void
      {
         this.userId = param1;
      }
      
      public function set type(param1:String) : void
      {
         this.notificationTypeId = param1;
      }
   }
}

