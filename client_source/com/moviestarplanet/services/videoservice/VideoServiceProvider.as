package com.moviestarplanet.services.videoservice
{
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.services.videoservice.valueObjects.ExternalVideoData;
   import com.moviestarplanet.services.videoservice.valueObjects.ExternalVideoReturnData;
   import com.moviestarplanet.services.videoservice.valueObjects.PlaylistInfoData;
   import com.moviestarplanet.services.videoservice.valueObjects.YTPlaylistData;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.UserBehaviorControl;
   import com.moviestarplanet.userbehavior.valueObjects.UserGeneratedContentField;
   import com.moviestarplanet.userbehavior.valueObjects.UserGeneratedContentType;
   
   public class VideoServiceProvider
   {
      
      private static const CODE_SUCCESS:int = 0;
      
      public function VideoServiceProvider()
      {
         super();
      }
      
      public static function autoSaveVideoFromFeed(param1:int, param2:String, param3:String, param4:Date, param5:int, param6:Function) : void
      {
         var onGotCategory:Function = null;
         var doneCallback:Function = null;
         var fetcher:YoutubeAPIFieldsFetcher = null;
         var actorId:int = param1;
         var externalRef:String = param2;
         var title:String = param3;
         var date:Date = param4;
         var oldCategoryId:int = param5;
         var resultCallback:Function = param6;
         onGotCategory = function(param1:Object):void
         {
            VideoAmfService.autoSaveVideoFromFeed(actorId,externalRef,title,date,param1.categoryId,doneCallback);
         };
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as ExternalVideoData);
            }
         };
         if(oldCategoryId <= 0)
         {
            fetcher = new YoutubeAPIFieldsFetcher(onGotCategory);
            fetcher.getApiFields(externalRef,["categoryId"]);
         }
         else
         {
            onGotCategory({"categoryId":oldCategoryId});
         }
      }
      
      public static function deleteExternalVideoPlaylistRel(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var externalVideoId:int = param2;
         var playlistId:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as int);
            }
         };
         VideoAmfService.deleteExternalVideoPlaylistRel(actorId,externalVideoId,playlistId,doneCallback);
      }
      
      public static function youTubeBlock(param1:int, param2:String, param3:String, param4:Boolean, param5:Function) : void
      {
         var doneCallback:Function = null;
         var externalVideoId:int = param1;
         var adminUserName:String = param2;
         var adminPassword:String = param3;
         var deletebool:Boolean = param4;
         var resultCallback:Function = param5;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as int);
            }
         };
         VideoAmfService.youTubeBlock(externalVideoId,adminUserName,adminPassword,deletebool,doneCallback);
      }
      
      public static function getYouTubeVideo(param1:int, param2:int, param3:Function) : void
      {
         var doneCallback:Function = null;
         var externalVideoId:int = param1;
         var likeActorId:int = param2;
         var resultCallback:Function = param3;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as ExternalVideoData);
            }
         };
         VideoAmfService.getYouTubeVideo(externalVideoId,likeActorId,doneCallback);
      }
      
      public static function youTubePopulateViewsAndLikes(param1:Array, param2:int, param3:Function) : void
      {
         var doneCallback:Function = null;
         var paramList:Array = param1;
         var amountOfVideosWanted:int = param2;
         var resultCallback:Function = param3;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as Array);
            }
         };
         VideoAmfService.youTubePopulateViewsAndLikes(paramList,amountOfVideosWanted,doneCallback);
      }
      
      public static function likeYouTube(param1:int, param2:int, param3:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var externalVideoId:int = param2;
         var resultCallback:Function = param3;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1.liked as Boolean);
            }
         };
         VideoAmfService.likeYouTube(actorId,externalVideoId,doneCallback);
      }
      
      public static function likePlaylist(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var playlistId:int = param2;
         var playlistCreatorId:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1.liked as Boolean);
            }
         };
         VideoAmfService.likePlaylist(actorId,playlistId,playlistCreatorId,doneCallback);
      }
      
      public static function getPlaylistForPlayback(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var playlistId:int = param1;
         var likeActorId:int = param2;
         var externalVideoId:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as PlaylistInfoData);
            }
         };
         VideoAmfService.getPlaylistForPlayback(playlistId,likeActorId,externalVideoId,doneCallback);
      }
      
      public static function getCategoryExternalVideosForPlayback(param1:int, param2:int, param3:Function) : void
      {
         var doneCallback:Function = null;
         var categoryId:int = param1;
         var likeActorId:int = param2;
         var resultCallback:Function = param3;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as PlaylistInfoData);
            }
         };
         VideoAmfService.getCategoryExternalVideosForPlayback(categoryId,likeActorId,doneCallback);
      }
      
      public static function getVideoInfo(param1:String, param2:Function) : void
      {
         var doneCallback:Function = null;
         var externalVideoID:String = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         VideoAmfService.getVideoInfo(externalVideoID,doneCallback);
      }
      
      public static function getMspTvExternalVideosForPlayback(param1:int, param2:Function) : void
      {
         var doneCallback:Function = null;
         var likeActorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as PlaylistInfoData);
            }
         };
         VideoAmfService.getMspTvExternalVideosForPlayback(likeActorId,doneCallback);
      }
      
      public static function getTopExternalVideosForPlayback(param1:int, param2:Function) : void
      {
         var doneCallback:Function = null;
         var likeActorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as PlaylistInfoData);
            }
         };
         VideoAmfService.getTopExternalVideosForPlayback(likeActorId,doneCallback);
      }
      
      public static function getPlaylistsForDropdown(param1:int, param2:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1);
            }
         };
         VideoAmfService.getPlaylistsForDropdown(actorId,doneCallback);
      }
      
      public static function getPlaylist(param1:int, param2:int, param3:Function) : void
      {
         var doneCallback:Function = null;
         var playlistId:int = param1;
         var likeActorId:int = param2;
         var resultCallback:Function = param3;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as YTPlaylistData);
            }
         };
         VideoAmfService.getPlaylist(playlistId,likeActorId,doneCallback);
      }
      
      public static function getPagedPlaylists(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var loadParams:Object = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.items.length == pagesize;
            var _loc3_:Array = new Array();
            var _loc4_:int = 0;
            while(_loc4_ < param1.items.length)
            {
               _loc3_[_loc4_] = param1.items[_loc4_];
               _loc4_++;
            }
            var _loc5_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageindex);
            resultCallback(_loc5_);
         };
         VideoAmfService.getPagedPlaylists(loadParams.actorId,pageindex,pagesize,loadParams.searchType,doneCallback);
      }
      
      public static function getPagedPlaylistsBySearch(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var loadParams:Object = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.items.length == pagesize;
            var _loc3_:Array = new Array();
            var _loc4_:int = 0;
            while(_loc4_ < param1.items.length)
            {
               _loc3_[_loc4_] = param1.items[_loc4_];
               _loc4_++;
            }
            var _loc5_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageindex);
            resultCallback(_loc5_);
         };
         VideoAmfService.getPagedPlaylistsBySearch(loadParams.actorId,pageindex,pagesize,loadParams.searchPhrase,doneCallback);
      }
      
      public static function getPagedExternalVideos(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var loadParams:Object = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.items.length == pagesize;
            var _loc3_:Array = new Array();
            var _loc4_:int = 0;
            while(_loc4_ < param1.items.length)
            {
               _loc3_[_loc4_] = param1.items[_loc4_];
               _loc4_++;
            }
            var _loc5_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageindex);
            resultCallback(_loc5_);
         };
         VideoAmfService.getPagedExternalVideos(loadParams.playlistId,pageindex,pagesize,doneCallback);
      }
      
      public static function getPagedVideoListObjects(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var loadParams:Object = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.items.length == pagesize;
            var _loc3_:Array = new Array();
            var _loc4_:int = 0;
            while(_loc4_ < param1.items.length)
            {
               _loc3_[_loc4_] = param1.items[_loc4_];
               _loc4_++;
            }
            var _loc5_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageindex);
            resultCallback(_loc5_);
         };
         VideoAmfService.getPagedVideoListObjects(loadParams.playlistId,pageindex,pagesize,doneCallback);
      }
      
      public static function getPagedVideoListObjectsByAddTime(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.items.length == pagesize;
            var _loc3_:Array = new Array();
            var _loc4_:int = 0;
            while(_loc4_ < param1.items.length)
            {
               _loc3_[_loc4_] = param1.items[_loc4_];
               _loc4_++;
            }
            var _loc5_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageindex);
            resultCallback(_loc5_);
         };
         VideoAmfService.getPagedVideoListObjectsByAddTime(actorId,pageindex,pagesize,doneCallback);
      }
      
      public static function getPagedNewestExternalVideos(param1:int, param2:int, param3:Function) : void
      {
         var doneCallback:Function = null;
         var pageindex:int = param1;
         var pagesize:int = param2;
         var resultCallback:Function = param3;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.items.length == pagesize;
            var _loc3_:Array = new Array();
            var _loc4_:int = 0;
            while(_loc4_ < param1.items.length)
            {
               _loc3_[_loc4_] = param1.items[_loc4_];
               _loc4_++;
            }
            var _loc5_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageindex);
            resultCallback(_loc5_);
         };
         VideoAmfService.getPagedNewestExternalVideos(pageindex,pagesize,doneCallback);
      }
      
      public static function getPagedCategoryExternalVideos(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var pagerParams:Object = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.items.length == pagesize;
            var _loc3_:Array = new Array();
            var _loc4_:int = 0;
            while(_loc4_ < param1.items.length)
            {
               _loc3_[_loc4_] = param1.items[_loc4_];
               _loc4_++;
            }
            var _loc5_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageindex);
            resultCallback(_loc5_);
         };
         VideoAmfService.getPagedCategoryExternalVideos(pagerParams.categoryId,pageindex,pagesize,doneCallback);
      }
      
      public static function saveToPlaylist(param1:int, param2:int, param3:String, param4:int, param5:Function) : void
      {
         var doneCallback:Function = null;
         var playlistId:int = param1;
         var externalVideoId:int = param2;
         var externalRef:String = param3;
         var actorId:int = param4;
         var resultCallback:Function = param5;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as ExternalVideoReturnData);
            }
         };
         VideoAmfService.saveToPlaylist(playlistId,externalVideoId,externalRef,actorId,doneCallback);
      }
      
      public static function saveToNewPlaylist(param1:String, param2:int, param3:String, param4:int, param5:String, param6:Function) : void
      {
         var doneCallback:Function = null;
         var playlistname:String = param1;
         var externalVideoId:int = param2;
         var externalRef:String = param3;
         var actorId:int = param4;
         var actorName:String = param5;
         var resultCallback:Function = param6;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as ExternalVideoReturnData);
            }
         };
         VideoAmfService.saveToNewPlaylist(playlistname,externalVideoId,externalRef,actorId,actorName,doneCallback);
      }
      
      public static function createBlankPlaylist(param1:String, param2:UserBehaviorResult, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var playlistname:String = param1;
         var userBehaviorResult:UserBehaviorResult = param2;
         var actorId:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:ExternalVideoReturnData = param1 as ExternalVideoReturnData;
            if(_loc2_.StatusCode == CODE_SUCCESS)
            {
               UserBehaviorControl.getInstance().submitUGC(InputLocations.LOC_YOUTUBE,_loc2_.PlaylistId,getActor().actorId,[new UserGeneratedContentField(UserGeneratedContentType.DESCR_YOUTUBE,playlistname,UserGeneratedContentType.TEXT)]);
            }
            if(resultCallback != null)
            {
               resultCallback(_loc2_.StatusCode);
            }
         };
         var embeddedFilterName:String = UserBehaviorMessageFormatter.getInstance().embedFilteredMessages2(playlistname,userBehaviorResult);
         VideoAmfService.createBlankPlaylist(embeddedFilterName,actorId,doneCallback);
      }
      
      public static function deletePlaylist(param1:int, param2:Boolean, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var moderator:Boolean = param2;
         var playlistId:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as int);
            }
         };
         VideoAmfService.deletePlaylist(actorId,moderator,playlistId,doneCallback);
      }
      
      public static function moveVideoInPlaylist(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var playlistId:int = param1;
         var externalVideoId:int = param2;
         var direction:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as int);
            }
         };
         VideoAmfService.moveVideoInPlaylist(playlistId,externalVideoId,getActor().actorId,getActor().isModerator,direction,doneCallback);
      }
      
      public static function renamePlaylist(param1:int, param2:String, param3:UserBehaviorResult, param4:int, param5:Function) : void
      {
         var doneCallback:Function = null;
         var playlistId:int = param1;
         var newname:String = param2;
         var userBehaviorResult:UserBehaviorResult = param3;
         var actorId:int = param4;
         var resultCallback:Function = param5;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as int);
            }
         };
         var embeddedFilterName:String = UserBehaviorMessageFormatter.getInstance().embedFilteredMessages2(newname,userBehaviorResult);
         VideoAmfService.renamePlaylist(playlistId,embeddedFilterName,actorId,doneCallback);
         UserBehaviorControl.getInstance().submitUGC(InputLocations.LOC_YOUTUBE,playlistId,getActor().actorId,[new UserGeneratedContentField(UserGeneratedContentType.DESCR_YOUTUBE,newname,UserGeneratedContentType.TEXT)]);
      }
      
      private static function getActor() : IActorModel
      {
         return InjectionManager.manager().getInstance(IActorModel);
      }
      
      public static function reportErrorOnVideo(param1:String) : void
      {
         VideoAmfService.reportErrorOnVideo(param1);
      }
      
      public static function getPagedMspTvExternalVideos(param1:int, param2:int, param3:Function) : void
      {
         var doneCallback:Function = null;
         var pageindex:int = param1;
         var pagesize:int = param2;
         var resultCallback:Function = param3;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.items.length == pagesize;
            var _loc3_:Array = new Array();
            var _loc4_:int = 0;
            while(_loc4_ < param1.items.length)
            {
               _loc3_[_loc4_] = param1.items[_loc4_];
               _loc4_++;
            }
            var _loc5_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageindex);
            resultCallback(_loc5_);
         };
         VideoAmfService.getPagedMspTvExternalVideos(pageindex,pagesize,doneCallback);
      }
      
      public static function addVideoToMspTv(param1:int, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:Function) : void
      {
         var doneCallback:Function = null;
         var externalVideoId:int = param1;
         var adminUserName:String = param2;
         var adminPassword:String = param3;
         var add:Boolean = param4;
         var isGlobally:Boolean = param5;
         var resultCallback:Function = param6;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as int);
            }
         };
         VideoAmfService.addVideoToMspTv(externalVideoId,adminUserName,adminPassword,add,isGlobally,doneCallback);
      }
      
      public static function getPagedBlockedExternalVideos(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var pagerParams:Object = param1;
         var pageindex:int = param2;
         var pagesize:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:Boolean = param1.items.length == pagesize;
            var _loc3_:Array = new Array();
            var _loc4_:int = 0;
            while(_loc4_ < param1.items.length)
            {
               _loc3_[_loc4_] = param1.items[_loc4_];
               _loc4_++;
            }
            var _loc5_:PagerResultObject = new PagerResultObject(param1.totalRecords,_loc2_,_loc3_,pageindex);
            resultCallback(_loc5_);
         };
         VideoAmfService.getPagedBlockedExternalVideos(pageindex,pagesize,pagerParams.name,pagerParams.password,doneCallback);
      }
      
      public static function getExternalVideoForChatRoom(param1:int, param2:Function) : void
      {
         var doneCallback:Function = null;
         var index:int = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Object):void
         {
            if(resultCallback != null)
            {
               resultCallback(param1 as ExternalVideoData);
            }
         };
         VideoAmfService.getExternalVideoForChatRoom(index,doneCallback);
      }
   }
}

