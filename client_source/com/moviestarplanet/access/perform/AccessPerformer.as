package com.moviestarplanet.access.perform
{
   public class AccessPerformer
   {
      
      public function AccessPerformer()
      {
         super();
      }
      
      public function chatPerform() : void
      {
         new ChatPerform().takeAction();
      }
      
      public function youtubePerform() : void
      {
         new YoutubePerform().takeAction();
      }
   }
}

