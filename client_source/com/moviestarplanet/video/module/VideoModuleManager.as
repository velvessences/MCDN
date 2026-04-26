package com.moviestarplanet.video.module
{
   import com.moviestarplanet.Module.AbstractModuleManager;
   import com.moviestarplanet.Module.ModuleInterface;
   import com.moviestarplanet.access.perform.AccessPerformer;
   import com.moviestarplanet.access.restriction.AccessRestrictor;
   
   public class VideoModuleManager extends AbstractModuleManager
   {
      
      private static var instance:VideoModuleManager;
      
      private var accessRestrictor:AccessRestrictor;
      
      private var accessPerformer:AccessPerformer;
      
      public function VideoModuleManager()
      {
         super();
         this.accessRestrictor = new AccessRestrictor();
         this.accessPerformer = new AccessPerformer();
      }
      
      public static function getInstance() : VideoModuleManager
      {
         if(instance == null)
         {
            instance = new VideoModuleManager();
         }
         return instance;
      }
      
      override protected function getLoadingThemeColor() : uint
      {
         return 0;
      }
      
      override protected function get moduleName() : String
      {
         return "VideoModule";
      }
      
      private function supplyVideoModule(param1:Function) : void
      {
         var module:ModuleInterface;
         var moduleComplete:Function;
         var callback:Function = param1;
         if(false == this.accessRestrictor.youtubeRestrictions())
         {
            this.accessPerformer.youtubePerform();
            return;
         }
         module = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               callback(IVideoModule(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IVideoModule(module));
         }
      }
      
      public function openYouTubeBrowser(param1:String) : void
      {
         var moduleReturned:Function = null;
         var tabToShow:String = param1;
         moduleReturned = function(param1:IVideoModule):void
         {
            param1.openYouTubeBrowser(tabToShow);
         };
         this.supplyVideoModule(moduleReturned);
      }
      
      public function playYouTubeVideo(param1:int) : void
      {
         var moduleReturned:Function = null;
         var externalVideoId:int = param1;
         moduleReturned = function(param1:IVideoModule):void
         {
            param1.playYouTubeVideo(externalVideoId);
         };
         this.supplyVideoModule(moduleReturned);
      }
      
      public function playYouTubeFeedVideo(param1:String, param2:String, param3:Date, param4:int) : void
      {
         var moduleReturned:Function = null;
         var externalRef:String = param1;
         var title:String = param2;
         var datePublished:Date = param3;
         var categoryId:int = param4;
         moduleReturned = function(param1:IVideoModule):void
         {
            param1.playYouTubeFeedVideo(externalRef,title,datePublished,categoryId);
         };
         this.supplyVideoModule(moduleReturned);
      }
      
      public function playYouTubeList(param1:int, param2:int = 0) : void
      {
         var moduleReturned:Function = null;
         var playlistId:int = param1;
         var externalVideoIdToStart:int = param2;
         moduleReturned = function(param1:IVideoModule):void
         {
            param1.playYouTubeList(playlistId,externalVideoIdToStart);
         };
         this.supplyVideoModule(moduleReturned);
      }
      
      public function playYouTubeCategoryList(param1:int) : void
      {
         var moduleReturned:Function = null;
         var categoryId:int = param1;
         moduleReturned = function(param1:IVideoModule):void
         {
            param1.playYouTubeCategoryList(categoryId);
         };
         this.supplyVideoModule(moduleReturned);
      }
      
      public function playYouTubeMspTvList() : void
      {
         var moduleReturned:Function = null;
         moduleReturned = function(param1:IVideoModule):void
         {
            param1.playYouTubeMspTvList();
         };
         this.supplyVideoModule(moduleReturned);
      }
      
      public function playYouTubeTopList() : void
      {
         var moduleReturned:Function = null;
         moduleReturned = function(param1:IVideoModule):void
         {
            param1.playYouTubeTopList();
         };
         this.supplyVideoModule(moduleReturned);
      }
      
      public function showBlockedVideos() : void
      {
         var moduleReturned:Function = null;
         moduleReturned = function(param1:IVideoModule):void
         {
            param1.showBlockedVideos();
         };
         this.supplyVideoModule(moduleReturned);
      }
   }
}

