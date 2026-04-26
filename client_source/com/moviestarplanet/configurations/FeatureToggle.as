package com.moviestarplanet.configurations
{
   import com.moviestarplanet.commonvalueobjects.login.FeatureValueObject;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import mx.collections.ArrayCollection;
   
   public class FeatureToggle
   {
      
      private static var features:Object;
      
      public static const GIVE_GIFT:String = "GIVE_GIFT";
      
      public static const TRADE:String = "TRADE";
      
      public static const FAME_MAGAZINE:String = "FAME_MAGAZINE";
      
      public static const CREATE_AND_RATE:String = "CREATE_AND_RATE";
      
      public static const CREATE_AND_RATE_SUBMIT:String = "CREATE_AND_RATE_SUBMIT";
      
      public static const HIGHSCORES:String = "HIGHSCORES";
      
      public static const MOVIES:String = "MOVIES";
      
      public static const YOUTUBE_V2:String = "YOUTUBE_V2";
      
      public static const DEFAULT_ACTION_MENU:String = "DEFAULT_ACTION_MENU";
      
      public static const MOVIE_EDITOR:String = "MOVIE_EDITOR";
      
      public static const CHATROOM_ACTION_MENU:String = "CHATROOM_ACTION_MENU";
      
      public static const MOBILE_MOVIES_ANIMATED_PROPS:String = "MOBILE_MOVIES_ANIMATED_PROPS";
      
      public static const SAVE_SNAPSHOT_ON_ENTER_ROOM:String = "SAVE_SNAPSHOT_ON_ENTER_ROOM";
      
      public static const INCENTIVIZED_ADVERTISEMENT:String = "INCENTIVIZED_ADVERTISEMENT";
      
      public static const ACTOR_BLOCK_RELOAD_MOBILE:String = "ACTOR_BLOCK_RELOAD_MOBILE";
      
      public static const EXTENDED_GIFTING:String = "EXTENDED_GIFTING";
      
      public static const VPAID_LOADER_CONTEXT:String = "VPAID_LOADER_CONTEXT";
      
      public static const DRAGONSTAR_USE_BAKED_SPRITESHEETS:String = "DRAGONSTAR_USE_BAKED_SPRITESHEETS";
      
      public static const COMPRESS_CHATROOM_ACTOR:String = "COMPRESS_CHATROOM_ACTOR_COMMUNICATION";
      
      public static const NUDGE_SERVICE:String = "NUDGE_SERVICE";
      
      public static const MOVIESTUDIO_ADD_SCENES:String = "MOVIESTUDIO_ADD_SCENES";
      
      public function FeatureToggle()
      {
         super();
      }
      
      public static function getFeatureActive(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         if(features != null)
         {
            _loc2_ = features[param1] == true;
         }
         return _loc2_;
      }
      
      public static function setActiveFeatures(param1:ArrayCollection) : void
      {
         var _loc2_:FeatureValueObject = null;
         features = new Object();
         for each(_loc2_ in param1)
         {
            if(isActiveForPlatform(_loc2_.Platforms))
            {
               features[_loc2_.Name] = true;
            }
         }
      }
      
      private static function isActiveForPlatform(param1:ArrayCollection) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         for each(_loc3_ in param1)
         {
            switch(_loc3_)
            {
               case FeatureValueObject.PLATFORM_WEB:
                  if(_loc2_ == false)
                  {
                     _loc2_ = ConstantsPlatform.isWeb;
                  }
                  break;
               case FeatureValueObject.PLATFORM_GOOGLE:
                  if(_loc2_ == false)
                  {
                     _loc2_ = ConstantsPlatform.isAndroid && ConstantsPlatform.isKindle == false;
                  }
                  break;
               case FeatureValueObject.PLATFORM_IOS:
                  if(_loc2_ == false)
                  {
                     _loc2_ = ConstantsPlatform.isIOS;
                  }
                  break;
               case FeatureValueObject.PLATFORM_KINDLE:
                  if(_loc2_ == false)
                  {
                     _loc2_ = ConstantsPlatform.isKindle;
                  }
            }
         }
         return _loc2_;
      }
   }
}

