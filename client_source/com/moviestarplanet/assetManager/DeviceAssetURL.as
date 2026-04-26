package com.moviestarplanet.assetManager
{
   public class DeviceAssetURL implements IAssetUrl
   {
      
      public static const DEFAULT:int = 0;
      
      public static const LOGIN_SCREEN:int = 1;
      
      public static const FONTS:int = 2;
      
      public static const CONTENTBROWSER:int = 3;
      
      public static const FRIENDS_ASSETS:int = 4;
      
      public static const THIRDPARTY_ASSETS:int = 5;
      
      public static const MULTIPLAYER_GAMES:int = 6;
      
      public static const TUTORIAL:int = 7;
      
      public static const ACTIVITY_BAR:int = 8;
      
      public static const DESIGN_STUDIO:int = 9;
      
      public static const PORTRAIT:int = 10;
      
      public static const GAME_SPIN:int = 11;
      
      public static const PIGGY_BANK:int = 12;
      
      public static const PAYMENT:int = 13;
      
      public static const PICTURE_UPLOAD:int = 14;
      
      public static const WORLD:int = 15;
      
      public static const EMOTICONS:int = 16;
      
      public static const POPUPS:int = 17;
      
      public static const ICONS:int = 18;
      
      public static const SHOPS:int = 19;
      
      public static const ARTBOOK:int = 20;
      
      public static const MOVIESTAR:int = 21;
      
      public static const SOUNDS:int = 22;
      
      public static const NEWS_SLIDER:int = 23;
      
      public static const WINDOWS_UI:int = 24;
      
      public static const MOVIE_STUDIO:int = 25;
      
      public static const MOBILE_UI:int = 26;
      
      private static const LOGIN_SCREEN_SUBPATH:String = ASSETS_FOLDER + "login/";
      
      private static const THIRDPARTY_SUBPATH:String = ASSETS_FOLDER + "thirdparty/";
      
      private static const CONTENTBROWSER_SUBPATH:String = ASSETS_FOLDER + "contentbrowser/";
      
      private static const FONTS_SUBPATH:String = ASSETS_FOLDER + "fonts/";
      
      private static const FRIENDS_SUBPATH:String = ASSETS_FOLDER + "friends/";
      
      private static const MULTIPLAYER_GAMES_SUBPATH:String = ASSETS_FOLDER + "multiplayergames/";
      
      private static const DESIGN_STUDIO_SUBPATH:String = ASSETS_FOLDER + "designstudio/";
      
      private static const TUTORIAL_SUBPATH:String = ASSETS_FOLDER + "tutorial/";
      
      private static const ACTIVITY_BAR_SUBPATH:String = ASSETS_FOLDER + "activitybar/";
      
      private static const PORTRAIT_SUBPATH:String = ASSETS_FOLDER + "portrait/";
      
      private static const GAME_SPIN_SUBPATH:String = ASSETS_FOLDER + "gamespin/";
      
      private static const WORLD_SUBPATH:String = ASSETS_FOLDER + "world/";
      
      private static const PIGGY_BANK_SUBPATH:String = ASSETS_FOLDER + "piggybank/";
      
      private static const PAYMENT_SUBPATH:String = ASSETS_FOLDER + "payment/";
      
      private static const PICTURE_UPLOAD_SUBPATH:String = ASSETS_FOLDER + "pictures/";
      
      private static const EMOTICONS_SUBPATH:String = ASSETS_FOLDER + "emoticons/";
      
      private static const POPUPS_SUBPATH:String = ASSETS_FOLDER + "popups/";
      
      private static const ICONS_SUBPATH:String = ASSETS_FOLDER + "icons/";
      
      private static const SHOPS_SUBPATH:String = ASSETS_FOLDER + "shops/";
      
      private static const ARTBOOK_SUBPATH:String = ASSETS_FOLDER + "artbook/";
      
      private static const MOVIESTAR_SUBPATH:String = ASSETS_FOLDER + "moviestar/";
      
      private static const SOUNDS_SUBPATH:String = ASSETS_FOLDER + "sounds/";
      
      private static const NEWS_SLIDER_SUBPATH:String = ASSETS_FOLDER + "newsslider/";
      
      private static const WINDOWS_UI_SUBPATH:String = ASSETS_FOLDER + "windowsui/";
      
      private static const MOVIE_STUDIO_SUBPATH:String = ASSETS_FOLDER + "moviestudio/";
      
      private static const MOBILE_UI_SUBPATH:String = ASSETS_FOLDER + "mobileuicomponents/";
      
      private static const ASSETS_FOLDER:String = "assets/";
      
      private var _path:String;
      
      public function DeviceAssetURL(param1:String, param2:int)
      {
         super();
         this._path = this.prefix(param2) + escape(param1);
      }
      
      public function getAbsolutePath() : String
      {
         return this._path;
      }
      
      public function getRootRelativePath() : String
      {
         return this._path;
      }
      
      private function prefix(param1:int) : String
      {
         switch(param1)
         {
            case WORLD:
               return WORLD_SUBPATH;
            case LOGIN_SCREEN:
               return LOGIN_SCREEN_SUBPATH;
            case CONTENTBROWSER:
               return CONTENTBROWSER_SUBPATH;
            case FONTS:
               return FONTS_SUBPATH;
            case FRIENDS_ASSETS:
               return FRIENDS_SUBPATH;
            case THIRDPARTY_ASSETS:
               return THIRDPARTY_SUBPATH;
            case MULTIPLAYER_GAMES:
               return MULTIPLAYER_GAMES_SUBPATH;
            case TUTORIAL:
               return TUTORIAL_SUBPATH;
            case ACTIVITY_BAR:
               return ACTIVITY_BAR_SUBPATH;
            case DESIGN_STUDIO:
               return DESIGN_STUDIO_SUBPATH;
            case PORTRAIT:
               return PORTRAIT_SUBPATH;
            case GAME_SPIN:
               return GAME_SPIN_SUBPATH;
            case PIGGY_BANK:
               return PIGGY_BANK_SUBPATH;
            case PAYMENT:
               return PAYMENT_SUBPATH;
            case PICTURE_UPLOAD:
               return PICTURE_UPLOAD_SUBPATH;
            case EMOTICONS:
               return EMOTICONS_SUBPATH;
            case POPUPS:
               return POPUPS_SUBPATH;
            case ICONS:
               return ICONS_SUBPATH;
            case SHOPS:
               return SHOPS_SUBPATH;
            case ARTBOOK:
               return ARTBOOK_SUBPATH;
            case MOVIESTAR:
               return MOVIESTAR_SUBPATH;
            case SOUNDS:
               return SOUNDS_SUBPATH;
            case NEWS_SLIDER:
               return NEWS_SLIDER_SUBPATH;
            case WINDOWS_UI:
               return WINDOWS_UI_SUBPATH;
            case MOVIE_STUDIO:
               return MOVIE_STUDIO_SUBPATH;
            case MOBILE_UI:
               return MOBILE_UI_SUBPATH;
            default:
               return "";
         }
      }
      
      public function get path() : String
      {
         return this._path;
      }
   }
}

