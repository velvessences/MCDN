package com.moviestarplanet.configurations.service
{
   import com.moviestarplanet.amf.AmfCaller;
   
   public class AMFAppSettingsServiceMobile
   {
      
      protected static var _instance:AMFAppSettingsServiceMobile;
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.AppSettings.AMFAppSettingsServiceMobile");
      
      public function AMFAppSettingsServiceMobile(param1:Function)
      {
         super();
         if(param1 != _singletonUnBlocker)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      protected static function _singletonUnBlocker() : void
      {
      }
      
      public static function getInstance() : AMFAppSettingsServiceMobile
      {
         if(_instance == null)
         {
            _instance = new AMFAppSettingsServiceMobile(_singletonUnBlocker);
         }
         return _instance;
      }
      
      public static function getAppSetting(param1:String, param2:Function, param3:Function = null) : void
      {
         amfCaller.callFunction("GetAppSetting",[param1],true,param2,param3);
      }
      
      public static function getAppSettings(param1:Array, param2:Function, param3:Function = null) : void
      {
         amfCaller.callFunction("GetAppSettings",[param1],true,param2,param3);
      }
   }
}

