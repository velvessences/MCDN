package com.moviestarplanet.services.wrappers.call
{
   import mx.rpc.events.FaultEvent;
   
   public class RpcFaultHandler
   {
      
      public function RpcFaultHandler()
      {
         super();
      }
      
      public static function faultHandler(param1:FaultEvent) : void
      {
         FaultHandler.handleError(false);
      }
      
      public static function faultHandlerNoLogout(param1:FaultEvent) : void
      {
         FaultHandler.handleError(false);
      }
      
      public static function faultHandlerWithLogout(param1:FaultEvent) : void
      {
         FaultHandler.handleError(true);
      }
      
      public static function noFaultHandler(param1:FaultEvent) : void
      {
      }
   }
}

