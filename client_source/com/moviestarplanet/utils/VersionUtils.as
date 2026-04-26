package com.moviestarplanet.utils
{
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import mx.core.Application;
   import mx.core.FlexGlobals;
   
   public class VersionUtils
   {
      
      public static const IS_GREATER:int = 1;
      
      public static const IS_EQUAL:int = 0;
      
      public static const IS_SMALLER:int = -1;
      
      public function VersionUtils()
      {
         super();
      }
      
      public static function get flashPlayerVersion() : String
      {
         return Capabilities.version;
      }
      
      public static function get browserVersion() : String
      {
         var _loc1_:String = ExternalInterface.call("function getUserAgent() { return navigator.userAgent; }");
         var _loc2_:String = ExternalInterface.call("function getAppVersion(){ return navigator.appVersion; }");
         var _loc3_:String = ExternalInterface.call("function getAppName(){ return navigator.appName; }");
         return _loc1_ + " " + _loc2_ + " " + _loc3_;
      }
      
      public static function greaterThan(param1:String, param2:String) : int
      {
         if(param1 === param2)
         {
            return 0;
         }
         var _loc3_:Array = param1.split(".");
         var _loc4_:Array = param2.split(".");
         var _loc5_:int = int(Math.min(_loc3_.length,_loc4_.length));
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(parseInt(_loc3_[_loc6_]) > parseInt(_loc4_[_loc6_]))
            {
               return 1;
            }
            if(parseInt(_loc3_[_loc6_]) < parseInt(_loc4_[_loc6_]))
            {
               return -1;
            }
            _loc6_++;
         }
         if(_loc3_.length > _loc4_.length)
         {
            return 1;
         }
         if(_loc3_.length < _loc4_.length)
         {
            return -1;
         }
         return 0;
      }
      
      public static function getSwfVersion(param1:Boolean) : String
      {
         if(param1)
         {
            return "";
         }
         return (FlexGlobals.topLevelApplication as Application).stage.loaderInfo.parameters["swfVer"];
      }
   }
}

