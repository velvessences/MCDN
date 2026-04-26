package com.moviestarplanet.utils.loader
{
   public class VersionURLAppender
   {
      
      private static var _instance:VersionURLAppender = null;
      
      public var releaseVersion:String = "";
      
      public function VersionURLAppender(param1:Function = null)
      {
         super();
         if(param1 != singletonBlocker)
         {
            throw new Error("VersionURLAppender is a singleton class, use VersionURLAppender.getInstance() instead!");
         }
      }
      
      private static function singletonBlocker() : void
      {
      }
      
      public static function getInstance() : VersionURLAppender
      {
         if(_instance == null)
         {
            _instance = new VersionURLAppender(singletonBlocker);
         }
         return _instance;
      }
      
      public function getURLVersionPostfix(param1:String) : String
      {
         var _loc2_:String = VersionList.versionList[param1];
         if(_loc2_)
         {
            return "?v=" + _loc2_ + "&r=" + this.releaseVersion;
         }
         return "";
      }
   }
}

