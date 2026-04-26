package com.moviestarplanet.utils.translation
{
   import ch.ala.locale.LocaleManager;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import mx.resources.ResourceManager;
   
   public class MSPLocaleManagerWeb implements ILocaleManager
   {
      
      private static var _instance:MSPLocaleManagerWeb;
      
      private static var _translationServerPath:String;
      
      private static var _translationsVersion:String;
      
      public static var initializedLanguageCode:String;
      
      public static var currentLanguageCode:String;
      
      private static const LOCALE_MANAGER_BUNDLE_NAME:String = "MSPWeb";
      
      private static const LOCALE_PATH_SUFFIX:String = "translations";
      
      private static const LOCALE_FILENAME:String = "myResources.txt";
      
      private static var _loadedLanguages:Array = new Array();
      
      public static var doTranslate:Boolean = true;
      
      public function MSPLocaleManagerWeb(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("MSPLocaleManagerWeb is a singleton class, use getInstance() instead.");
         }
      }
      
      public static function initializeLocaleManager(param1:String, param2:String, param3:String, param4:Function) : void
      {
         if(Config.isCustomBranch())
         {
            param1 = Config.GetFinalCDNBasePath("");
         }
         _translationsVersion = param3;
         _translationServerPath = param1;
         initializedLanguageCode = param2;
         LocaleManager.getInstance().keepNewLine = true;
         changeLanguage(param2,param4);
         if(_instance == null)
         {
            _instance = new MSPLocaleManagerWeb(new SingletonEnforcer());
         }
         InjectionManager.mapper().map(ILocaleManager).toValue(_instance);
      }
      
      public static function changeLanguage(param1:String, param2:Function = null) : void
      {
         var loadDone:Function = null;
         var languageCode:String = param1;
         var callback:Function = param2;
         loadDone = function():void
         {
            _loadedLanguages.push(languageCode);
            setLanguage();
         };
         var setLanguage:Function = function():void
         {
            currentLanguageCode = languageCode;
            LocaleManager.getInstance().localeChain = [languageCode];
            ResourceManager.getInstance().localeChain = [languageCode];
            if(callback != null)
            {
               callback();
            }
         };
         if(_loadedLanguages.indexOf(languageCode) < 0)
         {
            LocaleManager.getInstance().addBundle(_translationServerPath + LOCALE_PATH_SUFFIX + "/" + LOCALE_MANAGER_BUNDLE_NAME + "/" + languageCode + "/" + LOCALE_FILENAME + "?v=" + _translationsVersion,languageCode,LOCALE_MANAGER_BUNDLE_NAME,loadDone);
         }
         else
         {
            setLanguage();
         }
      }
      
      public static function getInstance() : MSPLocaleManagerWeb
      {
         return _instance;
      }
      
      public function getString(param1:String, param2:Array = null) : String
      {
         if(param1 == "" || param1 == null)
         {
            return param1;
         }
         var _loc3_:String = LocaleManager.getInstance().getString(LOCALE_MANAGER_BUNDLE_NAME,param1,param2);
         if(Config.IsRunningInDevelopment)
         {
            if(!doTranslate)
            {
               return param1;
            }
            if(param1 == "COUNTRY_BASEBRANCH_AND_BRANCH")
            {
               return Config.getBaseBranch() + ":" + Config.getDebugCountryOnCustomBranch();
            }
            if(_loc3_ == "" || _loc3_ == null)
            {
               return "#MISSING_LOCALE_" + param1;
            }
         }
         return _loc3_;
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
