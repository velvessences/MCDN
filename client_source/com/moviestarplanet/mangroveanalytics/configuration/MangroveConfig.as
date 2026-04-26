package com.moviestarplanet.mangroveanalytics.configuration
{
   import com.moviestarplanet.mangroveanalytics.context.MangroveBaseUserContext;
   import com.moviestarplanet.mangroveanalytics.context.MobileContext;
   import com.moviestarplanet.mangroveanalytics.context.boonieplanet.UserContextBP;
   import com.moviestarplanet.mangroveanalytics.context.moviestarplanet.UserContextMSP;
   import com.moviestarplanet.mangroveanalytics.context.roboblastplanet.UserContextRBP;
   import com.moviestarplanet.mangroveanalytics.event.SessionEndEvent;
   import com.moviestarplanet.mangroveanalytics.event.SessionStartEvent;
   import com.moviestarplanet.mangroveanalytics.testgui.MangroveTestUI;
   import com.moviestarplanet.mangroveanalytics.utilities.MangroveConfigUtils;
   import com.moviestarplanet.mangroveanalytics.utilities.MangroveStringUtils;
   import com.moviestarplanet.mangroveanalytics.valueobjects.MangroveBaseDetails;
   import com.moviestarplanet.mangroveanalytics.valueobjects.boonieplanet.MangroveBoonieDetails;
   import com.moviestarplanet.mangroveanalytics.valueobjects.moviestarplanet.MangroveActorDetails;
   import com.moviestarplanet.mangroveanalytics.valueobjects.roboblastplanet.MangroveRoboblastDetails;
   import com.snowplowanalytics.snowplow.tracker.Tracker;
   import com.snowplowanalytics.snowplow.tracker.Util;
   import com.snowplowanalytics.snowplow.tracker.emitter.Emitter;
   import com.snowplowanalytics.snowplow.tracker.event.EmitterEvent;
   import flash.utils.Dictionary;
   
   public class MangroveConfig
   {
      
      public static const DEFAULT_EMITTER_URL:String = "collector.analyticsmsp.com";
      
      public static const DEFAULT_EMITTER_PROTOCOL:String = "http";
      
      public static const DEFAULT_APP_NAMESPACE:String = "MovieStarPlanet";
      
      public static const DEFAULT_BUFFER_SIZE:int = 5;
      
      protected static var _appId:String;
      
      protected static var _appNamespace:String;
      
      protected static var _base64Encode:Boolean = true;
      
      protected static var _eventBufferSize:int = 5;
      
      protected static var _emitterURL:String = "collector.analyticsmsp.com";
      
      protected static var _disabledSchemas:Dictionary;
      
      protected static var _mangroveUserId:String;
      
      protected static var _basicInfoSetup:Boolean = false;
      
      protected static var _userInfoSetup:Boolean = false;
      
      protected static var _userContextSetup:Boolean = false;
      
      protected static var _mangroveInitialized:Boolean = false;
      
      protected static var _mangroveUserContext:MangroveBaseUserContext;
      
      protected static var _mobileContext:MobileContext;
      
      protected static var _tracker:Tracker;
      
      protected static var _emitter:Emitter;
      
      protected static var _isAnalyticsActive:Boolean = false;
      
      protected static var _isMobile:Boolean = false;
      
      protected static var _sessionId:String;
      
      protected static var _previousLastLogin:String;
      
      protected static var _purchaseTypeId:int;
      
      public function MangroveConfig()
      {
         super();
      }
      
      public static function get isMobile() : Boolean
      {
         return _isMobile;
      }
      
      public static function get isAnalyticsActive() : Boolean
      {
         return _isAnalyticsActive;
      }
      
      public static function get tracker() : Tracker
      {
         return _tracker;
      }
      
      public static function get mobileContext() : MobileContext
      {
         return _mobileContext;
      }
      
      public static function get mangroveUserContext() : MangroveBaseUserContext
      {
         return _mangroveUserContext;
      }
      
      public static function setupBasicInfos(param1:String, param2:String = "MovieStarPlanet", param3:Boolean = false, param4:Boolean = true, param5:Dictionary = null, param6:int = 1, param7:String = "collector.analyticsmsp.com") : void
      {
         if(param1 == null)
         {
            throw new Error("[MangroveAnalytics] Initialization appId or appNamespace cannot be null");
         }
         _isAnalyticsActive = param3;
         _disabledSchemas = param5;
         _appId = param1;
         _appNamespace = param2;
         _base64Encode = param4;
         _eventBufferSize = param6;
         _emitterURL = param7;
         _basicInfoSetup = true;
         setup();
      }
      
      public static function setupUserDetails(param1:MangroveBaseDetails) : void
      {
         if(param1 != null)
         {
            if(!_userInfoSetup)
            {
               _mangroveUserId = MangroveStringUtils.country(param1.Country) + "." + param1.UserId;
            }
            if(_mangroveUserContext == null)
            {
               if(param1 is MangroveActorDetails)
               {
                  _mangroveUserContext = new UserContextMSP(param1 as MangroveActorDetails);
               }
               else if(param1 is MangroveBoonieDetails)
               {
                  _mangroveUserContext = new UserContextBP(param1 as MangroveBoonieDetails);
               }
               else if(param1 is MangroveRoboblastDetails)
               {
                  _mangroveUserContext = new UserContextRBP(param1 as MangroveRoboblastDetails);
               }
            }
            else
            {
               _mangroveUserContext.update(param1);
            }
            if(_userContextSetup)
            {
               _mangroveUserContext.setupLoginData(_sessionId,_previousLastLogin,_purchaseTypeId);
            }
            _userInfoSetup = true;
            setup();
         }
         else
         {
            MangroveTestUI.writeDebug("setupUserDetails, details were NULL");
            trace("[MangroveAnalytics] setupUserDetails, details were NULL");
         }
      }
      
      public static function setupUserContext(param1:String, param2:String = "", param3:int = 0) : void
      {
         if(param1 == null)
         {
            throw new Error("[MangroveAnalytics] setupUserContext loginTicket is required");
         }
         _sessionId = param1;
         _previousLastLogin = param2;
         _purchaseTypeId = param3;
         _userContextSetup = true;
         setup();
      }
      
      public static function setupIosMobileContext(param1:String, param2:String, param3:String) : void
      {
         setupMobileContext(null,param1,param2,param3);
      }
      
      public static function setupAndroidMobileContext(param1:String) : void
      {
         setupMobileContext(param1,null,null,null);
      }
      
      public static function shutDownMangrove() : void
      {
         registerLogoutEvent();
         _mangroveUserContext = null;
         _mobileContext = null;
         _appId = null;
         _appNamespace = null;
         _base64Encode = true;
         _eventBufferSize = 5;
         _emitterURL = "collector.analyticsmsp.com";
         _disabledSchemas = null;
         _mangroveUserId = null;
         _basicInfoSetup = false;
         _userInfoSetup = false;
         _userContextSetup = false;
         _mangroveInitialized = false;
         _emitter = null;
         _sessionId = null;
         _previousLastLogin = null;
         _purchaseTypeId = 0;
         _tracker = null;
         _isAnalyticsActive = false;
         _isMobile = false;
      }
      
      public static function isSchemaEnabled(param1:String) : Boolean
      {
         if(_disabledSchemas == null)
         {
            return true;
         }
         if(_disabledSchemas[param1] == true)
         {
            return false;
         }
         return true;
      }
      
      private static function setup() : void
      {
         var _loc1_:Array = null;
         if(_basicInfoSetup && _userInfoSetup && _userContextSetup && !_mangroveInitialized)
         {
            _loc1_ = MangroveConfigUtils.separateProtocolAndUrl(_emitterURL);
            _emitter = new Emitter(_loc1_[1],"POST",_loc1_[0]);
            _emitter.setBufferSize(_eventBufferSize);
            _emitter.addEventListener("EMITTER_SUCCESS",emitterSuccess);
            _emitter.addEventListener("EMITTER_FAILURE",emitterFailure);
            _tracker = new Tracker(_emitter,_appNamespace,_appId,MangroveConfigUtils.createSubject(_mangroveUserId),null,_base64Encode,false);
            if(_isMobile)
            {
               _tracker.setPlatform("mob");
            }
            if(_mangroveUserContext != null)
            {
               _mangroveUserContext.setupLoginData(_sessionId,_previousLastLogin,_purchaseTypeId);
            }
            _mangroveInitialized = true;
            registerLoginEvent();
         }
      }
      
      private static function setupMobileContext(param1:String, param2:String, param3:String, param4:String) : void
      {
         if(_tracker != null)
         {
            _tracker.setPlatform("mob");
         }
         _mobileContext = new MobileContext(param1,param2,param3,param4);
         _isMobile = true;
      }
      
      private static function registerLoginEvent() : void
      {
         var _loc1_:SessionStartEvent = null;
         if(_isAnalyticsActive && _tracker != null)
         {
            _loc1_ = new SessionStartEvent("login");
            _loc1_.execute();
         }
      }
      
      private static function registerLogoutEvent() : void
      {
         var _loc1_:SessionEndEvent = null;
         if(_isAnalyticsActive && _tracker != null)
         {
            _loc1_ = new SessionEndEvent("logout");
            _loc1_.execute();
         }
      }
      
      public static function addTrackerListener(param1:Function) : void
      {
         if(_emitter != null)
         {
            _emitter.addEventListener("EMITTER_SUCCESS",param1);
            _emitter.addEventListener("EMITTER_FAILURE",param1);
         }
      }
      
      public static function removeTrackerListener(param1:Function) : void
      {
         if(_emitter != null)
         {
            _emitter.removeEventListener("EMITTER_SUCCESS",param1);
            _emitter.removeEventListener("EMITTER_FAILURE",param1);
         }
      }
      
      private static function emitterSuccess(param1:EmitterEvent) : void
      {
         if(Util.getTraceOn())
         {
            trace("MANGROVE: Buffer length for POST/GET:" + param1.successCount);
         }
         MangroveTestUI.writeDebug("------------------------- \nSUCCESS! Unsent payloads: " + param1.unsentPayloads + "\n------------------------");
      }
      
      private static function emitterFailure(param1:EmitterEvent) : void
      {
         if(Util.getTraceOn())
         {
            trace("MANGROVE: Failure, successCount: " + param1.successCount + "\nfailedEvents:\n" + param1.type + "\nerror:\n" + param1.errorInfo);
         }
         MangroveTestUI.writeDebug("------------------------- \nFAILURE! Unsent payloads: " + param1.unsentPayloads + "\n------------------------");
      }
   }
}

