package com.moviestarplanet.scrapitems
{
   public interface IClipArtInfo
   {
      
      function get ClipArtId() : int;
      
      function get Filename() : String;
      
      function get ClipArtCategoryId() : int;
      
      function get path() : String;
      
      function get colorArray() : Array;
      
      function get Price() : int;
      
      function get DiamondsPrice() : int;
      
      function get ColorScheme() : String;
      
      function get Vip() : int;
   }
}

