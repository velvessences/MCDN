package com.moviestarplanet.notification
{
   public interface INotificationChatObject extends INotificationObject
   {
      
      function get conversationId() : String;
      
      function get conversationName() : String;
      
      function get blacklistedMessage() : String;
      
      function get whitelistedMessage() : String;
      
      function get originalMessage() : String;
      
      function get timestamp() : Date;
      
      function set timestamp(param1:Date) : void;
   }
}

