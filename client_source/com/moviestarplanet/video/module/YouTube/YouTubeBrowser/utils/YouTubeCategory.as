package com.moviestarplanet.video.module.YouTube.YouTubeBrowser.utils
{
   import com.moviestarplanet.flash.icons.YouTubeChannelIcons;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   
   public class YouTubeCategory
   {
      
      private static var _categories:Array;
      
      private var _id:int;
      
      private var _name:String;
      
      private var _translation:String;
      
      private var _iconClass:Class;
      
      public function YouTubeCategory(param1:int, param2:String, param3:String, param4:Class)
      {
         super();
         this._id = param1;
         this._name = param2;
         this._translation = param3;
         this._iconClass = param4;
      }
      
      public static function get categories() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(new YouTubeCategory(10,"Music",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_MUSIC"),YouTubeChannelIcons.MusicIcon));
         _loc1_.push(new YouTubeCategory(24,"Entertainment",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_ENTERTAINMENT"),YouTubeChannelIcons.EntertainmentIcon));
         _loc1_.push(new YouTubeCategory(1,"Film",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_FILM"),YouTubeChannelIcons.FilmIcon));
         _loc1_.push(new YouTubeCategory(23,"Comedy",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_COMEDY"),YouTubeChannelIcons.ComedyIcon));
         _loc1_.push(new YouTubeCategory(26,"Howto",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_STYLE"),YouTubeChannelIcons.StyleIcon));
         _loc1_.push(new YouTubeCategory(15,"Animals",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_ANIMALS"),YouTubeChannelIcons.AnimalsIcon));
         _loc1_.push(new YouTubeCategory(20,"Games",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_GAMES"),YouTubeChannelIcons.GamesIcon));
         _loc1_.push(new YouTubeCategory(22,"People",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_PEOPLE"),YouTubeChannelIcons.PeopleIcon));
         _loc1_.push(new YouTubeCategory(2,"Autos",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_CARS"),YouTubeChannelIcons.CarsIcon));
         _loc1_.push(new YouTubeCategory(17,"Sports",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_SPORTS"),YouTubeChannelIcons.SportIcon));
         _loc1_.push(new YouTubeCategory(28,"Tech",MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CATEGORY_TECHNOLOGY"),YouTubeChannelIcons.TechnologyIcon));
         return _loc1_;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get translation() : String
      {
         return this._translation;
      }
      
      public function get iconClass() : Class
      {
         return this._iconClass;
      }
   }
}

