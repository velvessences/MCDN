package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.media.youtube.IYouTubePlayerFactory;
   import com.moviestarplanet.media.youtube.YouTubeIFrameAPIPlayerFactory;
   
   public class SetupYouTubePlayerCommand
   {
      
      public function SetupYouTubePlayerCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         InjectionManager.mapper().map(IYouTubePlayerFactory).toSingleton(YouTubeIFrameAPIPlayerFactory);
      }
   }
}

