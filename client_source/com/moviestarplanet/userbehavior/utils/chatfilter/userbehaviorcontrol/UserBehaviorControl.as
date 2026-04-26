package com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol
{
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.userbehavior.ICensor;
   import com.moviestarplanet.userbehavior.IRedifyableTextInputComponent;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.userbehavior.services.UserBehaviorAmfService;
   import com.moviestarplanet.userbehavior.services.UserBehaviorServiceProvider;
   import com.moviestarplanet.userbehavior.utils.UserBehaviorStringUtilities;
   
   public class UserBehaviorControl
   {
      
      public static var localCensor:ICensor;
      
      private static var instance:UserBehaviorControl;
      
      public static const USER_BEHAVIOR_FAILURE:String = "UserBehaviorControl.USER_BEHAVIOR_FAILURE";
      
      private var _useUserBehaviorServiceNameFiltering:Boolean = false;
      
      private var _whiteListHandling:WhitelistHandling;
      
      public function UserBehaviorControl(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
         this._whiteListHandling = WhitelistHandling.getInstance();
      }
      
      public static function getInstance() : UserBehaviorControl
      {
         if(instance == null)
         {
            instance = new UserBehaviorControl(new SingletonEnforcer());
         }
         return instance;
      }
      
      public function inputUserBehaviorFilterAndLog(param1:IRedifyableTextInputComponent, param2:Function, param3:int, param4:String, param5:int, param6:Boolean = true, param7:Boolean = true, param8:Boolean = false, param9:Function = null) : void
      {
         var intermediaryCallback:Function = null;
         var userBehaviorFailed:Function = null;
         var inputControl:IRedifyableTextInputComponent = param1;
         var userBehaviorCallback:Function = param2;
         var senderId:int = param3;
         var receiverId:String = param4;
         var receiverType:int = param5;
         var isLogging:Boolean = param6;
         var isExtremeFiltered:Boolean = param7;
         var checkIsMuted:Boolean = param8;
         var failCallback:Function = param9;
         intermediaryCallback = function(param1:UserBehaviorResult):void
         {
            inputControl.enableUserInput();
            if(userBehaviorCallback != null)
            {
               userBehaviorCallback(param1);
            }
         };
         userBehaviorFailed = function():void
         {
            MessageCommunicator.sendMessage(USER_BEHAVIOR_FAILURE,null);
            inputControl.enableUserInput();
            if(failCallback != null)
            {
               failCallback();
            }
         };
         if(inputControl.isEnabled)
         {
            inputControl.disableUserInput();
            inputControl.text = UserBehaviorStringUtilities.cleanHTMLCode(inputControl.text);
            if(UserBehaviorStringUtilities.isEmpty(inputControl.text) || checkIsMuted && UserBehaviorControl.localCensor.userMuted || UserBehaviorControl.localCensor.containsPassword(inputControl.text) != 0)
            {
               intermediaryCallback(new UserBehaviorResult(false,inputControl.text));
            }
            else if(this.whiteListEnabled)
            {
               this._whiteListHandling.checkListAndRetrieveFilteredMessages(inputControl,FilterType.BOTH,intermediaryCallback,senderId,receiverId,receiverType,isLogging,userBehaviorFailed);
            }
            else
            {
               new BlacklistHandling().execute(inputControl,intermediaryCallback,senderId,receiverId,receiverType,isLogging,userBehaviorFailed);
            }
         }
      }
      
      public function blacklistFilter(param1:IRedifyableTextInputComponent, param2:Function, param3:Function, param4:int, param5:String, param6:int) : void
      {
         var intermediaryCallback:Function = null;
         var onUserBehaviorFail:Function = null;
         var inputControl:IRedifyableTextInputComponent = param1;
         var userBehaviorCallback:Function = param2;
         var failCallback:Function = param3;
         var senderId:int = param4;
         var receiverId:String = param5;
         var receiverType:int = param6;
         intermediaryCallback = function(param1:UserBehaviorResult):void
         {
            if(param1.blacklistedMessage != null)
            {
               if(UserBehaviorControl.localCensor.containsPassword(inputControl.text) == 0)
               {
                  param1.isSafe = false;
               }
               userBehaviorCallback(param1);
            }
            else
            {
               onUserBehaviorFail();
            }
         };
         onUserBehaviorFail = function():void
         {
            failCallback();
         };
         inputControl.text = UserBehaviorStringUtilities.cleanHTMLCode(inputControl.text);
         new BlacklistHandling().execute(inputControl,intermediaryCallback,senderId,receiverId,receiverType,true,onUserBehaviorFail);
      }
      
      public function userBehaviorLog(param1:String, param2:int, param3:String = null) : void
      {
         UserBehaviorServiceProvider.getInstance().logUserBehavior(param1,param2,param3);
      }
      
      public function submitUGC(param1:int, param2:int, param3:int, param4:Array, param5:String = "") : void
      {
         UserBehaviorAmfService.submitUGC(param1,param2,param3,param4,param5);
      }
      
      public function reportAbuse(param1:int, param2:int, param3:String, param4:String) : void
      {
         UserBehaviorAmfService.reportAbuse(param1,param2,param3,param4);
      }
      
      public function get useUserBehaviorServiceNameFiltering() : Boolean
      {
         return this._useUserBehaviorServiceNameFiltering;
      }
      
      public function set useUserBehaviorServiceNameFiltering(param1:Boolean) : void
      {
         this._useUserBehaviorServiceNameFiltering = param1;
      }
      
      public function get whiteListEnabled() : Boolean
      {
         return UserBehaviorControl.localCensor.whitelistEnabled;
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
