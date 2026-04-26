package com.moviestarplanet.logging.services.loggingservice
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.utils.VersionUtils;
   import com.moviestarplanet.version.CheckVersion;
   
   public class LoggingAmfService
   {
      
      public static var enableClientExceptionLogging:Boolean;
      
      private static var _instance:LoggingAmfService;
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Logging.AMFLoggingService");
      
      public static var actorId:int = -1;
      
      public function LoggingAmfService()
      {
         super();
      }
      
      private static function get instance() : LoggingAmfService
      {
         if(_instance == null)
         {
            _instance = new LoggingAmfService();
         }
         return _instance;
      }
      
      public static function Debug(param1:String, param2:Function = null) : void
      {
         log("debug",param1,param2);
      }
      
      public static function Error(param1:String, param2:Function = null) : void
      {
         MessageCommunicator.send(new MsgEvent(MSPEvent.DEBUG_ALERT,param1));
         if(enableClientExceptionLogging)
         {
            log("error",param1,param2);
         }
      }
      
      public static function log(param1:String, param2:String, param3:Function = null, param4:Boolean = false) : void
      {
         var _loc5_:String = "mobile";
         var _loc6_:String = "mobile";
         if(!param4)
         {
            _loc5_ = VersionUtils.getSwfVersion(false);
            _loc6_ = VersionUtils.browserVersion;
         }
         param2 += "\n ActorId: " + actorId + " Client: " + _loc5_ + " Flash: " + VersionUtils.flashPlayerVersion + " Browser: " + _loc6_;
         amfCaller.callFunction("ClientLog",[param1,param2],true,param3);
      }
      
      public static function logClient(param1:String, param2:String, param3:Function = null, param4:Function = null) : void
      {
         amfCaller.callFunction("LogClient",[param1,param2],false,param3,param4);
      }
      
      public static function createTestException() : void
      {
         amfCaller.callFunction("CreateTestException",[],true,null);
      }
      
      public static function getLatestServerException(param1:Function, param2:Function) : void
      {
         var latestServerExceptionDone:Function = null;
         var callback:Function = param1;
         var errorHandler:Function = param2;
         latestServerExceptionDone = function(param1:Object):void
         {
            MessageCommunicator.sendMessage(MSPEvent.CHECK_VERSION,new CheckVersion(param1.Version));
            if(callback != null)
            {
               callback(param1.Exception);
            }
         };
         amfCaller.callFunction("GetLatestServerException",[],true,latestServerExceptionDone,errorHandler);
      }
   }
}

