package com.moviestarplanet.configurations
{
   use namespace config_access_internal;
   
   public class ApplicationConfigAccessor
   {
      
      public function ApplicationConfigAccessor()
      {
         super();
      }
      
      config_access_internal static function setCurrentContext(param1:int) : void
      {
         ApplicationConfig._currentContext = param1;
      }
   }
}

