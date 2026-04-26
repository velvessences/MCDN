package com.moviestarplanet.config
{
   public interface ISiteRestriction
   {
      
      function isUnderage() : Boolean;
      
      function isServerRestricted() : Boolean;
   }
}

