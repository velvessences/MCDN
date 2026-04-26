package com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission
{
   import flash.events.Event;
   
   public class ChatPermissionEvent extends Event
   {
      
      public static var CHAT_PERMISSION_UPDATE:String = "CHAT_PERMISSION_UPDATE";
      
      public static var CHAT_PERMISSION_READY:String = "CHAT_PERMISSION_READY";
      
      public static var TIME_RUNNING_OUT:String = "TIME_RUNNING_OUT";
      
      public function ChatPermissionEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

