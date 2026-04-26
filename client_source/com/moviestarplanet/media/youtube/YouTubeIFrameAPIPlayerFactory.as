package com.moviestarplanet.media.youtube
{
   public class YouTubeIFrameAPIPlayerFactory implements IYouTubePlayerFactory
   {
      
      public function YouTubeIFrameAPIPlayerFactory()
      {
         super();
      }
      
      public function getPlayer() : IAPIPlayerSprite
      {
         return new YouTubeIFrameAPIPlayer();
      }
   }
}

