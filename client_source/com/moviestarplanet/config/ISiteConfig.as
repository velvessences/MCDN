package com.moviestarplanet.config
{
   public interface ISiteConfig
   {
      
      function get brandEnum() : int;
      
      function get brandName() : String;
      
      function get country() : String;
      
      function get language() : String;
      
      function isRestricted() : Boolean;
      
      function ageCutoff() : int;
   }
}

