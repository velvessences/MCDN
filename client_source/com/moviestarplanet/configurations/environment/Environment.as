package com.moviestarplanet.configurations.environment
{
   public class Environment
   {
      
      private static var _current:Environment;
      
      public var Id:String;
      
      public var Name:String;
      
      public var IpCountry:String;
      
      public var Game:String;
      
      public var BaseHost:String;
      
      public var ServiceDiscoveryUrl:String;
      
      public var FlashVars:String;
      
      public var Country:String;
      
      public var RedirectUrl:String;
      
      public var Locale:String;
      
      public var Language:String;
      
      public var SysCap:String;
      
      public var Iso3166:String;
      
      public var SupportEmail:String;
      
      public var Cardinal:String;
      
      public var webServerPath:String;
      
      public var cdnContentPath:String;
      
      public var cdnAssetPath:String;
      
      private var mSuccesCallback:Function;
      
      private var mFailCallback:Function;
      
      public function Environment()
      {
         super();
      }
      
      public static function getCurrent() : Environment
      {
         return _current;
      }
      
      public static function fromJson(param1:Object) : Environment
      {
         var _loc2_:Environment = new Environment();
         var _loc3_:Object = param1.environment;
         _loc2_.Id = _loc3_.Id;
         _loc2_.Name = _loc3_.Name;
         _loc2_.IpCountry = _loc3_.IpCountry;
         _loc2_.Game = _loc3_.Game;
         _loc2_.BaseHost = _loc3_.BaseHost;
         _loc2_.ServiceDiscoveryUrl = _loc3_.ServiceDiscoveryUrl;
         _loc2_.FlashVars = _loc3_.FlashVars;
         _loc2_.Country = _loc3_.Country;
         _loc2_.RedirectUrl = _loc3_.RedirectUrl;
         _loc2_.Locale = _loc3_.Locale;
         _loc2_.Language = _loc3_.Language;
         _loc2_.SysCap = _loc3_.SysCap;
         _loc2_.Iso3166 = _loc3_.Iso3166;
         _loc2_.SupportEmail = _loc3_.SupportEmail;
         _loc2_.Cardinal = _loc3_.Cardinal;
         return _loc2_;
      }
      
      internal static function setCurrent(param1:Environment) : void
      {
         _current = param1;
      }
      
      public function getFullCountryName() : String
      {
         return EnvironmentUtils.countryCodeToCountryName(_current.Country);
      }
   }
}

