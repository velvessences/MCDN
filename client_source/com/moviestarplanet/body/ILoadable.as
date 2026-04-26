package com.moviestarplanet.body
{
   public interface ILoadable
   {
      
      function get path() : String;
      
      function get ColorScheme() : String;
      
      function get isImage() : Boolean;
      
      function get LastUpdated() : Date;
   }
}

