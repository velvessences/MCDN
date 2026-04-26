package com.moviestarplanet.media.valueobjects
{
   public class Music extends Media
   {
      
      public var MusicId:int;
      
      public var Url:String;
      
      public var MusicCategoryId:int;
      
      public var MusicCategory:com.moviestarplanet.media.valueobjects.MusicCategory;
      
      public function Music()
      {
         super();
      }
   }
}

