package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.logging.services.loggingservice.LoggingAmfService;
   
   public class GetLatestErrorCommand
   {
      
      public function GetLatestErrorCommand()
      {
         super();
      }
      
      public static function getLatestError(param1:MsgEvent) : void
      {
         var _loc2_:Function = param1.data.callback;
         var _loc3_:Function = param1.data.errorHandler;
         LoggingAmfService.getLatestServerException(_loc2_,_loc3_);
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(MSPEvent.GET_LATEST_ERROR,getLatestError);
      }
   }
}

