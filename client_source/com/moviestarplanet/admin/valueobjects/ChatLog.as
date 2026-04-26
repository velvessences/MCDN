package com.moviestarplanet.admin.valueobjects
{
   public class ChatLog
   {
      
      public var ChatLogId:Number;
      
      public var RoomId:int;
      
      public var ActorId:int;
      
      public var Message:String;
      
      public var _Date:Date;
      
      public var IpAsInt:int;
      
      public var DaysLocked:int;
      
      public var DateHandled:Date;
      
      public var HandledByActorId:int;
      
      public var RoomInstanceId:int;
      
      public function ChatLog()
      {
         super();
      }
   }
}

