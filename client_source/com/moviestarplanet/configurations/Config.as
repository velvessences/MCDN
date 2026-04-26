package com.moviestarplanet.configurations
{
   import com.moviestarplanet.amf.ServiceUrlUtil;
   import com.moviestarplanet.constants.ConstantsBrand;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.Security;
   import flash.system.SecurityDomain;
   import mx.collections.ArrayCollection;
   import mx.core.FlexGlobals;
   
   public class Config
   {
      
      private static var _basePath:String;
      
      private static var _baseBranch:String;
      
      private static var _baseHost:String;
      
      private static var _overrideLanguage:String;
      
      private static var currentSiteConfig:SiteConfig;
      
      private static var _isRunningLocally:Boolean;
      
      public static var siteMaps:Object;
      
      public static const MSP_ADDRESS:String = "Rued Langgaards Vej 8, (3rd floor)\n2300 Copenhagen S";
      
      public static const corporateSiteURL:String = "https://corporate.moviestarplanet.com";
      
      public static const MSP_EMEA_NAME:String = "MSP EMEA ApS";
      
      public static const MSP_NORTH_AMERICA_NAME:String = "MSP NOA ApS";
      
      public static const MSP_EMEA_CVR:String = "36548061";
      
      public static const MSP_NORTH_AMERICA_CVR:String = "36548088";
      
      public static const CUSTOM_BRANCH_URL_POST_FIX:String = ".devmsp.io";
      
      public static const PHONE_NO:String = "-";
      
      public static const LOCAL_CDN_URL:int = 1;
      
      public static const GLOBAL_CDN_URL:int = 2;
      
      public static const WEBSERVER_URL:int = 3;
      
      public static const siteConfigs:Array = [new SiteConfig(["localhost:1600","localhost","127.0.0.1"],"en_US","",false,"uscheckage13",true,"support@moviestarplanet.co.uk","alpha",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.de","moviestarplanet.de","www.themoviestarplanet.de","themoviestarplanet.de","cdn.moviestarplanet.de"],"de_DE","",true,"",true,"support@moviestarplanet.de","de",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.co.uk","moviestarplanet.co.uk","www.themoviestarplanet.co.uk","themoviestarplanet.co.uk","cdn.moviestarplanet.co.uk"],"en_US","",true,"",true,"support@moviestarplanet.co.uk","uk",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.fr","moviestarplanet.fr","cdn.moviestarplanet.fr"],"fr_FR","",true,"",true,"support@moviestarplanet.fr","fr",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.nl","moviestarplanet.nl","cdn.moviestarplanet.nl"]
      ,"nl_NL","",true,"",true,"support@moviestarplanet.nl","nl",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.pl","moviestarplanet.pl","cdn.moviestarplanet.pl"],"pl_PL","",true,"",true,"support@moviestarplanet.pl","pl",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.se","moviestarplanet.se","cdn.moviestarplanet.se"],"sv_SE","",true,"",true,"support@moviestarplanet.se","se",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.dk","moviestarplanet.dk","cdn.moviestarplanet.dk"],"da_DK","",true,"",true,"support@moviestarplanet.dk","dk",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.no","moviestarplanet.no","cdn.moviestarplanet.no"],"nb_NO","",true,"",true,"support@moviestarplanet.no","no",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.fi","moviestarplanet.fi","cdn.moviestarplanet.fi"],"fi_FI","",true,"",true,"support@moviestarplanet.fi"
      ,"fi",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["dev.moviestarplanet.com","5.57.54.44","cdndev.moviestarplanet.com","cdnlocaldev.moviestarplanet.com"],"en_US","",false,"",false,"support@moviestarplanet.com","dev",MSP_NORTH_AMERICA_NAME,MSP_ADDRESS,MSP_NORTH_AMERICA_CVR,PHONE_NO),new SiteConfig(["test.moviestarplanet.com","cdntest.moviestarplanet.com","cdnlocaltest.moviestarplanet.com"],"en_US","",false,"uscheckage13",false,"support@moviestarplanet.com","test",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["dev.mystarplanet.com","cdndev.mystarplanet.com","cdnlocaldev.mystarplanet.com"],"es_ES","",false,"",false,"support@moviestarplanet.com","dev",MSP_NORTH_AMERICA_NAME,MSP_ADDRESS,MSP_NORTH_AMERICA_CVR,PHONE_NO,ConstantsBrand.MY_STAR_PLANET),new SiteConfig(["test.mystarplanet.com","cdntest.mystarplanet.com","cdnlocaltest.mystarplanet.com"],"es_ES","",false,"uscheckage13",false,"support@moviestarplanet.com","test",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR
      ,PHONE_NO,ConstantsBrand.MY_STAR_PLANET),new SiteConfig(["www.moviestarplanet.com","moviestarplanet.com","cdn.moviestarplanet.com","localcdn.moviestarplanet.com"],"en_US","",true,"uscheckage13",true,"ussupport@moviestarplanet.com","com",MSP_NORTH_AMERICA_NAME,MSP_ADDRESS,MSP_NORTH_AMERICA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.com.tr","moviestarplanet.com.tr","cdn.moviestarplanet.com.tr"],"tr_TR","",true,"",true,"support@moviestarplanet.com.tr","tr",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.ie","moviestarplanet.ie","cdn.moviestarplanet.ie"],"en_US","",true,"",true,"support@moviestarplanet.ie","ie",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.com.au","moviestarplanet.com.au","cdn.moviestarplanet.com.au"],"en_US","",true,"uscheckage13",true,"support@moviestarplanet.com.au","au",MSP_NORTH_AMERICA_NAME,MSP_ADDRESS,MSP_NORTH_AMERICA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.co.nz","moviestarplanet.co.nz"
      ,"cdn.moviestarplanet.co.nz"],"en_US","",true,"uscheckage13",true,"support@moviestarplanet.co.nz","nz",MSP_NORTH_AMERICA_NAME,MSP_ADDRESS,MSP_NORTH_AMERICA_CVR,PHONE_NO),new SiteConfig(["www.moviestarplanet.ca","moviestarplanet.ca","cdn.moviestarplanet.ca"],"en_US","",true,"",true,"support@moviestarplanet.ca","ca",MSP_NORTH_AMERICA_NAME,MSP_ADDRESS,MSP_NORTH_AMERICA_CVR,PHONE_NO),new SiteConfig(["www.mystarplanet.es","mystarplanet.es","cdn.mystarplanet.es"],"es_ES","",true,"uscheckage13",true,"support@mystarplanet.es","es",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO,ConstantsBrand.MY_STAR_PLANET),new SiteConfig(["81.95.156.186","admin.moviestarplanet.se"],"sv_SE","",false,"",false,"support@moviestarplanet.se","admin",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["upload.moviestarplanet.com","cdnupload.moviestarplanet.com"],"en_US","",false,"",false,"support@moviestarplanet.com","upload",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["assets.rcmspcdns.com"
      ,"ws.rc.moviestarplanet.com","rc.moviestarplanet.com","cdn.localrc.moviestarplanet.com","cdn.rc.moviestarplanet.com","rc.devmsp.io"],"en_US","",false,"uscheckage13",false,"support@moviestarplanet.com","rc",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["uploadtest.moviestarplanet.com"],"en_US","",false,"",false,"support@moviestarplanet.com","uploadtest",MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO),new SiteConfig(["beta.devmsp.io","ws.beta.moviestarplanet.com","beta.moviestarplanet.com","cdn.beta.moviestarplanet.com","cdnlocal.beta.moviestarplanet.com"],"en_US","",false,"",false,"support@moviestarplanet.com","beta",MSP_NORTH_AMERICA_NAME,MSP_ADDRESS,MSP_NORTH_AMERICA_CVR,PHONE_NO),new SiteConfig(["alpha.devmsp.io","cdn.alpha.moviestarplanet.com","cdnlocal.alpha.moviestarplanet.com","upload.alpha.moviestarplanet.com","moviestarplanet.ovdal.dk","alpha.moviestarplanet.com"],"en_US","",false,"uscheckage13",false,"support@moviestarplanet.com","alpha",MSP_EMEA_NAME,MSP_ADDRESS
      ,MSP_EMEA_CVR,PHONE_NO)];
      
      public static const LOCALHOST_WEBSERVER_URL:String = "http://localhost:1600/";
      
      public static var UseRemotingNew:Boolean = false;
      
      private static var _cdnBasePath:String = "http://cdnBasePath_initial_value";
      
      private static var _cdnLocalBasePath:String = "http://cdnLocalBasePath_initial_value";
      
      private static var _webserverPath:String = "http://webserverPath_initial_value";
      
      private static var isRunningInDevelopment:int = -1;
      
      private static const VAR_NOT_SET:int = -1;
      
      private static const VAR_TRUE:int = 1;
      
      private static const VAR_FALSE:int = 0;
      
      private static var _debugRemote:int = -1;
      
      public static var phoneWebAppHome:String = "";
      
      private static var isCustomBranchServer:Boolean = false;
      
      private static var _checkedIfRunningLocally:Boolean = false;
      
      private static var debugCountry:String = "alpha";
      
      private static var statisticsSandboxList:Array = ["local","localhost","localhost:1600","rc","upload","uploadtest","admin","alpha","beta"];
      
      private static var _isServerRestricted:int = -1;
      
      public function Config()
      {
         super();
      }
      
      public static function get cdnBasePath() : String
      {
         return "https://velvessences.github.io/MCDN/CDN/";
      }
      
      public static function set cdnBasePath(param1:String) : void
      {
         _cdnBasePath = "https://velvessences.github.io/MCDN/CDN/";
      }
      
      public static function get webserverPath() : String
      {
         return _webserverPath;
      }
      
      public static function set webserverPath(param1:String) : void
      {
         _webserverPath = param1;
      }
      
      public static function get overrideLanguage() : String
      {
         if(_overrideLanguage == null)
         {
            if(getCurrentSiteConfig().Language == "test")
            {
               return "en";
            }
            return getCurrentSiteConfig().Language.substring(0,2);
         }
         return _overrideLanguage;
      }
      
      public static function set overrideLanguage(param1:String) : void
      {
         _overrideLanguage = param1;
      }
      
      public static function get cdnLocalBasePath() : String
      {
         return "https://velvessences.github.io/MCDN/CDN/";
      }
      
      public static function set cdnLocalBasePath(param1:String) : void
      {
         _cdnLocalBasePath = "https://velvessences.github.io/MCDN/CDN/";
      }
      
      public static function getSecurityDomain() : SecurityDomain
      {
         return Config.isMobile ? null : SecurityDomain.currentDomain;
      }
      
      public static function get basePath() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(_basePath == null)
         {
            _loc1_ = "";
            if(FlexGlobals.topLevelApplication != null)
            {
               _loc1_ = FlexGlobals.topLevelApplication.url;
            }
            _loc2_ = _loc1_;
            if(IsRunningLocally)
            {
               _basePath = "";
            }
            else if(_loc2_.substr(0,3) == "app")
            {
               _basePath = null;
            }
            else
            {
               _loc3_ = ExternalInterface.call("eval","document.location.href");
               _loc4_ = URLUtilLite.getServerName(_loc3_);
               _loc5_ = URLUtilLite.getProtocol(_loc3_);
               _basePath = _loc5_ + "://" + _loc4_ + "/";
            }
         }
         return _basePath;
      }
      
      public static function initializeCdnPathsOld(param1:String) : void
      {
         var _loc2_:String = URLUtilLite.getServerName(param1);
         var _loc3_:String = URLUtilLite.getProtocol(param1);
         var _loc4_:String = "";
         if(FlexGlobals.topLevelApplication)
         {
            _loc4_ = FlexGlobals.topLevelApplication.parameters.cdnBasePath;
         }
         if(IsRunningLocally)
         {
            _loc4_ = "upload.alpha.moviestarplanet.com";
         }
         else if(isCustomBranchServer)
         {
            _loc4_ = "upload." + getCurrentSiteConfig().Domains[0];
         }
         if(_loc4_ != null && _loc4_ != "")
         {
            Config.cdnBasePath = _loc3_ + "://" + _loc4_ + "/";
         }
         else
         {
            Config.cdnBasePath = Config.isMobile ? Config.phoneWebAppHome : Config.basePath;
         }
         var _loc5_:String = "";
         if(FlexGlobals.topLevelApplication)
         {
            _loc5_ = FlexGlobals.topLevelApplication.parameters.cdnLocalBasePath;
         }
         else if(isCustomBranchServer)
         {
            _loc5_ = "cdn." + getCurrentSiteConfig().Domains[0];
         }
         if(_loc5_ != null && _loc5_ != "")
         {
            Config.cdnLocalBasePath = _loc3_ + "://" + _loc5_ + "/";
         }
         else if(Config.isMobile)
         {
            Config.cdnLocalBasePath = Config.phoneWebAppHome;
         }
         else
         {
            if(IsRunningLocally)
            {
               _loc5_ = "";
            }
            if(_loc5_ != null && _loc5_ != "")
            {
               Config.cdnLocalBasePath = _loc3_ + "://" + _loc5_ + "/";
            }
            else
            {
               Config.cdnLocalBasePath = Config.basePath;
            }
         }
      }
      
      public static function initializeCdnPathsWeb(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(IsRunningLocally)
         {
            Security.allowDomain("*");
         }
         else
         {
            _loc4_ = param3;
            _loc5_ = param2;
            _loc6_ = param1;
            if(param3 == null || param3 == "")
            {
               param3 = ExternalInterface.call("window.location.href.toString");
            }
            if(param2 == null || param2 == "")
            {
               param2 = param3;
            }
            if(param1 == null || param1 == "")
            {
               param1 = "http://cdn.moviestarplanet.com/";
            }
            param3 = addUrlPrefixIfNeeded(param3);
            param2 = addUrlPrefixIfNeeded(param2);
            param1 = addUrlPrefixIfNeeded(param1);
            if(param3 != _loc4_)
            {
               ExternalInterface.call("console.log","Using fallback wsPath " + param3);
            }
            if(param2 != _loc5_)
            {
               ExternalInterface.call("console.log","Using fallback cdnLocalPath " + param2);
            }
            if(param1 != _loc6_)
            {
               ExternalInterface.call("console.log","Using fallback cdnPath " + param1);
            }
            param2 = addUrlSuffixIfNeeded(param2);
         }
         Config.cdnBasePath = addUrlSuffixIfNeeded(param1);
         Config.cdnLocalBasePath = param2;
         Config.webserverPath = addUrlSuffixIfNeeded(param3);
      }
      
      private static function addUrlPrefixIfNeeded(param1:String) : String
      {
         return ServiceUrlUtil.addUrlPrefix(param1);
      }
      
      private static function addUrlSuffixIfNeeded(param1:String) : String
      {
         if(param1.charAt(param1.length - 1) != "/")
         {
            param1 += "/";
         }
         return param1;
      }
      
      public static function initializeCdnPathsMobile(param1:String, param2:String) : void
      {
         currentSiteConfig = null;
         Config.cdnBasePath = param2;
         Config.cdnLocalBasePath = param1;
      }
      
      public static function initializeCdnPathsFromBootstrap(param1:String, param2:String, param3:String, param4:String) : void
      {
         initializeCdnPathsMobile(param1,param2);
         Config.webserverPath = param3;
         Config.phoneWebAppHome = param4;
      }
      
      public static function get IsRunningLocally() : Boolean
      {
         if(!_checkedIfRunningLocally)
         {
            checkIfRunningLocally();
         }
         return _isRunningLocally;
      }
      
      private static function checkIfRunningLocally() : void
      {
         _isRunningLocally = true;
         _checkedIfRunningLocally = true;
      }
      
      private static function getCustomBranchDevSite(param1:String) : SiteConfig
      {
         currentSiteConfig = createDevSiteConfig(debugCountry);
         return currentSiteConfig;
      }
      
      public static function setCurrentSiteConfig(param1:SiteConfig) : void
      {
         currentSiteConfig = param1;
      }
      
      public static function getCurrentSiteConfig() : SiteConfig
      {
         return siteConfigs[0];
      }
      
      private static function findSiteConfigFromDomain(param1:String) : SiteConfig
      {
         var _loc3_:SiteConfig = null;
         var _loc2_:int = 0;
         while(_loc2_ < Config.siteConfigs.length)
         {
            _loc3_ = Config.siteConfigs[_loc2_];
            if(_loc3_.IsCurrentSiteDomain(param1))
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function fromCountry(param1:String) : SiteConfig
      {
         param1 = param1.toLocaleLowerCase();
         if(param1 == "us")
         {
            param1 = "com";
         }
         if(param1 == "gb")
         {
            param1 = "uk";
         }
         var _loc2_:* = int(siteConfigs.length - 1);
         while(_loc2_ >= 0)
         {
            if(siteConfigs[_loc2_].country == param1)
            {
               return siteConfigs[_loc2_];
            }
            _loc2_--;
         }
         return null;
      }
      
      public static function get isMobile() : Boolean
      {
         return false;
      }
      
      public static function getUrlForWebServer() : String
      {
         return webserverPath;
      }
      
      public static function get CurrentDomain() : String
      {
         var _loc1_:SiteConfig = getCurrentSiteConfig();
         if(_loc1_ != null)
         {
            return _loc1_.Domains[0];
         }
         return "";
      }
      
      public static function get IsRunningInDevelopment() : Boolean
      {
         var _loc1_:SiteConfig = null;
         var _loc2_:Boolean = false;
         if(isRunningInDevelopment == VAR_NOT_SET)
         {
            _loc1_ = getCurrentSiteConfig();
            _loc2_ = _loc1_.IsCurrentSiteDomain("localhost:1600") || _loc1_.IsCurrentSiteDomain("localhost") || _loc1_.IsCurrentSiteDomain("dev.moviestarplanet.com") || _loc1_.IsCurrentSiteDomain("5.57.54.44") || _loc1_.IsCurrentSiteDomain("cdndev.moviestarplanet.com") || _loc1_.IsCurrentSiteDomain("cdnlocaldev.moviestarplanet.com") || _loc1_.IsCurrentSiteDomain("test.moviestarplanet.com") || _loc1_.IsCurrentSiteDomain("cdntest.moviestarplanet.com") || _loc1_.IsCurrentSiteDomain("cdnlocaltest.moviestarplanet.com") || _loc1_.IsCurrentSiteDomain("dev.mystarplanet.com") || _loc1_.IsCurrentSiteDomain("cdndev.mystarplanet.com") || _loc1_.IsCurrentSiteDomain("cdnlocaldev.mystarplanet.com") || _loc1_.IsCurrentSiteDomain("test.mystarplanet.com") || _loc1_.IsCurrentSiteDomain("cdntest.mystarplanet.com") || _loc1_.IsCurrentSiteDomain("cdnlocaltest.mystarplanet.com") || _loc1_.IsCurrentSiteDomain("alpha.moviestarplanet.com") || _loc1_.IsCurrentSiteDomain("alpha.devmsp.io") || _loc1_.IsCurrentSiteDomain("beta.moviestarplanet.com") || _loc1_
            .IsCurrentSiteDomain("cdn.alpha.moviestarplanet.com") || _loc1_.IsCurrentSiteDomain("cdn.beta.moviestarplanet.com") || _loc1_.IsCurrentSiteDomain("beta.devmsp.io") || isCustomBranch();
            if(_loc2_)
            {
               isRunningInDevelopment = VAR_TRUE;
            }
            else
            {
               isRunningInDevelopment = VAR_FALSE;
            }
         }
         return isRunningInDevelopment == VAR_TRUE;
      }
      
      public static function isStatisticsSandboxEnvironment(param1:String) : Boolean
      {
         return isCustomBranchServer || statisticsSandboxList.indexOf(param1.toLowerCase()) >= 0;
      }
      
      public static function get GetLanguage() : String
      {
         var _loc1_:SiteConfig = getCurrentSiteConfig();
         if(_loc1_ != null)
         {
            return _loc1_.Language;
         }
         return "en_US";
      }
      
      public static function get GetCountry() : String
      {
         var _loc1_:SiteConfig = getCurrentSiteConfig();
         if(_loc1_ != null)
         {
            return _loc1_.country;
         }
         return "com";
      }
      
      public static function get GetBrand() : String
      {
         var _loc1_:SiteConfig = getCurrentSiteConfig();
         if(_loc1_ != null)
         {
            return _loc1_.brandName;
         }
         return "MovieStarPlanet";
      }
      
      public static function get IsBrandNameMyStarPlanet() : Boolean
      {
         var _loc1_:String = GetBrand;
         return _loc1_ == ConstantsBrand.MY_STAR_PLANET_S;
      }
      
      public static function get GetFlagLanguageDomains() : Array
      {
         var _loc5_:SiteConfig = null;
         var _loc6_:Object = null;
         var _loc1_:String = GetLanguage;
         var _loc2_:String = GetCountry;
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         for(; _loc4_ < siteConfigs.length; _loc4_++)
         {
            _loc5_ = siteConfigs[_loc4_];
            if(_loc5_.IsFlagSite)
            {
               if(!IsRunningLocally)
               {
                  if(getCurrentSiteConfig() != null)
                  {
                     if(getCurrentSiteConfig().country != "com" && _loc5_.country == "com")
                     {
                        continue;
                     }
                  }
               }
               else if(_loc5_.country == "com")
               {
                  continue;
               }
               _loc6_ = new Object();
               _loc6_.icon = Config.toAbsoluteURL("img/32x32/flags/" + _loc5_.country + ".png",Config.LOCAL_CDN_URL);
               _loc6_.name = "COUNTRY_" + _loc5_.country.toUpperCase();
               _loc6_.isCurrent = _loc2_ == _loc5_.country;
               _loc6_.redirectUrl = "https://" + _loc5_.Domains[0];
               _loc6_.locale = _loc5_.Language;
               _loc3_.push(_loc6_);
            }
         }
         if(isCustomBranch())
         {
            _loc6_ = new Object();
            _loc6_.icon = Config.toAbsoluteURL("img/32x32/flags/us.png",Config.LOCAL_CDN_URL);
            _loc6_.name = "COUNTRY_BASEBRANCH_AND_BRANCH";
            _loc6_.isCurrent = true;
            _loc6_.redirectUrl = "";
            _loc6_.locale = "COUNTRY_BASEBRANCH_AND_BRANCH";
            _loc3_.push(_loc6_);
         }
         return _loc3_;
      }
      
      public static function get GetProductionDomains() : ArrayCollection
      {
         return new ArrayCollection();
      }
      
      public static function GetUsCheckAge13() : Boolean
      {
         var _loc1_:SiteConfig = Config.getCurrentSiteConfig();
         return _loc1_ == null || _loc1_.SpecialConfig.indexOf("uscheckage13") >= 0;
      }
      
      public static function IsServerRestricted() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_isServerRestricted == -1)
         {
            return GetUsCheckAge13();
         }
         if(_isServerRestricted == 0)
         {
            return false;
         }
         return true;
      }
      
      public static function SetServerRestricted(param1:Boolean) : void
      {
         if(param1)
         {
            _isServerRestricted = 1;
         }
         else
         {
            _isServerRestricted = 0;
         }
      }
      
      public static function get GetCartoonNetworkLink() : String
      {
         var _loc1_:SiteConfig = getCurrentSiteConfig();
         if(_loc1_ != null)
         {
            return _loc1_.CartoonNetworkLink;
         }
         return "";
      }
      
      public static function GetFileNameFromUrl(param1:String) : String
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:String = null;
         if(param1 != null && param1.length > 0)
         {
            _loc2_ = param1.lastIndexOf("/") + 1;
            _loc3_ = Number(param1.lastIndexOf("."));
            if(_loc3_ == -1 || _loc3_ < _loc2_)
            {
               _loc3_ = Number(param1.length);
            }
            return param1.substring(_loc2_,_loc3_);
         }
         return param1;
      }
      
      public static function GetFinalCDNBasePath(param1:String) : String
      {
         return cdnBasePath;
      }
      
      public static function GetRelativeBlackListPath(param1:String) : String
      {
         return GetFinalCDNBasePath(param1) + "dictionaries/" + escape(param1);
      }
      
      public static function get isUploadServer() : Boolean
      {
         if(!IsRunningLocally && getCurrentSiteConfig() != null && getCurrentSiteConfig().country == "upload")
         {
            return true;
         }
         return false;
      }
      
      public static function loadSiteMaps(param1:String, param2:Function) : void
      {
         var onLoadSuccess:Function = null;
         var onLoadFail:Function = null;
         var request:URLRequest = null;
         var loader:URLLoader = null;
         var url:String = param1;
         var callback:Function = param2;
         onLoadSuccess = function(param1:Event):void
         {
            var _loc2_:Object = null;
            var _loc4_:Object = null;
            loader.removeEventListener(Event.COMPLETE,onLoadSuccess);
            loader.removeEventListener(IOErrorEvent.IO_ERROR,onLoadFail);
            _loc2_ = JSON.parse(param1.target.data as String);
            var _loc3_:Object = new Object();
            for each(_loc4_ in _loc2_)
            {
               _loc3_[_loc4_.country] = new InfoSiteMap(_loc4_.baseURL,_loc4_.about,_loc4_.parents,_loc4_.teachers,_loc4_.userGuide,_loc4_.safety,_loc4_.privacyPolicy,_loc4_.termsConditions,_loc4_.contact);
            }
            _loc2_ = null;
            siteMaps = _loc3_;
            trace("[Config] Info site maps loaded from global CDN server");
            callback();
         };
         onLoadFail = function(param1:IOErrorEvent):void
         {
            loader.removeEventListener(Event.COMPLETE,onLoadSuccess);
            loader.removeEventListener(IOErrorEvent.IO_ERROR,onLoadFail);
            trace("[Config] Error loading info site maps from global CDN server");
            trace("[Config] Using default info site maps");
            callback();
         };
         var loadingURLPath:String = url + "localization/infosites.txt";
         var shouldUpdate:Boolean = true;
         if(shouldUpdate)
         {
            request = new URLRequest(loadingURLPath);
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE,onLoadSuccess);
            loader.addEventListener(IOErrorEvent.IO_ERROR,onLoadFail);
            loader.load(request);
         }
         else
         {
            callback();
         }
      }
      
      public static function get InfoMap() : InfoSiteMap
      {
         if(siteMaps.hasOwnProperty(ISO3166Code))
         {
            return siteMaps[ISO3166Code];
         }
         return siteMaps["us"];
      }
      
      public static function get ISO3166Code() : String
      {
         var _loc2_:String = null;
         var _loc1_:SiteConfig = getCurrentSiteConfig();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.country.toLowerCase();
            switch(_loc2_)
            {
               case "uk":
                  _loc2_ = "gb";
                  break;
               case "com":
               case "local":
               case "test":
               case "dev":
               case "alpha":
               case "beta":
               case "rc":
               case "upload":
                  _loc2_ = "us";
            }
         }
         return _loc2_;
      }
      
      public static function getDebugCountryOnCustomBranch() : String
      {
         return debugCountry;
      }
      
      public static function debugRemote() : Boolean
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(_debugRemote == VAR_NOT_SET)
         {
            _loc1_ = ExternalInterface.call("window.location.href.toString");
            if(_loc1_)
            {
               _loc2_ = _loc1_.split("?");
               if(_loc2_.length > 0 && Boolean(_loc2_[1]))
               {
                  _loc1_ = _loc2_[1];
                  _loc2_ = _loc1_.split("&");
               }
            }
            _debugRemote = VAR_FALSE;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_ = _loc2_[_loc4_].toLowerCase() as String;
               if(_loc3_ == "alpha=true" || _loc3_ == "debugremote=true")
               {
                  _debugRemote = VAR_TRUE;
               }
               if(_loc3_.indexOf("debugcountry") >= 0)
               {
                  debugCountry = _loc3_.split("=")[1];
                  if(fromCountry(debugCountry) == null && Boolean(_debugRemote))
                  {
                     setupCustomBranchServer(true);
                  }
               }
               _loc4_++;
            }
         }
         return _debugRemote == VAR_TRUE;
      }
      
      public static function ToggleMobileCustomBranch(param1:Boolean, param2:String = null, param3:String = null) : void
      {
         setupCustomBranchServer(param1);
         currentSiteConfig = null;
         debugCountry = param2;
         setBaseBranch(param3);
      }
      
      public static function setupCustomBranchServer(param1:Boolean) : void
      {
         isCustomBranchServer = param1;
      }
      
      public static function isCustomBranch() : Boolean
      {
         return isCustomBranchServer;
      }
      
      public static function setBaseBranch(param1:String) : void
      {
         _baseBranch = param1;
      }
      
      public static function getBaseBranch() : String
      {
         return _baseBranch;
      }
      
      public static function setBaseHost(param1:String) : void
      {
         _baseHost = param1;
      }
      
      public static function getBaseHost() : String
      {
         return _baseHost;
      }
      
      private static function createDevSiteConfig(param1:String) : SiteConfig
      {
         return new SiteConfig([param1 + CUSTOM_BRANCH_URL_POST_FIX],"en_US","",false,"uscheckage13",false,"support@moviestarplanet.com",param1,MSP_EMEA_NAME,MSP_ADDRESS,MSP_EMEA_CVR,PHONE_NO);
      }
      
      public static function toAbsoluteURL(param1:String, param2:int) : String
      {
         switch(param2)
         {
            case GLOBAL_CDN_URL:
               return cdnBasePath + param1;
            case LOCAL_CDN_URL:
               return cdnLocalBasePath + param1;
            case WEBSERVER_URL:
               return webserverPath + param1;
            default:
               throw new Error("Incorrect url type");
         }
      }
      
      public static function getCustomWebsiteName() : String
      {
         var _loc1_:String = ExternalInterface.call("window.location.href.toString");
         if(_loc1_.indexOf("://") >= 0)
         {
            _loc1_ = _loc1_.substr(_loc1_.indexOf("://") + 3);
         }
         var _loc2_:Array = _loc1_.split(".");
         return _loc2_[0];
      }
   }
}

