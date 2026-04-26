package com.moviestarplanet.video.module.YouTube.YouTubeBrowser.utils
{
   import com.moviestarplanet.advertisement.AdvertisementManager;
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.controls.pager.PagerBuffered;
   import com.moviestarplanet.highscore.service.HighscoreAMFService;
   import com.moviestarplanet.highscore.valueobjects.HighscoreParams;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.services.videoservice.VideoServiceProvider;
   import com.moviestarplanet.utils.chatfilter.ITextInputComponent;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.video.module.YouTube.utils.Feeder;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   
   public class YouTubeBrowserHelpers
   {
      
      public static var editableId:int;
      
      private static var pager:PagerBuffered;
      
      private static var pagerParams:Object;
      
      public static const STATE_PLAYLIST:int = 1;
      
      public static const STATE_CHANNEL:int = 2;
      
      public static const STATE_SEARCH:int = 3;
      
      public static const STATE_HIGHSCORES:int = 4;
      
      public static const STATE_MSPTV:int = 5;
      
      public static const RENDERER_TYPE_PLAYLIST:String = "RENDERER_TYPE_PLAYLIST";
      
      public static const RENDERER_TYPE_CHANNEL:String = "RENDERER_TYPE_CHANNEL";
      
      public static const SNAPSHOT_URL:String = "http://i.ytimg.com/vi/{0}/0.jpg";
      
      public static const SNAPSHOT_URL_DEFAULT:String = "http://i.ytimg.com/vi/{0}/default.jpg";
      
      public static const SNAPSHOT_URL_WIDE:String = "http://i.ytimg.com/vi/{0}/mqdefault.jpg";
      
      public static const MAXIMUM_ALLOWED_PLAYLISTS_WITHOUT_VIP:int = 3;
      
      private static var PAGESIZE_PLAYLISTS_CHANNELS:int = 5;
      
      private static var PAGESIZE_VIDEOS:int = 9;
      
      public static const TAB_TOP:String = "TOP";
      
      public static const TAB_CHANNELS:String = "CHANNELS";
      
      public static const TAB_MINE:String = "MINE";
      
      public static const TAB_FRIENDS:String = "FRIENDS";
      
      public function YouTubeBrowserHelpers()
      {
         super();
      }
      
      public static function getHeadlineByHandle(param1:String) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case TAB_CHANNELS:
               _loc2_ = MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_CHANNELS");
               break;
            default:
               _loc2_ = MSPLocaleManagerWeb.getInstance().getString("YOUTUBE_PLAYLISTS");
         }
         return _loc2_;
      }
      
      public static function getPagerByHandle(param1:String, param2:String) : PagerBuffered
      {
         switch(param1)
         {
            case null:
               pagerParams = new Object();
               pagerParams.searchPhrase = param2;
               pagerParams.actorId = ActorSession.loggedInActor.ActorId;
               pager = new PagerBuffered(PAGESIZE_PLAYLISTS_CHANNELS,0,0,VideoServiceProvider.getPagedPlaylistsBySearch,pagerParams);
               break;
            case TAB_CHANNELS:
               pagerParams = new Object();
               pager = new PagerBuffered(PAGESIZE_PLAYLISTS_CHANNELS,0,0,getPagedYouTubeCategories,pagerParams);
               break;
            default:
               pagerParams = new Object();
               pagerParams.actorId = ActorSession.getActorId();
               pagerParams.searchType = getSearchTypeByHandle(param1);
               pager = new PagerBuffered(PAGESIZE_PLAYLISTS_CHANNELS,0,0,VideoServiceProvider.getPagedPlaylists,pagerParams);
         }
         pager.ensureIntegrityOnRefresh = true;
         return pager;
      }
      
      public static function getVideoPagerByState(param1:int, param2:Object) : PagerBuffered
      {
         var _loc3_:int = AdvertisementManager.getInstance().getNumVideos();
         switch(param1)
         {
            case STATE_PLAYLIST:
               pagerParams = new Object();
               pagerParams.playlistId = param2 as int;
               pager = new PagerBuffered(PAGESIZE_VIDEOS,0,0,VideoServiceProvider.getPagedVideoListObjects,pagerParams);
               break;
            case STATE_CHANNEL:
               pagerParams = new Object();
               pagerParams.categoryId = param2 as int;
               pager = new PagerBuffered(PAGESIZE_VIDEOS - _loc3_,0,0,VideoServiceProvider.getPagedCategoryExternalVideos,pagerParams);
               break;
            case STATE_SEARCH:
               pagerParams = new Object();
               pagerParams.searchQuery = param2 as String;
               pager = new PagerBuffered(PAGESIZE_VIDEOS - _loc3_,0,0,YouTubeBrowserHelpers.getPagedFeedVideos,pagerParams);
               break;
            case STATE_HIGHSCORES:
               pagerParams = new HighscoreParams();
               pagerParams.actorId = ActorSession.loggedInActor.ActorId;
               pagerParams.forFriends = false;
               pagerParams.lastWeek = true;
               pagerParams.orderBy = "LOVES";
               pager = new PagerBuffered(PAGESIZE_VIDEOS - _loc3_,0,0,new HighscoreAMFService().getHighscoreYouTube,pagerParams);
               break;
            case STATE_MSPTV:
               pager = new PagerBuffered(PAGESIZE_VIDEOS - _loc3_,0,0,VideoServiceProvider.getPagedMspTvExternalVideos);
         }
         return pager;
      }
      
      public static function getSearchTypeByHandle(param1:String) : int
      {
         switch(param1)
         {
            case TAB_TOP:
               return 3;
            case TAB_MINE:
               return 2;
            case TAB_FRIENDS:
               return 1;
            default:
               return 0;
         }
      }
      
      public static function getCategoryId(param1:String) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < YouTubeCategory.categories.length)
         {
            if(YouTubeCategory(YouTubeCategory.categories[_loc2_]).name == param1)
            {
               return YouTubeCategory(YouTubeCategory.categories[_loc2_]).id;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public static function getCategoryTranslationById(param1:int) : String
      {
         var _loc2_:int = 0;
         while(_loc2_ < YouTubeCategory.categories.length)
         {
            if(YouTubeCategory(YouTubeCategory.categories[_loc2_]).id == param1)
            {
               return YouTubeCategory(YouTubeCategory.categories[_loc2_]).translation;
            }
            _loc2_++;
         }
         return "";
      }
      
      public static function getPagedFeedVideos(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var done1:Function = null;
         var params:Object = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var resultCallback:Function = param4;
         done1 = function(param1:Array, param2:Boolean):void
         {
            var done2:Function = null;
            var result:Array = param1;
            var hasNextPage:Boolean = param2;
            done2 = function(param1:Array):void
            {
               var _loc2_:int = pagesize * (pageindex + 1);
               if(hasNextPage)
               {
                  _loc2_ += 1;
               }
               var _loc3_:PagerResultObject = new PagerResultObject(_loc2_,hasNextPage,param1,pageindex);
               resultCallback(_loc3_);
            };
            VideoServiceProvider.youTubePopulateViewsAndLikes(result,PAGESIZE_VIDEOS,done2);
         };
         Feeder.getFeed(params.searchQuery,pagesize,pageindex,done1);
      }
      
      public static function getPagedYouTubeCategories(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var _loc8_:Array = null;
         var _loc5_:Array = YouTubeCategory.categories;
         var _loc6_:* = int(param2 * param3);
         if(param2 > 0)
         {
            _loc6_--;
         }
         var _loc7_:int = _loc6_ + param3;
         var _loc9_:Boolean = true;
         if(_loc7_ > _loc5_.length)
         {
            _loc7_ = int(_loc5_.length);
            _loc9_ = false;
         }
         if(_loc6_ > _loc5_.length)
         {
            _loc8_ = [];
         }
         else
         {
            _loc8_ = _loc5_.slice(_loc6_,_loc7_);
         }
         var _loc10_:PagerResultObject = new PagerResultObject(_loc5_.length,_loc9_,_loc8_,param2);
         param4(_loc10_);
      }
      
      public static function isNameValid(param1:ITextInputComponent) : Boolean
      {
         if(param1.text.length > 30)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NAME_LESS_THAN_30"),MSPLocaleManagerWeb.getInstance().getString("WRONG_EX"));
            return false;
         }
         if(param1.text.length == 0)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NEED_WRITE_PLAYLIST_NAME"),MSPLocaleManagerWeb.getInstance().getString("WRONG_EX"));
            return false;
         }
         return true;
      }
      
      public static function notifyUserIsNotSafe() : void
      {
         Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NAME_NOT_ALLOWED"),MSPLocaleManagerWeb.getInstance().getString("NOT_ALLOWED"));
      }
      
      public static function notifyUserAlreadyHavePlaylistName() : void
      {
         Prompt.show(MSPLocaleManagerWeb.getInstance().getString("ALREADY_HAVE_PLAYLIST_NAME"),MSPLocaleManagerWeb.getInstance().getString("WRONG_EX"));
      }
      
      public static function notifyUserPlaylistRenamed() : void
      {
         Prompt.showFriendly(MSPLocaleManagerWeb.getInstance().getString("PLAYLIST_RENAMED"),MSPLocaleManagerWeb.getInstance().getString("PLAYLIST_RENAMED"));
      }
      
      public static function notifyUserPlaylistCreated() : void
      {
         Prompt.showFriendly(MSPLocaleManagerWeb.getInstance().getString("PLAYLIST_BEEN_CREATED"),MSPLocaleManagerWeb.getInstance().getString("PLAYLIST_CREATED"));
      }
   }
}

