package com.moviestarplanet.notifications.model
{
   import com.moviestarplanet.notification.INotificationSystemMessageObject;
   import com.moviestarplanet.notification.NotificationCategory;
   
   public class NotificationSystemMessageObject extends NotificationObject implements INotificationSystemMessageObject
   {
      
      private var _systemMessageType:int;
      
      private var _affectedUserIds:Array;
      
      private var _timestamp:Date;
      
      public function NotificationSystemMessageObject()
      {
         super();
      }
      
      public static function create(param1:int, param2:String, param3:String, param4:int, param5:Array, param6:Date, param7:String = "", param8:int = 1, param9:String = "", param10:String = "") : NotificationSystemMessageObject
      {
         return createAsClass(NotificationSystemMessageObject,param1,param2,param3,param4,param5,param6,param7,NotificationCategory.SYSTEM_MESSAGE,param8,param9,param10);
      }
      
      public static function createAsClass(param1:Class, param2:int, param3:String, param4:String, param5:int, param6:Array, param7:Date, param8:String = "", param9:int = -1, param10:int = 1, param11:String = "", param12:String = "") : NotificationSystemMessageObject
      {
         var _loc13_:NotificationSystemMessageObject = new param1();
         _loc13_.userId = param2;
         _loc13_.userName = param3;
         _loc13_.notificationTypeId = param4;
         _loc13_.systemMessageType = param5;
         _loc13_.affectedUserIds = param6;
         _loc13_.timestamp = param7;
         _loc13_.applicationId = param8;
         _loc13_.notificationCatetoryId = param9;
         _loc13_.importance = param10;
         _loc13_.iconSubPath = param11;
         _loc13_.localizedText = param12;
         return _loc13_;
      }
      
      public function get systemMessageType() : int
      {
         return this._systemMessageType;
      }
      
      public function set systemMessageType(param1:int) : void
      {
         this._systemMessageType = param1;
      }
      
      public function get affectedUserIds() : Array
      {
         return this._affectedUserIds;
      }
      
      public function set affectedUserIds(param1:Array) : void
      {
         this._affectedUserIds = param1;
      }
      
      public function get timestamp() : Date
      {
         return this._timestamp;
      }
      
      public function set timestamp(param1:Date) : void
      {
         this._timestamp = param1;
      }
   }
}

