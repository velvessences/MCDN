package com.moviestarplanet.access.restriction
{
   public class AccessRestrictor
   {
      
      public function AccessRestrictor()
      {
         super();
      }
      
      public function chatRestrictions() : Boolean
      {
         return new ChatRestriction().checkRestriction();
      }
      
      public function youtubeRestrictions() : Boolean
      {
         return new YoutubeRestriction().checkRestriction();
      }
   }
}

