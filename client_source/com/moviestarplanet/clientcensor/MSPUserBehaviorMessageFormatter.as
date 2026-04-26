package com.moviestarplanet.clientcensor
{
   import com.moviestarplanet.globalsharedutils.messaging.MessageStyleUtility;
   import com.moviestarplanet.userbehavior.IUserBehaviorMessageFormatter;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   
   public class MSPUserBehaviorMessageFormatter extends UserBehaviorMessageFormatter implements IUserBehaviorMessageFormatter
   {
      
      public function MSPUserBehaviorMessageFormatter()
      {
         super();
      }
      
      override public function embedFilteredMessages(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:uint = 0;
         if(param1 != null && MessageStyleUtility.containsFontCode(param1))
         {
            _loc4_ = MessageStyleUtility.extractFontCodeParameters(param1);
            if(param3 != null)
            {
               param3 = MessageStyleUtility.removeAndAddFontCode(param3,_loc4_);
            }
            if(param2 != null)
            {
               param2 = MessageStyleUtility.removeAndAddFontCode(param2,_loc4_);
            }
         }
         return super.embedFilteredMessages(param1,param2,param3);
      }
      
      public function removeAndAddFontCodeUserBehaviorResult(param1:UserBehaviorResult, param2:int) : UserBehaviorResult
      {
         var userBehaviorResult:UserBehaviorResult = param1;
         var fontCode:int = param2;
         var internalRemoveAddFontCode:Function = function(param1:String):String
         {
            if(param1)
            {
               if(param1 == "")
               {
                  throw new Error("Filtered message should not be blank!");
               }
               return MessageStyleUtility.removeAndAddFontCode(param1,fontCode);
            }
            return null;
         };
         userBehaviorResult.message = internalRemoveAddFontCode(userBehaviorResult.message);
         userBehaviorResult.blacklistedMessage = internalRemoveAddFontCode(userBehaviorResult.blacklistedMessage);
         userBehaviorResult.whitelistedMessage = internalRemoveAddFontCode(userBehaviorResult.whitelistedMessage);
         return userBehaviorResult;
      }
   }
}

