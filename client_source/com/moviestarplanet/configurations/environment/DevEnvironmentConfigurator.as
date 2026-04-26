package com.moviestarplanet.configurations.environment
{
   public class DevEnvironmentConfigurator
   {
      
      public function DevEnvironmentConfigurator()
      {
         super();
      }
      
      public static function getSpecialServerForUser(param1:String) : DevEnvironmentConfigVO
      {
         var _loc2_:Array = param1.split("dev!@");
         var _loc3_:DevEnvironmentConfigVO = new DevEnvironmentConfigVO();
         _loc3_.server = _loc2_[0];
         _loc3_.username = _loc2_[1];
         return _loc3_;
      }
      
      public static function isItLocal(param1:String) : Boolean
      {
         var _loc2_:Array = ["TEST","DEV","RC","UPLOAD","LOCAL_CHARLES","LOCAL","MYSTARTEST","MYSTARDEV","ALPHA","BETA"];
         if(_loc2_.indexOf(param1) != -1)
         {
            return true;
         }
         return false;
      }
      
      public static function getDeveloperCustomEnvironment() : Environment
      {
         var _loc1_:Environment = new Environment();
         _loc1_.Id = "local";
         _loc1_.Name = "local";
         _loc1_.IpCountry = "DK";
         _loc1_.Game = "msp";
         _loc1_.BaseHost = "localhost";
         _loc1_.ServiceDiscoveryUrl = "";
         _loc1_.Country = "LOCAL";
         _loc1_.RedirectUrl = "none";
         _loc1_.Locale = "en_US";
         _loc1_.Language = "en_US";
         _loc1_.SysCap = "en";
         _loc1_.Iso3166 = "us";
         _loc1_.SupportEmail = "support@moviestarplanet.com";
         _loc1_.Cardinal = "-1";
         _loc1_.cdnAssetPath = "https://alpha.devmsp.io/assets/";
         _loc1_.cdnContentPath = "https://upload.alpha.moviestarplanet.com/";
         _loc1_.webServerPath = "http://localhost:1600/";
         return _loc1_;
      }
      
      public static function getConfigFromLegacyFormat(param1:String) : DevEnvironmentConfigVO
      {
         param1 = param1.toLocaleLowerCase();
         var _loc2_:DevEnvironmentConfigVO = new DevEnvironmentConfigVO();
         if(param1.indexOf("alpha") >= 0)
         {
            _loc2_.server = "ALPHA";
         }
         else if(param1.indexOf("beta") >= 0)
         {
            _loc2_.server = "BETA";
         }
         else if(param1.indexOf("upload") >= 0)
         {
            _loc2_.server = "UPLOAD";
         }
         else
         {
            _loc2_ = null;
         }
         return _loc2_;
      }
   }
}

