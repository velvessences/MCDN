package com.moviestarplanet.configurations
{
   import com.moviestarplanet.platform.ApplicationId;
   import flash.utils.getQualifiedClassName;
   
   public class ApplicationConfig
   {
      
      public static var applicationType:String;
      
      internal static var _currentContext:int;
      
      public static const APPLICATIONS:Array = ["APPLICATION_WEB","APPLICATION_MOBILE","APPLICATION_BOONIEVERSE","APPLICATION_BUILDERGAME_WEB","APPLICATION_BUILDERGAME_MOBILE"];
      
      public static const CONTEXT_FRONTPAGE:int = 0;
      
      public static const CONTEXT_INGAME:int = 1;
      
      public function ApplicationConfig()
      {
         super();
         throw new Error("Cant instantiate static class " + getQualifiedClassName(this) + ".");
      }
      
      public static function getCurrentContext() : int
      {
         return _currentContext;
      }
      
      public static function get currentContext() : int
      {
         return _currentContext;
      }
      
      public static function getApplicationType(param1:String) : String
      {
         switch(param1)
         {
            case ApplicationId.APPLICATION_MOBILE:
               return ApplicationId.APPLICATION_MOBILE;
            case ApplicationId.APPLICATION_BOONIEVERSE:
               return ApplicationId.APPLICATION_BOONIEVERSE;
            default:
               return ApplicationId.APPLICATION_WEB;
         }
      }
   }
}

