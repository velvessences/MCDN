package com.moviestarplanet.services.wrappers.call
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.msg.MsgInject;
   
   public class FaultHandler
   {
      
      public static var faultLogging:Boolean = true;
      
      public function FaultHandler()
      {
         super();
      }
      
      public static function handleErrorWithObject(param1:Object = null) : void
      {
         handleError(false);
      }
      
      public static function handleError(param1:Boolean = false) : void
      {
         var localFaultHandler:Function;
         var done:Function;
         var doLogOut:Boolean = param1;
         if(MsgInject.isModerator && faultLogging)
         {
            localFaultHandler = function(param1:Object):void
            {
               done("Could not get error details from server.");
            };
            done = function(param1:String):void
            {
               MessageCommunicator.send(new MsgEvent(MSPEvent.ERROR_ALERT,{
                  "msg":param1,
                  "logout":doLogOut
               }));
            };
            MessageCommunicator.send(new MsgEvent(MSPEvent.GET_LATEST_ERROR,{
               "callback":done,
               "errorHandler":localFaultHandler
            }));
         }
         else if(doLogOut)
         {
            MessageCommunicator.send(new MsgEvent(MSPEvent.DO_LOGOUT));
         }
      }
   }
}

