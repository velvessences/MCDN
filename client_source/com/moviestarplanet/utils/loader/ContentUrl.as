package com.moviestarplanet.utils.loader
{
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.loader.ILoaderUrl;
   import flash.utils.getTimer;
   
   public class ContentUrl implements ILoaderUrl, IAssetUrl
   {
      
      public static const SKIN:int = 1;
      
      public static const ANIMATION:int = 2;
      
      public static const FACEPART:int = 3;
      
      public static const CLOTH:int = 4;
      
      public static const PET:int = 5;
      
      public static const BACKGROUND:int = 6;
      
      public static const CLIPART:int = 7;
      
      public static const MUSIC:int = 8;
      
      public static const PURCHASE:int = 9;
      
      public static const FRONT_PAGE_SLIDE:int = 10;
      
      public static const ANIMATION_SNAPSHOT:int = 11;
      
      public static const FACEPART_DRAGONBONE:int = 12;
      
      public static const BONSTER_SWF:int = 13;
      
      public static const BACKGROUND_SNAPSHOT:int = 14;
      
      public static const STUFF:int = 16;
      
      public static const DRAGONSTAR_ANIMATION_SPRITESHEET:int = 17;
      
      public static const DRAGONSTAR_ANIMATION_DATA:int = 18;
      
      public static const WORLD:int = 19;
      
      public static const SWF:int = 20;
      
      public static const ASSET_DEFINITIONS:int = 21;
      
      public static const CAMPAIGNS:int = 22;
      
      public static const NEWS:int = 23;
      
      public static const MARKETING_GIFT:int = 24;
      
      public static const THEME:int = 25;
      
      public static const SC_CAMPAIGN:int = 26;
      
      public static const COMPRESSED_ANIMATION:int = 27;
      
      private static const ANIMATIONS_SUBPATH:String = "swf/animations/";
      
      private static const SKINS_SUBPATH:String = "swf/skins/";
      
      private static const FACEPARTS_SUBPATH:String = "swf/faceparts/";
      
      private static const CLOTHES_SUBPATH:String = "swf/";
      
      private static const GRAPHICS_SUBPATH:String = "graphics/";
      
      private static const MUSIC_SUBPATH:String = "music/";
      
      private static const BACKGROUND_SUBPATH:String = "backgrounds/";
      
      private static const BACKGROUND_SNAPSHOT_SUBPATH:String = "backgrounds/snapshots/";
      
      private static const CLIPART_SUBPATH:String = "clipart/";
      
      private static const PET_SUBPATH:String = "swf/clickitems/";
      
      private static const PURCHASE_SUBPATH:String = "swf/purchase/";
      
      public static const DRAGONBONE_FACEPARTS_SUBPATH:String = "swf/dragonbone_faceparts/";
      
      public static const DRAGONBONE_FACEPARTS_SUBPATH_MOBILE:String = "swf/dragonbone_faceparts/mobile/";
      
      private static const BONSTER_SWF_SUBPATH:String = "swf/bonsters/png/";
      
      private static const STUFF_SUBPATH:String = "swf/stuff/";
      
      private static const DRAGONSTAR_ANIMATION_SUBPATH:String = "content/dragonstar/animations/";
      
      private static const WORLD_SUBPATH:String = "swf/world/";
      
      private static const SWF_SUBPATH:String = "swf/";
      
      private static const ASSET_DEFINITIONS_SUBPATH:String = "asset_definitions/";
      
      private static const CAMPAIGNS_SUBPATH:String = "marketing/sponsoredcharacters/";
      
      private static const NEWS_SUBPATH:String = "news/";
      
      private static const MARKETING_GIFT_SUBPATH:String = "";
      
      private static const THEME_SUBPATH:String = "";
      
      private static const SC_CAMPAIGN_SUBPATH:String = "campaigns/";
      
      private static const COMPRESSED_ANIMATION_SUBPATH:String = "content/dragonstar/animations/";
      
      private static const SKIN_VERSION:String = "10dc";
      
      private static const swf:String = ".swf";
      
      private static const png:String = ".png";
      
      private static const jsonC:String = ".jsonc";
      
      private static const dat:String = ".txt";
      
      private static const imageC:String = ".imagec";
      
      public static var serverCdnPrefix:String = "";
      
      public static var countryCode:String = "";
      
      public static var forceReload:Boolean = false;
      
      private var _path:String;
      
      public function ContentUrl(param1:String, param2:int, param3:Date = null)
      {
         super();
         if(param3 != null)
         {
            this._path = prefix(param2) + escapeInternal(param1) + postFix(param2) + "?v=" + param3.time;
         }
         else
         {
            this._path = prefix(param2) + escapeInternal(param1) + postFix(param2);
         }
      }
      
      private static function postFix(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case SKIN:
               _loc2_ += SKIN_VERSION + swf;
               break;
            case ANIMATION:
            case FACEPART_DRAGONBONE:
            case FACEPART:
               _loc2_ += swf;
               break;
            case BACKGROUND_SNAPSHOT:
            case ANIMATION_SNAPSHOT:
            case DRAGONSTAR_ANIMATION_SPRITESHEET:
               _loc2_ += png;
               break;
            case CLOTH:
               break;
            case BONSTER_SWF:
               _loc2_ += "1/swf" + swf;
               break;
            case DRAGONSTAR_ANIMATION_DATA:
               _loc2_ += jsonC;
               break;
            case ASSET_DEFINITIONS:
               _loc2_ += dat;
               break;
            case SC_CAMPAIGN:
               _loc2_ += "_screen.swf";
               break;
            case COMPRESSED_ANIMATION:
               _loc2_ += imageC;
         }
         if(forceReload)
         {
            _loc2_ += "?v= " + getTimer();
         }
         return _loc2_;
      }
      
      private static function prefix(param1:int) : String
      {
         switch(param1)
         {
            case SKIN:
               return SKINS_SUBPATH;
            case ANIMATION:
            case ANIMATION_SNAPSHOT:
               return ANIMATIONS_SUBPATH;
            case FACEPART:
               return FACEPARTS_SUBPATH;
            case CLOTH:
               return CLOTHES_SUBPATH;
            case PET:
               return PET_SUBPATH;
            case BACKGROUND:
               return BACKGROUND_SUBPATH;
            case BACKGROUND_SNAPSHOT:
               return BACKGROUND_SNAPSHOT_SUBPATH;
            case CLIPART:
               return CLIPART_SUBPATH;
            case MUSIC:
               return MUSIC_SUBPATH;
            case PURCHASE:
               return PURCHASE_SUBPATH;
            case FRONT_PAGE_SLIDE:
               return GRAPHICS_SUBPATH;
            case FACEPART_DRAGONBONE:
               return DRAGONBONE_FACEPARTS_SUBPATH;
            case BONSTER_SWF:
               return BONSTER_SWF_SUBPATH;
            case STUFF:
               return STUFF_SUBPATH;
            case DRAGONSTAR_ANIMATION_DATA:
            case DRAGONSTAR_ANIMATION_SPRITESHEET:
               return DRAGONSTAR_ANIMATION_SUBPATH;
            case WORLD:
               return WORLD_SUBPATH;
            case SWF:
               return SWF_SUBPATH;
            case ASSET_DEFINITIONS:
               return ASSET_DEFINITIONS_SUBPATH;
            case CAMPAIGNS:
               return countryCode + "/" + CAMPAIGNS_SUBPATH;
            case NEWS:
               return countryCode + "/" + NEWS_SUBPATH;
            case SC_CAMPAIGN:
               return countryCode + "/" + SC_CAMPAIGN_SUBPATH;
            case MARKETING_GIFT:
               return countryCode + "/" + MARKETING_GIFT_SUBPATH;
            case THEME:
               return countryCode + "/" + THEME_SUBPATH;
            case COMPRESSED_ANIMATION:
               return COMPRESSED_ANIMATION_SUBPATH;
            default:
               return "";
         }
      }
      
      private static function escapeInternal(param1:String) : String
      {
         return escape(param1.replace(/æ/g,"ae").replace(/ø/g,"oe").replace(/å/g,"aa"));
      }
      
      public function getAbsolutePath() : String
      {
         return this.toString();
      }
      
      public function getRootRelativePath() : String
      {
         return this._path;
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

