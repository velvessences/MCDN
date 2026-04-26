package com.moviestarplanet.amf
{
   public class ServiceUrlUtil
   {
      
      private static var _domain:String;
      
      private static var _userBehaviorServiceHostName:String;
      
      private static var _snapshotServiceHostName:String;
      
      private static var _webServerUrl:String = "SERVICE_URL_UTIL_INIT_VALUE";
      
      public function ServiceUrlUtil()
      {
         super();
      }
      
      public static function get snapshotServiceHostName() : String
      {
         return _snapshotServiceHostName;
      }
      
      public static function set snapshotServiceHostName(param1:String) : void
      {
         if(param1 != null)
         {
            param1 = addUrlPrefix(param1);
            param1 = addUrlSuffix(param1);
            _snapshotServiceHostName = param1;
         }
      }
      
      public static function addUrlPrefix(param1:String) : String
      {
         if(param1.indexOf("http://") == -1 && param1.indexOf("https://") == -1)
         {
            param1 = "http://" + param1;
         }
         return param1;
      }
      
      private static function addUrlSuffix(param1:String) : String
      {
         if(param1.charAt(param1.length - 1) != "/")
         {
            param1 += "/";
         }
         return param1;
      }
      
      public static function setUserBehaviorServiceHostName(param1:String) : void
      {
         _userBehaviorServiceHostName = param1;
         _userBehaviorServiceHostName = addUrlPrefix(_userBehaviorServiceHostName);
         _userBehaviorServiceHostName = addUrlSuffix(_userBehaviorServiceHostName);
      }
      
      public static function get userBehaviorServiceHostName() : String
      {
         return _userBehaviorServiceHostName;
      }
      
      public static function get webServerUrl() : String
      {
         return _webServerUrl;
      }
      
      public static function set webServerUrl(param1:String) : void
      {
         _webServerUrl = addUrlPrefix(param1);
      }
      
      public static function get domain() : String
      {
         return _domain;
      }
      
      public static function set domain(param1:String) : void
      {
         _domain = addUrlPrefix(param1);
      }
      
      public static function getServiceUrlBase() : String
      {
         var _loc1_:String = webServerUrl;
         _loc1_ = addUrlPrefix(_loc1_);
         return addUrlSuffix(_loc1_);
      }
      
      public static function getFullyQualifiedWebserverUrl() : String
      {
         var _loc1_:String = webServerUrl;
         _loc1_ = addUrlPrefix(_loc1_);
         return addUrlSuffix(_loc1_);
      }
      
      public static function makeAbsoluteUrl(param1:Object) : String
      {
         var _loc2_:String = param1 as String;
         if(param1 is String && _loc2_ != null)
         {
            if(_loc2_.indexOf("http://") == -1 && _loc2_.indexOf("https://") == -1)
            {
               if(_loc2_.charAt(0) != "/")
               {
                  _loc2_ = "/" + _loc2_;
               }
               _loc2_ = domain + _loc2_;
            }
         }
         return _loc2_;
      }
   }
}

