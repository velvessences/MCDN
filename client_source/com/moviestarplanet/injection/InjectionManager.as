package com.moviestarplanet.injection
{
   import org.swiftsuspenders.Injector;
   
   public class InjectionManager implements IInjectionManager
   {
      
      private static var _instance:InjectionManager;
      
      public var injector:Injector;
      
      public function InjectionManager(param1:SingletonEnforcer)
      {
         super();
         this.injector = new Injector();
      }
      
      public static function manager() : IInjectionManager
      {
         return instance;
      }
      
      public static function mapper() : Injector
      {
         return instance.injector;
      }
      
      public static function set injector(param1:Injector) : void
      {
         instance.injector = param1;
      }
      
      private static function get instance() : InjectionManager
      {
         if(_instance == null)
         {
            _instance = new InjectionManager(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function injectMe(param1:Object) : void
      {
         this.injector.injectInto(param1);
      }
      
      public function getInstance(param1:Class, param2:String = "") : *
      {
         return this.injector.getInstance(param1,param2);
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
