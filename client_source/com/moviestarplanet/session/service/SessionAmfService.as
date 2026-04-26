package com.moviestarplanet.session.service
{
   import avmplus.getQualifiedClassName;
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.amf.valueobjects.ServiceResultData;
   import com.moviestarplanet.service.ISessionAmfService;
   
   internal class SessionAmfService implements ISessionAmfService
   {
      
      private static var waitingCalls:Array;
      
      private static var isLoading:Boolean = false;
      
      private static var settingCache:Object = null;
      
      public function SessionAmfService()
      {
         super();
      }
      
      protected function get amfCaller() : AmfCaller
      {
         throw new Error("amfCaller in SessionAmfService must be overridden in class " + getQualifiedClassName(this));
      }
      
      public function GetLevelThresholds(param1:Function) : void
      {
         var success:Function = null;
         var resultCallback:Function = param1;
         success = function(param1:Object):void
         {
            var _loc2_:ServiceResultData = new ServiceResultData();
            _loc2_.Code = param1.Code;
            _loc2_.Description = param1.Description;
            _loc2_.Data = param1.Data;
            resultCallback(_loc2_);
         };
         this.amfCaller.callFunction("GetLevelThresholds",[],false,success);
      }
      
      public function GetAppSetting(param1:String, param2:Function) : void
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
         this.settingCacheWhenReady(ready);
      }
      
      public function GetAppSettings(param1:Array, param2:Function) : void
      {
         this.amfCaller.callFunction("GetAppSettings",[param1],true,param2,null);
      }
      
      private function settingCacheWhenReady(param1:Function) : void
      {
         if(settingCache == null)
         {
            this.loadSettings(param1);
         }
         else
         {
            param1(settingCache);
         }
      }
      
      private function loadSettings(param1:Function) : void
      {
         var appSettingsLoaded:Function = null;
         var callBack:Function = param1;
         appSettingsLoaded = function(param1:Array):void
         {
            var _loc2_:Object = null;
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
            this.GetAppSettings([],appSettingsLoaded);
         }
      }
   }
}

