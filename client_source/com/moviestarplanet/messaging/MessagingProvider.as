package com.moviestarplanet.messaging
{
   public class MessagingProvider
   {
      
      [Inject]
      public static var messagingService:IMessagingService;
      
      public function MessagingProvider()
      {
         super();
      }
      
      public static function SetMessengerSession(param1:int, param2:Function, param3:Function) : void
      {
         var success:Function = null;
         var fail:Function = null;
         var actorId:int = param1;
         var successCallback:Function = param2;
         var failCallback:Function = param3;
         success = function(param1:*):void
         {
            successCallback(param1);
         };
         fail = function(param1:*):void
         {
            failCallback(param1);
         };
         messagingService.SetMessengerSession(actorId,success,fail);
      }
   }
}

