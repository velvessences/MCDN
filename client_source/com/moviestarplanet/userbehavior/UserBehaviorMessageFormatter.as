package com.moviestarplanet.userbehavior
{
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.UserBehaviorControl;
   
   public class UserBehaviorMessageFormatter implements IUserBehaviorMessageFormatter
   {
      
      private static var instance:IUserBehaviorMessageFormatter;
      
      private const CODE_CHAR:String = String.fromCharCode(29);
      
      private const INTERNAL_SEPERATOR:String = String.fromCharCode(31);
      
      public function UserBehaviorMessageFormatter()
      {
         super();
      }
      
      public static function getInstance() : IUserBehaviorMessageFormatter
      {
         if(instance == null)
         {
            instance = InjectionManager.mapper().getInstance(IUserBehaviorMessageFormatter);
         }
         return instance;
      }
      
      private function getEmbeddedFilteredMessage(param1:String) : Object
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(this.containsCodeChar(param1,this.CODE_CHAR))
         {
            _loc3_ = param1.indexOf(this.CODE_CHAR) + 1;
            _loc4_ = int(param1.lastIndexOf(this.CODE_CHAR));
            _loc5_ = param1.substring(_loc3_,_loc4_);
            _loc6_ = _loc5_.split(this.INTERNAL_SEPERATOR);
            _loc7_ = _loc6_.length > 0 ? _loc6_[0] : null;
            _loc8_ = _loc6_.length > 1 ? _loc6_[1] : null;
            if(this.isValid(_loc7_) && this.isValid(_loc8_))
            {
               return {
                  "whitelistedMessage":_loc8_,
                  "blacklistedMessage":_loc7_
               };
            }
         }
         return null;
      }
      
      private function isValid(param1:String) : Boolean
      {
         return param1 != null && param1 != "";
      }
      
      private function containsCodeChar(param1:String, param2:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:int = int(param1.indexOf(param2));
         var _loc4_:int = int(param1.lastIndexOf(param2));
         if(_loc3_ < 0 || _loc4_ > param1.length || _loc3_ > _loc4_)
         {
            return false;
         }
         return true;
      }
      
      public function getFilteredMessageFromEmbeddedString(param1:String, param2:int = 0) : String
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:Object = this.getEmbeddedFilteredMessage(param1);
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.blacklistedMessage;
            _loc6_ = _loc4_.whitelistedMessage;
         }
         return this.getFilteredMessageFromStrings(_loc5_,_loc6_,param1);
      }
      
      public function getFilteredMessageFromUserBehaviorResult(param1:UserBehaviorResult, param2:int = 0) : String
      {
         return this.getFilteredMessageFromStrings(param1.blacklistedMessage,param1.whitelistedMessage,param1.message);
      }
      
      public function getFilteredMessageFromStrings(param1:String, param2:String, param3:String, param4:int = 0) : String
      {
         var _loc5_:String = null;
         if(UserBehaviorControl.localCensor != null && UserBehaviorControl.localCensor.whitelistEnabled)
         {
            if(param2)
            {
               _loc5_ = param2;
            }
         }
         else if(param1)
         {
            _loc5_ = param1;
         }
         if(_loc5_ == null && param3 != null && param3 != "")
         {
            if(UserBehaviorControl.localCensor != null)
            {
               _loc5_ = UserBehaviorControl.localCensor.censorText(param3,param4);
            }
         }
         if(_loc5_ == null)
         {
            _loc5_ = "";
         }
         return _loc5_;
      }
      
      public function embedFilteredMessages(param1:String, param2:String, param3:String) : String
      {
         if(this.isValid(param3) && this.isValid(param2))
         {
            return this.CODE_CHAR + param3 + this.INTERNAL_SEPERATOR + param2 + this.CODE_CHAR;
         }
         return param1;
      }
      
      public function embedFilteredMessages2(param1:String, param2:UserBehaviorResult) : String
      {
         return this.embedFilteredMessages(param1,param2.whitelistedMessage,param2.blacklistedMessage);
      }
      
      public function embedFilteredMessages3(param1:UserBehaviorResult) : String
      {
         return this.embedFilteredMessages(param1.message,param1.whitelistedMessage,param1.blacklistedMessage);
      }
   }
}

