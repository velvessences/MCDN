package com.moviestarplanet.video.module
{
   import com.moviestarplanet.Module.ApplicationInjectInterface;
   import com.moviestarplanet.Module.ModuleInterface;
   
   public interface IVideoModule extends ModuleInterface, ApplicationInjectInterface
   {
      
      function openYouTubeBrowser(param1:String) : void;
      
      function playYouTubeVideo(param1:int) : void;
      
      function playYouTubeFeedVideo(param1:String, param2:String, param3:Date, param4:int) : void;
      
      function playYouTubeList(param1:int, param2:int = 0) : void;
      
      function playYouTubeCategoryList(param1:int) : void;
      
      function playYouTubeMspTvList() : void;
      
      function playYouTubeTopList() : void;
      
      function showBlockedVideos() : void;
   }
}

