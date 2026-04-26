package com.moviestarplanet.scrapblog.valueobjects
{
   public class PagedScrapBlogList
   {
      
      public var totalRecords:int;
      
      public var pageindex:int;
      
      public var pagesize:int;
      
      private var _list:Array;
      
      public function PagedScrapBlogList()
      {
         super();
      }
      
      public function set list(param1:*) : void
      {
         if(param1 is Array)
         {
            this._list = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._list = (param1 as Object)["toArray"]();
         }
      }
      
      public function get list() : Array
      {
         return this._list;
      }
   }
}

