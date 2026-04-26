package com.moviestarplanet.logging
{
   import com.moviestarplanet.logging.services.loggingservice.LoggingAmfService;
   import flash.display.LoaderInfo;
   import flash.events.UncaughtErrorEvent;
   import mx.managers.ISystemManager;
   
   public class UncaughtErrorHandler
   {
      
      private static var loaderInfo:LoaderInfo;
      
      private var service:LoggingAmfService;
      
      public function UncaughtErrorHandler()
      {
         super();
         loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.uncaughtErrorHandler);
      }
      
      public static function init(param1:ISystemManager) : void
      {
         loaderInfo = param1.loaderInfo;
      }
      
      private function uncaughtErrorHandler(param1:UncaughtErrorEvent) : void
      {
         var _loc2_:Error = param1.error;
         var _loc3_:String = String.fromCharCode(10);
         var _loc4_:String = "[Client Uncaught Error] errorID:" + _loc2_.errorID + " name:" + _loc2_.name + " message:" + _loc2_.message + _loc3_ + _loc2_.getStackTrace();
         LoggingAmfService.Error(_loc4_);
      }
   }
}

