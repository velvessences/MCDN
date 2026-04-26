package com.moviestarplanet.msgservice
{
   public interface IMsgService
   {
      
      function sendMessage(param1:String, param2:Boolean, param3:Array, param4:String = null, param5:Function = null) : void;
      
      function getNewMessagesCount(param1:Function) : void;
      
      function getConversations(param1:Date, param2:int, param3:Function, param4:Function = null) : void;
      
      function getConversation(param1:String, param2:Function, param3:Function = null) : void;
      
      function getMessages(param1:String, param2:Date, param3:int, param4:Function, param5:Function = null) : void;
      
      function getCassandraMessages(param1:String, param2:String, param3:int, param4:Function, param5:Function = null) : void;
      
      function muteConversation(param1:String, param2:Function = null) : void;
      
      function markRead(param1:String, param2:Function = null) : void;
      
      function setConversationHidden(param1:String, param2:Function = null) : void;
      
      function createConversation(param1:Array, param2:String = "", param3:Function = null, param4:Function = null) : void;
      
      function leaveConversation(param1:String, param2:Function = null) : void;
      
      function addUsersToConversation(param1:String, param2:Array, param3:Function = null) : void;
      
      function getActiveGroupConversations(param1:Array, param2:Function, param3:Function = null) : void;
      
      function getUserConversationStates(param1:Function, param2:Function = null) : void;
      
      function renameConversation(param1:String, param2:String, param3:Function = null, param4:Function = null) : void;
   }
}

