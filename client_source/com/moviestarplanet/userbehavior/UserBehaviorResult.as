package com.moviestarplanet.userbehavior
{
   public class UserBehaviorResult
   {
      
      public var isSafe:Boolean;
      
      public var message:String;
      
      public var blacklistedMessage:String;
      
      public var whitelistedMessage:String;
      
      public var timestamp:Number;
      
      public function UserBehaviorResult(param1:Boolean, param2:String, param3:String = null, param4:String = null, param5:Number = NaN)
      {
         super();
         this.isSafe = param1;
         this.message = param2;
         this.blacklistedMessage = param3;
         this.whitelistedMessage = param4;
         this.timestamp = param5;
      }
      
      public function get isUserBehaviorFiltered() : Boolean
      {
         return this.isValid(this.blacklistedMessage) && this.isValid(this.whitelistedMessage);
      }
      
      private function isValid(param1:String) : Boolean
      {
         return param1 != null && param1 != "";
      }
   }
}

