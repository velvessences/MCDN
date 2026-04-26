package com.moviestarplanet.commonvalueobjects.login
{
   import mx.collections.ArrayCollection;
   
   public class FeatureValueObject
   {
      
      public static var PLATFORM_WEB:int = 0;
      
      public static var PLATFORM_GOOGLE:int = 1;
      
      public static var PLATFORM_IOS:int = 2;
      
      public static var PLATFORM_KINDLE:int = 3;
      
      public var FeatureId:int;
      
      public var Name:String;
      
      public var Platforms:ArrayCollection;
      
      public function FeatureValueObject()
      {
         super();
      }
   }
}

