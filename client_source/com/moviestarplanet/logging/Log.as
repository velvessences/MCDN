package com.moviestarplanet.logging
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.LogEvent;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.configurations.IDeviceInfo;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.logging.services.loggingservice.LoggingAmfService;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   
   public class Log
   {
      
      public static const FATAL:String = "FATAL";
      
      public static const ERROR:String = "ERROR";
      
      public static const WARNING:String = "WARNING";
      
      public static const INFO:String = "INFO";
      
      private static var _instance:Log = null;
      
      private var _domain:String;
      
      private var _deviceInfo:IDeviceInfo;
      
      private var _isInitialized:Boolean = true;
      
      private var _functionStack:FunctionStack;
      
      private var _actorId:int = 0;
      
      private var _fingerPrint:String = "";
      
      public function Log(param1:Function = null)
      {
         var _loc2_:String = null;
         var _loc3_:RegExp = null;
         super();
         if(param1 != singletonBlocker)
         {
            throw new Error("Log is a singleton class, use Log.getInstance() instead!");
         }
         if(Config.isCustomBranch())
         {
            this.domain = Config.getDebugCountryOnCustomBranch();
         }
         else
         {
            _loc2_ = ExternalInterface.call("window.location.href.toString");
            _loc3_ = /^(\w+:\/\/)?[\w+.]+(?=(\/|:\d+))/;
            this.domain = _loc2_.match(_loc3_)[0];
         }
         MessageCommunicator.subscribe(MSPEvent.LOGGLY_EVENT,this.onLogEvent);
      }
      
      private static function singletonBlocker() : void
      {
      }
      
      public static function getInstance() : Log
      {
         if(_instance == null)
         {
            _instance = new Log(singletonBlocker);
         }
         return _instance;
      }
      
      public function set domain(param1:String) : void
      {
         while(param1.charAt(param1.length - 1) == "/")
         {
            param1 = param1.substring(0,param1.length - 1);
         }
         this._domain = param1;
      }
      
      public function log(param1:String, param2:String, param3:Object = null) : void
      {
         if(param2 == "ASSET_CANNOT_BE_LOADED" && AppSettings.getInstance().getSetting(AppSettings.LOG_MISSING_ASSETS) == "false")
         {
            return;
         }
         if(!this._isInitialized)
         {
            this._functionStack.push(this,this.log,[param1,param2,param3]);
            return;
         }
         var _loc4_:Object = this.spawnData(param2);
         var _loc5_:Object = new Object();
         _loc5_.MspClient = new Object();
         _loc5_.MspClient.defaultData = _loc4_;
         if(param3 != null)
         {
            _loc5_.MspClient.extraData = param3;
         }
         this.uploadLog(param1,JSON.stringify(_loc5_));
      }
      
      public function setActorId(param1:int) : void
      {
         this._actorId = param1;
      }
      
      public function setFingerPrint(param1:String) : void
      {
         if(param1 == null)
         {
            param1 = "";
         }
         this._fingerPrint = param1;
      }
      
      public function uploadLog(param1:String, param2:String) : void
      {
         LoggingAmfService.logClient(param1,param2);
      }
      
      public function spawnData(param1:String) : Object
      {
         var _loc2_:Object = new Object();
         _loc2_.tag = param1;
         _loc2_.actorId = this._actorId;
         _loc2_.secondsSinceStart = getTimer() / 1000;
         var _loc3_:Object = {
            "os":Capabilities.os,
            "manufacturer":Capabilities.manufacturer,
            "fingerprint":this._fingerPrint
         };
         var _loc4_:Object = {
            "domain":this._domain,
            "store":ConstantsPlatform.store,
            "runtimeVersion":Capabilities.version,
            "isDebugger":Capabilities.isDebugger
         };
         var _loc5_:String = Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY;
         _loc2_.screen = {
            "screenResolution":_loc5_,
            "screenDPI":Capabilities.screenDPI
         };
         _loc2_.game = _loc4_;
         _loc2_.device = _loc3_;
         return _loc2_;
      }
      
      public function onLogEvent(param1:LogEvent) : void
      {
         this.log(param1.getLevel(),param1.getErrorType(),param1.data);
      }
   }
}

