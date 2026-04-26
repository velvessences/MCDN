package com.moviestarplanet.configurations
{
   public class TrusteConfig
   {
      
      private static var instance:TrusteConfig;
      
      public static const TRUSTE_URL:String = "//privacy.truste.com/privacy-seal/MovieStarPlanet-ApS/validation?rid=10afda85-3ac1-4393-8ae8-d1df3de3e2da";
      
      public var isActual:Boolean;
      
      public function TrusteConfig()
      {
         super();
      }
      
      public static function getInstance() : TrusteConfig
      {
         if(instance == null)
         {
            instance = new TrusteConfig();
         }
         return instance;
      }
      
      public function setup(param1:int, param2:String) : void
      {
         param2 = param2.toLowerCase();
         if(param1 < 13 && (param2 == "com" || param2 == "alpha" || param2 == "rc"))
         {
            this.isActual = true;
         }
         else
         {
            this.isActual = false;
         }
      }
   }
}

