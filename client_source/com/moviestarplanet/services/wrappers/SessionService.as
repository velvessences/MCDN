package com.moviestarplanet.services.wrappers
{
   import com.moviestarplanet.services.actorservice.ActorService;
   import com.moviestarplanet.services.service.Service;
   import com.moviestarplanet.session.valueobjects.AppSetting;
   import mx.collections.ArrayCollection;
   import mx.rpc.CallResponder;
   
   public class SessionService extends WebService
   {
      
      private static var waitingCalls:Array;
      
      private static var settingCache:Object = null;
      
      private static var isLoading:Boolean = false;
      
      public function SessionService()
      {
         super();
      }
      
      private static function settingCacheWhenReady(param1:Function) : void
      {
         if(settingCache == null)
         {
            loadSettings(param1);
         }
         else
         {
            param1(settingCache);
         }
      }
      
      private static function loadSettings(param1:Function) : void
      {
         var appSettingsLoaded:Function = null;
         var callBack:Function = param1;
         appSettingsLoaded = function(param1:ArrayCollection):void
         {
            var _loc2_:AppSetting = null;
            var _loc3_:Function = null;
            settingCache = new Object();
            for each(_loc2_ in param1)
            {
               settingCache[_loc2_.name] = _loc2_.value;
            }
            for each(_loc3_ in waitingCalls)
            {
               _loc3_(settingCache);
            }
            isLoading = false;
         };
         if(isLoading)
         {
            waitingCalls.push(callBack);
         }
         else
         {
            isLoading = true;
            waitingCalls = new Array();
            waitingCalls.push(callBack);
            ActorService.GetAppSettings([],appSettingsLoaded);
         }
      }
      
      public static function getModuleVersion(param1:String, param2:Function) : void
      {
         GetAppSetting(param1,param2);
      }
      
      public static function SettingCacheClear() : void
      {
         settingCache = null;
      }
      
      public static function GetAppSetting(param1:String, param2:Function) : void
      {
         var ready:Function = null;
         var key:String = param1;
         var resultCallBack:Function = param2;
         ready = function(param1:Object):void
         {
            var _loc2_:String = null;
            if(param1.hasOwnProperty(key))
            {
               _loc2_ = param1[key];
            }
            resultCallBack(_loc2_);
         };
         settingCacheWhenReady(ready);
      }
      
      public static function GetActiveLocales(param1:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var resultCallBack:Function = param1;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            resultCallBack(param1.result as Array);
         };
         var service:Service = getService();
         responder = registerResponder(service.ActiveLocales(),webMethodDone);
      }
      
      public static function CountrySiteStatus(param1:String, param2:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var countryCode:String = param1;
         var resultCallBack:Function = param2;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            if(resultCallBack != null)
            {
               resultCallBack(param1.result);
            }
         };
         var service:Service = getService();
         responder = registerResponder(service.GetCountrySiteStatus(countryCode),webMethodDone);
      }
      
      public static function IsDevSite(param1:String, param2:String, param3:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var userName:String = param1;
         var password:String = param2;
         var resultCallBack:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Boolean = false;
            clearResponder(responder,webMethodDone);
            if(resultCallBack != null)
            {
               _loc2_ = Boolean(Boolean(param1.result));
               resultCallBack(_loc2_);
            }
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.IsDevSite(userName,password),webMethodDone);
      }
      
      public static function IsAdminSite(param1:String, param2:String, param3:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var userName:String = param1;
         var password:String = param2;
         var resultCallBack:Function = param3;
         webMethodDone = function(param1:Object):void
         {
            var _loc2_:Boolean = false;
            clearResponder(responder,webMethodDone);
            if(resultCallBack != null)
            {
               _loc2_ = Boolean(Boolean(param1.result));
               resultCallBack(_loc2_);
            }
         };
         var service:Service = getService();
         service.addTicketHeader(createTicketHeader());
         responder = registerResponder(service.IsAdminSite(userName,password),webMethodDone);
      }
      
      public static function getNowAsString(param1:Function) : void
      {
         var responder:CallResponder = null;
         var webMethodDone:Function = null;
         var callback:Function = param1;
         webMethodDone = function(param1:Object):void
         {
            clearResponder(responder,webMethodDone);
            callback(param1.result as String);
         };
         var service:Service = getService();
         responder = registerResponder(service.getNowAsString(),webMethodDone);
      }
   }
}

