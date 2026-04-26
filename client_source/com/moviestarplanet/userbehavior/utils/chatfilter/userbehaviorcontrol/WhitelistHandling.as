package com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol
{
   import com.moviestarplanet.userbehavior.IRedifyableTextInputComponent;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.userbehavior.utils.UserBehaviorStringUtilities;
   import com.moviestarplanet.userbehavior.valueObjects.EvaluateResponse;
   import flash.utils.Dictionary;
   
   public class WhitelistHandling extends FilterlistHandlingBase
   {
      
      private static var instance:WhitelistHandling;
      
      private var _userBehaviorCallInfos:Dictionary = new Dictionary();
      
      private var _userBehaviorCallInfoKeys:Dictionary = new Dictionary();
      
      private var _isLockedForSendingCall:Boolean = false;
      
      public function WhitelistHandling(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : WhitelistHandling
      {
         if(instance == null)
         {
            instance = new WhitelistHandling(new SingletonEnforcer());
         }
         return instance;
      }
      
      public function checkListAndRetrieveFilteredMessages(param1:IRedifyableTextInputComponent, param2:int, param3:Function, param4:int, param5:String, param6:int, param7:Boolean, param8:Function) : void
      {
         this._isLockedForSendingCall = true;
         this.redifyBadWords(param1,param2,param3,param4,param5,param6,param7,param8,true);
      }
      
      public function redifyBadWords(param1:IRedifyableTextInputComponent, param2:int = 1, param3:Function = null, param4:int = -2000, param5:String = "-3000", param6:int = -4000, param7:Boolean = false, param8:Function = null, param9:Boolean = false) : void
      {
         var _loc11_:int = 0;
         var _loc12_:UserBehaviorCallInfo = null;
         var _loc13_:UserBehaviorCallInfo = null;
         if(!param9 && this._isLockedForSendingCall)
         {
            return;
         }
         var _loc10_:String = param1.text;
         if(this._userBehaviorCallInfoKeys[param1] != null)
         {
            _loc11_ = int(this._userBehaviorCallInfoKeys[param1]);
            _loc12_ = this._userBehaviorCallInfos[_loc11_];
            _loc12_.clear();
            delete this._userBehaviorCallInfos[_loc11_];
            delete this._userBehaviorCallInfoKeys[param1];
         }
         if(UserBehaviorStringUtilities.isEmpty(_loc10_))
         {
            param1.removeRedified();
            if(this._isLockedForSendingCall)
            {
               param3(new UserBehaviorResult(false,_loc10_));
               this._isLockedForSendingCall = false;
            }
         }
         else if(this.isWordOrSubmitToCheck(_loc10_))
         {
            _loc13_ = new UserBehaviorCallInfo(param1,param3,param8);
            this._userBehaviorCallInfos[_loc13_.callId] = _loc13_;
            this._userBehaviorCallInfoKeys[param1] = _loc13_.callId;
            if(UserBehaviorControl.localCensor.isModerator)
            {
               param2 = FilterType.MODERATOR;
            }
            userBehaviourServiceProvider.messageEvaluate(param2,_loc13_.callId.toString(),param4,param5,param6,param7,FilterType.WHITE,_loc10_,this.doRedifyOnArea,param8);
         }
      }
      
      private function isWordOrSubmitToCheck(param1:String) : Boolean
      {
         if(!this._isLockedForSendingCall)
         {
            return this.isNewWordToCheck(param1);
         }
         return true;
      }
      
      private function isNewWordToCheck(param1:String) : Boolean
      {
         var _loc2_:RegExp = /(\w+)(\.|,|\:|;|!| |\r|\n|\\|\/|-|\?|\(|\)|\[|\]|%)/gi;
         if(_loc2_.test(param1))
         {
            return true;
         }
         return false;
      }
      
      private function doRedifyOnArea(param1:EvaluateResponse) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:UserBehaviorCallInfo = null;
         var _loc7_:IRedifyableTextInputComponent = null;
         var _loc8_:Function = null;
         var _loc9_:Array = null;
         var _loc10_:Boolean = false;
         var _loc11_:int = 0;
         var _loc12_:Object = null;
         var _loc13_:Array = null;
         var _loc14_:Boolean = false;
         if(param1 == null)
         {
            throw new Error("Error: UserBehavior: Server is sending wrong data");
         }
         _loc2_ = 0;
         _loc3_ = "";
         _loc4_ = "";
         _loc5_ = param1.MessageId;
         if(this._userBehaviorCallInfos[_loc5_])
         {
            _loc6_ = this._userBehaviorCallInfos[_loc5_];
            _loc7_ = _loc6_.textInputField;
            if(_loc6_.callback != null)
            {
               _loc8_ = _loc6_.callback;
            }
            _loc7_.removeRedified();
            _loc9_ = param1.FilteredResponses;
            if(_loc9_ == null)
            {
               _loc6_.failCallback();
            }
            else
            {
               _loc10_ = false;
               _loc11_ = 0;
               while(_loc11_ < _loc9_.length)
               {
                  _loc12_ = _loc9_[_loc11_];
                  if(_loc12_.Result as int > _loc2_)
                  {
                     _loc2_ = int(_loc12_.Result);
                  }
                  if(_loc12_.EvaluateType == FilterType.BLACK)
                  {
                     _loc3_ = _loc12_.FilteredString;
                  }
                  else if(_loc12_.EvaluateType == FilterType.WHITE)
                  {
                     _loc4_ = _loc12_.FilteredString;
                  }
                  if(_loc12_.EvaluateType == FilterType.BOTH)
                  {
                     _loc4_ = _loc12_.FilteredString;
                  }
                  if(_loc7_.text == _loc6_.sentMessage)
                  {
                     if(_loc4_ != "")
                     {
                        _loc13_ = getParts(_loc6_.sentMessage,_loc4_);
                     }
                     if(_loc13_ != null && _loc13_.length > 0)
                     {
                        _loc7_.doRedify(_loc13_);
                     }
                  }
                  else
                  {
                     _loc10_ = true;
                  }
                  _loc11_++;
               }
               if(this._isLockedForSendingCall)
               {
                  this._isLockedForSendingCall = false;
                  if(_loc10_)
                  {
                     if(_loc8_ != null)
                     {
                        _loc8_(new UserBehaviorResult(false,_loc6_.sentMessage));
                     }
                  }
                  else
                  {
                     _loc14_ = false;
                     if(_loc2_ == 0)
                     {
                        _loc14_ = true;
                     }
                     if(_loc8_ != null)
                     {
                        _loc8_(new UserBehaviorResult(_loc14_,_loc6_.sentMessage,_loc3_,_loc4_));
                     }
                  }
               }
            }
            _loc6_.clear();
            delete this._userBehaviorCallInfos[_loc5_];
            delete this._userBehaviorCallInfoKeys[_loc7_];
         }
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
