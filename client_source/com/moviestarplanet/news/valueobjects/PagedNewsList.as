package com.moviestarplanet.news.valueobjects
{
   import mx.collections.ArrayCollection;
   
   public class PagedNewsList
   {
      
      public var totalRecords:int;
      
      public var pageindex:int;
      
      public var pagesize:int;
      
      public var items:ArrayCollection;
      
      public function PagedNewsList()
      {
         super();
      }
   }
}

