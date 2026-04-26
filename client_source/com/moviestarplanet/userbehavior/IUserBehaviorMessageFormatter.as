package com.moviestarplanet.userbehavior
{
   public interface IUserBehaviorMessageFormatter
   {
      
      function getFilteredMessageFromEmbeddedString(param1:String, param2:int = 0) : String;
      
      function getFilteredMessageFromUserBehaviorResult(param1:UserBehaviorResult, param2:int = 0) : String;
      
      function getFilteredMessageFromStrings(param1:String, param2:String, param3:String, param4:int = 0) : String;
      
      function embedFilteredMessages(param1:String, param2:String, param3:String) : String;
      
      function embedFilteredMessages2(param1:String, param2:UserBehaviorResult) : String;
      
      function embedFilteredMessages3(param1:UserBehaviorResult) : String;
   }
}

