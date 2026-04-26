package com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol
{
   import com.moviestarplanet.userbehavior.IRedifyableTextInputComponent;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.userbehavior.valueObjects.EvaluateResponse;
   
   internal class BlacklistHandling extends FilterlistHandlingBase
   {
      
      public function BlacklistHandling()
      {
         super();
      }
      
      public function execute(param1:IRedifyableTextInputComponent, param2:Function, param3:int, param4:String, param5:int, param6:Boolean, param7:Function = null) : void
      {
         _latestCallInfo = new UserBehaviorCallInfo(param1,param2,param7);
         userBehaviourServiceProvider.messageEvaluate(2,_latestCallInfo.callId.toString(),param3,param4,param5,param6,FilterType.BLACK,param1.text,this.userBehaviorServiceCallback,param7);
      }
      
      private function userBehaviorServiceCallback(param1:EvaluateResponse) : void
      {
         var _loc2_:String = null;
         var _loc3_:Function = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         if(_latestCallInfo != null)
         {
            if(param1 == null)
            {
               throw new Error("Error: UserBehavior: Server is sending wrong data");
            }
            _loc2_ = _latestCallInfo.textInputField.text;
            _loc3_ = _latestCallInfo.callback;
            if(UserBehaviorControl.localCensor.isModerator)
            {
               _loc3_(new UserBehaviorResult(true,_loc2_,_loc2_,_loc2_));
            }
            else
            {
               _loc4_ = new Array();
               _loc5_ = "";
               _loc6_ = "";
               _loc7_ = param1.FilteredResponses;
               if(_loc7_ == null)
               {
                  _latestCallInfo.failCallback();
               }
               else
               {
                  _loc8_ = 0;
                  while(_loc8_ < _loc7_.length)
                  {
                     _loc9_ = _loc7_[_loc8_];
                     if(_loc9_.EvaluateType == 0)
                     {
                        _loc5_ = _loc9_.FilteredString;
                     }
                     else if(_loc9_.EvaluateType == 1)
                     {
                        _loc6_ = _loc9_.FilteredString;
                     }
                     if(_loc9_.EvaluateType == 2)
                     {
                        _loc6_ = _loc9_.FilteredString;
                     }
                     _loc8_++;
                  }
                  _loc3_(new UserBehaviorResult(true,_loc2_,_loc5_,_loc6_,param1.Timestamp));
               }
            }
            _latestCallInfo.clear();
            _latestCallInfo = null;
         }
      }
   }
}

