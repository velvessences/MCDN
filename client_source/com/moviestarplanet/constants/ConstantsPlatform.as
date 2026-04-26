package com.moviestarplanet.constants
{
   import com.moviestarplanet.platform.ApplicationId;
   import flash.system.Capabilities;
   
   public class ConstantsPlatform
   {
      
      private static var IS_MOBILE:Boolean;
      
      private static var IS_WEB:Boolean;
      
      private static var IS_IOS:Boolean;
      
      private static var IS_ANDROID:Boolean;
      
      private static var _store:String;
      
      public static const IOS:int = 0;
      
      public static const ANDROID:int = 1;
      
      public static const APPLICATION_WEB:int = 0;
      
      public static const APPLICATION_MOBILE:int = 1;
      
      public static const APP_STORE:String = "apple";
      
      public static const GOOGLE_PLAY:String = "google";
      
      public static const AMAZON_STORE:String = "amazon";
      
      public function ConstantsPlatform()
      {
         super();
      }
      
      public static function setupConstantsWeb() : void
      {
         IS_MOBILE = false;
         IS_WEB = true;
      }
      
      public static function setupConstantsMobile(param1:Boolean, param2:String) : void
      {
         IS_MOBILE = true;
         IS_WEB = false;
         IS_IOS = param1;
         IS_ANDROID = !param1;
         _store = param2;
      }
      
      public static function get isMobile() : Boolean
      {
         return IS_MOBILE;
      }
      
      public static function get isWeb() : Boolean
      {
         return IS_WEB;
      }
      
      public static function get isIOS() : Boolean
      {
         return IS_IOS;
      }
      
      public static function get isAndroid() : Boolean
      {
         return IS_ANDROID;
      }
      
      public static function get store() : String
      {
         return _store;
      }
      
      public static function get isKindle() : Boolean
      {
         return _store == AMAZON_STORE;
      }
      
      public static function get isGoogle() : Boolean
      {
         return store == GOOGLE_PLAY;
      }
      
      public static function get applicationId() : String
      {
         if(isMobile)
         {
            return ApplicationId.APPLICATION_MOBILE;
         }
         if(isWeb)
         {
            return ApplicationId.APPLICATION_WEB;
         }
         return "";
      }
      
      public static function get isDesktop() : Boolean
      {
         var _loc1_:String = Capabilities.os;
         var _loc2_:Boolean = _loc1_.search("Windows") != -1;
         var _loc3_:Boolean = _loc1_.search("Mac OS") != -1;
         var _loc4_:Boolean = _loc1_.search("Linux") != -1;
         return _loc2_ || _loc3_ || _loc4_;
      }
   }
}

