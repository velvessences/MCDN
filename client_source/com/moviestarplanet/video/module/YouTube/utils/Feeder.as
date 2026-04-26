package com.moviestarplanet.video.module.YouTube.utils
{
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.services.videoservice.valueObjects.ExternalVideoSimpleData;
   import com.moviestarplanet.utils.chatfilter.YTBlackListUtil;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import mx.controls.DateField;
   
   public class Feeder
   {
      
      public static const PAGESIZE_RELATED:int = 8;
      
      private static const BASE_SEARCH_URL:String = "https://www.googleapis.com/youtube/v3/search";
      
      private static var currentSearchQuery:String = "";
      
      private static var currentPage:int = 0;
      
      private static var previousPageToken:String = "";
      
      private static var nextPageToken:String = "";
      
      private static var cacheResults:Object = new Object();
      
      public function Feeder()
      {
         super();
      }
      
      public static function getFeed(param1:String, param2:int, param3:int, param4:Function) : void
      {
         var request:URLRequest;
         var variables:URLVariables;
         var cacheString:String = null;
         var nextPageCacheString:String = null;
         var urlLoader:URLLoader = null;
         var onSearchSuccess:Function = null;
         var onSearchFail:Function = null;
         var searchQuery:String = param1;
         var pagesize:int = param2;
         var pageIndex:int = param3;
         var returnCallback:Function = param4;
         onSearchSuccess = function(param1:Event):void
         {
            var _loc2_:String = param1.target.data as String;
            if(_loc2_ != null)
            {
               handleSearchResult(_loc2_,returnCallback,cacheString,nextPageCacheString);
            }
            urlLoader.removeEventListener(Event.COMPLETE,onSearchSuccess);
            urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,onSearchFail);
            urlLoader = null;
         };
         onSearchFail = function(param1:Event):void
         {
            returnCallback(new Array(),false);
            urlLoader.removeEventListener(Event.COMPLETE,onSearchSuccess);
            urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,onSearchFail);
            urlLoader = null;
         };
         if(searchQuery != currentSearchQuery)
         {
            currentSearchQuery = searchQuery;
            previousPageToken = "";
            nextPageToken = "";
            cacheResults = new Object();
         }
         cacheString = searchQuery + "," + pageIndex + "," + pagesize;
         nextPageCacheString = cacheString + ",hasNextPage";
         if(cacheResults[cacheString] != null)
         {
            returnCallback(cacheResults[cacheString],cacheResults[nextPageCacheString]);
            return;
         }
         encodeURIComponent(searchQuery);
         request = new URLRequest(BASE_SEARCH_URL);
         request.method = URLRequestMethod.GET;
         variables = new URLVariables();
         variables.q = searchQuery;
         variables.part = "snippet";
         variables.order = "relevance";
         variables.maxResults = pagesize.toString();
         variables.safeSearch = "strict";
         variables.videoEmbeddable = "true";
         variables.type = "video";
         variables.fields = "prevPageToken,nextPageToken,items(id(videoId),snippet(title,description,publishedAt))";
         variables.key = AppSettings.getInstance().getSetting(AppSettings.YOUTUBE_API_KEY);
         if(pageIndex < currentPage)
         {
            variables.pageToken = previousPageToken;
         }
         if(pageIndex > currentPage)
         {
            variables.pageToken = nextPageToken;
         }
         currentPage = pageIndex;
         request.data = variables;
         urlLoader = new URLLoader(request);
         urlLoader.addEventListener(Event.COMPLETE,onSearchSuccess);
         urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onSearchFail);
      }
      
      public static function handleSearchResult(param1:String, param2:Function, param3:String, param4:String) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:Object = null;
         _loc5_ = JSON.parse(param1);
         if(Boolean(_loc5_.hasOwnProperty("prevPageToken")) && _loc5_.prevPageToken != null)
         {
            previousPageToken = _loc5_.prevPageToken;
         }
         else
         {
            previousPageToken = "";
         }
         if(Boolean(_loc5_.hasOwnProperty("nextPageToken")) && _loc5_.nextPageToken != null)
         {
            nextPageToken = _loc5_.nextPageToken;
         }
         else
         {
            nextPageToken = "";
         }
         if(Boolean(_loc5_.hasOwnProperty("items")) && _loc5_.items != null)
         {
            _loc6_ = _loc5_.items as Array;
            _loc7_ = int(_loc6_.length);
            _loc8_ = new Array();
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               _loc10_ = _loc5_.items[_loc9_].snippet.title as String;
               _loc11_ = _loc5_.items[_loc9_].snippet.description as String;
               _loc12_ = YTBlackListUtil.filterTextForUnwantedWordsYouTube(_loc10_);
               _loc13_ = YTBlackListUtil.filterTextForUnwantedWordsYouTube(_loc11_);
               _loc14_ = new Object();
               _loc14_.id = (_loc5_.items[_loc9_].id as Object).videoId;
               _loc14_.title = _loc12_;
               _loc14_.description = _loc13_;
               _loc14_.date = _loc5_.items[_loc9_].snippet.publishedAt;
               _loc8_.push(getDataObject(_loc14_));
               _loc9_++;
            }
            cacheResults[param3] = _loc8_;
            cacheResults[param4] = nextPageToken != "";
            param2(_loc8_,nextPageToken != "");
         }
      }
      
      public static function checkRestricted(param1:String, param2:Function) : void
      {
         param2(false);
      }
      
      private static function getDataObject(param1:Object) : ExternalVideoSimpleData
      {
         var _loc2_:ExternalVideoSimpleData = new ExternalVideoSimpleData();
         _loc2_.ExternalRef = param1.id;
         _loc2_.Title = param1.title;
         _loc2_.YTWatchedCount = 0;
         _loc2_.DatePublished = DateField.stringToDate(String(param1.date).slice(0,10),"YYYY-MM-DD");
         _loc2_.ActorId = 0;
         _loc2_.ExternalVideoActorRelId = 0;
         _loc2_.ExternalVideoId = 0;
         _loc2_.WatchedCount = 0;
         _loc2_.Likes = 0;
         _loc2_.DateAdded = new Date();
         _loc2_.Name = "";
         _loc2_.Deleted = 0;
         _loc2_.CategoryId = -1;
         _loc2_.Restricted = false;
         return _loc2_;
      }
   }
}

