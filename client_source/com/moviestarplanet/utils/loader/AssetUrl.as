package com.moviestarplanet.utils.loader
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.loader.ILoaderUrl;
   
   public class AssetUrl implements ILoaderUrl, IAssetUrl
   {
      
      public static const DEFAULT:int = 0;
      
      public static const WORLD:int = 1;
      
      public static const ICON:int = 2;
      
      public static const NEWS:int = 3;
      
      public static const SWF:int = 4;
      
      public static const CAMPAIGNS:int = 7;
      
      public static const ASSETS:int = 8;
      
      public static const QUEST:int = 9;
      
      public static const SOUNDS:int = 10;
      
      public static const SHOPPING_SPREE:int = 5;
      
      public static const AD_PLAYER:int = 6;
      
      private static const WORLD_SUBPATH:String = "swf/world/";
      
      private static const ICON_SUBPATH:String = "swf/icons/";
      
      private static const NEWS_SUBPATH:String = "news/";
      
      private static const CAMPAIGNS_SUBPATH:String = "campaigns/";
      
      private static const SWF_SUBPATH:String = "swf/";
      
      private static const QUEST_SUBPATH:String = "swf/quest/";
      
      private static const SHOPPING_SPREE_SUBPATH:String = "swf/shops/";
      
      private static const ASSETS_SUBPATH:String = "assets/";
      
      private static const SOUNDS_SUBPATH:String = "sounds/";
      
      public static var serverCdnPrefix:String = "";
      
      private var _path:String;
      
      public function AssetUrl(param1:String, param2:int, param3:Date = null)
      {
         super();
         if(param3 != null)
         {
            this._path = this.prefix(param2) + escape(param1) + this.postFix(param2,param1) + "?v=" + param3.time;
         }
         else
         {
            this._path = this.prefix(param2) + escape(param1) + this.postFix(param2,param1);
         }
      }
      
      public function getAbsolutePath() : String
      {
         return this.toString();
      }
      
      public function getRootRelativePath() : String
      {
         return this._path;
      }
      
      private function postFix(param1:int, param2:String = "") : String
      {
         var _loc3_:String = "";
         switch(param1)
         {
            case CAMPAIGNS:
               _loc3_ = "_screen.swf";
         }
         var _loc4_:String = (this.prefix(param1) + escape(param2) + _loc3_).toLowerCase();
         var _loc5_:String = VersionURLAppender.getInstance().getURLVersionPostfix(_loc4_);
         return _loc3_ + _loc5_;
      }
      
      private function prefix(param1:int) : String
      {
         switch(param1)
         {
            case SWF:
               return SWF_SUBPATH;
            case WORLD:
               return WORLD_SUBPATH;
            case ICON:
               return ICON_SUBPATH;
            case NEWS:
               return NEWS_SUBPATH;
            case CAMPAIGNS:
               return CAMPAIGNS_SUBPATH;
            case SHOPPING_SPREE:
               return SHOPPING_SPREE_SUBPATH;
            case ASSETS:
               return ASSETS_SUBPATH;
            case QUEST:
               return QUEST_SUBPATH;
            case SOUNDS:
               return SOUNDS_SUBPATH;
            default:
               return "";
         }
      }
      
      public function toString() : String
      {
         return serverCdnPrefix + this.path;
      }
      
      public function get path() : String
      {
         return this._path;
      }
      
      public function allowCodeImport() : Boolean
      {
         return true;
      }
   }
}

