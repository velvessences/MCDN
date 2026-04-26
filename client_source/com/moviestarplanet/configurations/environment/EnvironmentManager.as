package com.moviestarplanet.configurations.environment
{
   import com.moviestarplanet.configurations.DiscoveryService;
   import flash.system.Capabilities;
   
   public class EnvironmentManager
   {
      
      private static var mInstance:EnvironmentManager = new EnvironmentManager();
      
      private static const availableCountries:Array = ["fi","pl","fr","de","nl","no","dk","us","sv","es","pl"];
      
      private var mComplete:Function;
      
      private var mFail:Function;
      
      private var mCountry:String;
      
      private var currentEnvironment:Environment;
      
      public function EnvironmentManager()
      {
         super();
         if(mInstance)
         {
            throw new Error("This is a singleton. Use getInstance to access it");
         }
      }
      
      public static function getInstance() : EnvironmentManager
      {
         if(!mInstance)
         {
            mInstance = new EnvironmentManager();
         }
         return mInstance;
      }
      
      private static function languageCodeFromLanguageAliasCode(param1:String) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case "nb":
            case "nn":
               _loc2_ = "no";
               break;
            default:
               _loc2_ = param1;
         }
         return _loc2_;
      }
      
      public function get getCurrentEnvironment() : Environment
      {
         return this.currentEnvironment;
      }
      
      public function loadCountryEnvironment(param1:String, param2:Function, param3:Function) : void
      {
         var _loc4_:String = null;
         var _loc5_:DiscoveryService = null;
         this.mCountry = param1;
         this.mComplete = param2;
         this.mFail = param3;
         this.validateCallbacks(this.mComplete,this.mFail);
         if(param1 == "LOCAL")
         {
            this.onEnvironmentLoaded(DevEnvironmentConfigurator.getDeveloperCustomEnvironment());
         }
         else
         {
            _loc4_ = EnvironmentUtils.countryNameToCountryCode(param1);
            if(_loc4_ == null)
            {
               this.onEnvironmentLoadFail();
            }
            else
            {
               _loc5_ = new DiscoveryService();
               _loc5_.loadEnvironment(_loc4_,this.onEnvironmentLoaded,this.onEnvironmentLoadFail);
            }
         }
      }
      
      public function loadDefaultEnvironment(param1:Function, param2:Function) : void
      {
         this.mCountry = null;
         this.mComplete = param1;
         this.mFail = param2;
         this.validateCallbacks(this.mComplete,this.mFail);
         var _loc3_:DiscoveryService = new DiscoveryService();
         _loc3_.loadEnvironmentForMyIp(this.onEnvironmentLoaded,this.onEvvironmentForIPFailed);
      }
      
      private function onEnvironmentLoaded(param1:Environment) : void
      {
         Environment.setCurrent(param1);
         this.currentEnvironment = param1;
         this.mComplete();
      }
      
      private function onEnvironmentLoadFail() : void
      {
         var _loc1_:String = null;
         if(this.mCountry == null)
         {
            _loc1_ = this.getSupportedCountryFromClientCapabilities();
         }
         else
         {
            _loc1_ = this.mCountry;
         }
         var _loc2_:String = EnvironmentUtils.localeFromCountryCode(_loc1_);
         var _loc3_:FallbackEnvironment = new FallbackEnvironment();
         _loc3_.Locale = _loc2_;
         _loc3_.Country = _loc1_;
         Environment.setCurrent(_loc3_);
         this.mFail();
      }
      
      private function onEvvironmentForIPFailed() : void
      {
         this.mCountry = this.getSupportedCountryFromClientCapabilities();
         var _loc1_:String = EnvironmentUtils.countryNameToCountryCode(this.mCountry);
         var _loc2_:DiscoveryService = new DiscoveryService();
         _loc2_.loadEnvironment(_loc1_,this.onEnvironmentLoaded,this.onEnvironmentLoadFail);
      }
      
      private function validateCallbacks(param1:Function, param2:Function) : void
      {
         if(param1.length > 0 || param2.length > 0)
         {
            throw new Error("Callbacks must not have any parameters.");
         }
      }
      
      private function getSupportedCountryFromClientCapabilities() : String
      {
         var _loc1_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = Capabilities.language;
         if(_loc2_ == "xu")
         {
            _loc3_ = String(Capabilities.languages[0]).substr(0,2);
            _loc2_ = languageCodeFromLanguageAliasCode(_loc3_);
         }
         if(_loc2_ == "en")
         {
            _loc4_ = String(Capabilities.languages[0]).toLowerCase();
            if(_loc4_ == "en-us" || _loc4_ == "en")
            {
               _loc2_ = "US";
            }
            else
            {
               _loc2_ = "GB";
            }
         }
         if(availableCountries.indexOf(_loc2_) == -1)
         {
            _loc2_ = "US";
         }
         return _loc2_;
      }
   }
}

