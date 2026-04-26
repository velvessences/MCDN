package com.moviestarplanet.utils.translation
{
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   
   public class LocaleHelper
   {
      
      private static var _instance:LocaleHelper;
      
      [Inject]
      public var localeManager:ILocaleManager;
      
      public function LocaleHelper(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("LocaleHelper is a singleton class, use getInstance() instead.");
         }
      }
      
      public static function getInstance() : LocaleHelper
      {
         if(_instance == null)
         {
            _instance = new LocaleHelper(new SingletonEnforcer());
            InjectionManager.manager().injectMe(_instance);
         }
         return _instance;
      }
      
      public function getString(param1:String, param2:Array = null) : String
      {
         return this.localeManager.getString(param1,param2);
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
