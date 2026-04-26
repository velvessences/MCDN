package com.moviestarplanet.userbehavior.services
{
   import com.moviestarplanet.userbehavior.utils.IUserBehaviourService;
   
   public class UserBehaviorServiceProvider implements IUserBehaviourService
   {
      
      private static var _instance:UserBehaviorServiceProvider = null;
      
      public function UserBehaviorServiceProvider(param1:Function = null)
      {
         super();
         if(param1 != singletonBlocker)
         {
            throw new Error("UserBehaviorServiceProvider is a singleton class, use UserBehaviorServiceProvider.getInstance() instead!");
         }
      }
      
      private static function singletonBlocker() : void
      {
      }
      
      public static function getInstance() : UserBehaviorServiceProvider
      {
         if(_instance == null)
         {
            _instance = new UserBehaviorServiceProvider(singletonBlocker);
         }
         return _instance;
      }
      
      public function messageEvaluate(param1:int, param2:String, param3:int, param4:String, param5:int, param6:Boolean, param7:int, param8:String, param9:Function, param10:Function) : void
      {
         var doneCallback:Function = null;
         var evaluateType:int = param1;
         var messageId:String = param2;
         var senderId:int = param3;
         var receiverId:String = param4;
         var receiverType:int = param5;
         var isLogging:Boolean = param6;
         var senderEvaluateType:int = param7;
         var message:String = param8;
         var resultCallback:Function = param9;
         var failCallback:Function = param10;
         doneCallback = function(param1:Object):void
         {
            resultCallback(param1);
         };
         UserBehaviorAmfService.messageEvaluate(evaluateType,messageId,senderId,receiverId,receiverType,isLogging,senderEvaluateType,message,doneCallback,failCallback);
      }
      
      public function nameEvaluate(param1:String, param2:Function) : void
      {
         var doneCallback:Function = null;
         var name:String = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            resultCallback(param1);
         };
         UserBehaviorAmfService.nameEvaluate(name,doneCallback);
      }
      
      public function logUserBehavior(param1:String, param2:int, param3:String = null) : void
      {
         UserBehaviorAmfService.logEventService(param1,param2,param3);
      }
   }
}

