package com.moviestarplanet.notifications.model
{
   import com.moviestarplanet.notification.INotificationChatObject;
   import com.moviestarplanet.notification.NotificationCategory;
   
   public class NotificationChatObject extends NotificationObject implements INotificationChatObject
   {
      
      private var _conversationId:String;
      
      private var _conversationName:String;
      
      private var _blacklistedMessage:String;
      
      private var _whitelistedMessage:String;
      
      private var _originalMessage:String;
      
      private var _affectedUserIds:Array;
      
      private var _timestamp:Date;
      
      public function NotificationChatObject()
      {
         super();
      }
      
      public static function create(param1:int, param2:String, param3:String, param4:String, param5:String = "", param6:String = "", param7:String = "", param8:Array = null, param9:String = "", param10:int = 1, param11:String = "", param12:String = "") : NotificationChatObject
      {
         var _loc13_:NotificationChatObject = NotificationObject.createAsClass(NotificationChatObject,param1,param2,param3,param9,NotificationCategory.CHAT,param10,param11,param12) as NotificationChatObject;
         _loc13_.conversationId = param4;
         _loc13_.blacklistedMessage = param5;
         _loc13_.whitelistedMessage = param6;
         _loc13_.originalMessage = param7;
         _loc13_.affectedUserIds = param8;
         return _loc13_;
      }
      
      public function get conversationId() : String
      {
         return this._conversationId;
      }
      
      public function set conversationId(param1:String) : void
      {
         this._conversationId = param1;
      }
      
      public function get blacklistedMessage() : String
      {
         return this._blacklistedMessage;
      }
      
      public function set blacklistedMessage(param1:String) : void
      {
         this._blacklistedMessage = param1;
      }
      
      public function get whitelistedMessage() : String
      {
         return this._whitelistedMessage;
      }
      
      public function set whitelistedMessage(param1:String) : void
      {
         this._whitelistedMessage = param1;
      }
      
      public function get originalMessage() : String
      {
         return this._originalMessage;
      }
      
      public function set originalMessage(param1:String) : void
      {
         this._originalMessage = param1;
      }
      
      public function get conversationName() : String
      {
         return this._conversationName;
      }
      
      public function set conversationName(param1:String) : void
      {
         this._conversationName = param1;
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

