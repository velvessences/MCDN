package com.moviestarplanet.chatrooms.model
{
   import com.moviestarplanet.notifications.model.NotificationObject;
   
   public class NotificationChatromObject extends NotificationObject
   {
      
      public var roomIdOnlyId:int;
      
      public var houseOwnerName:String;
      
      public var roomId:String;
      
      public var roomSection:int;
      
      public function NotificationChatromObject()
      {
         super();
      }
      
      public static function create(param1:int, param2:String, param3:String, param4:String, param5:String = "", param6:int = -1, param7:int = 0) : NotificationChatromObject
      {
         var _loc8_:NotificationChatromObject = NotificationObject.createAsClass(NotificationChatromObject,param1,param2,param3) as NotificationChatromObject;
         _loc8_.userId = param1;
         _loc8_.userName = param2;
         _loc8_.notificationTypeId = param3;
         _loc8_.roomId = param4;
         _loc8_.houseOwnerName = param5;
         _loc8_.roomIdOnlyId = param6;
         _loc8_.roomSection = param7;
         return _loc8_;
      }
   }
}

