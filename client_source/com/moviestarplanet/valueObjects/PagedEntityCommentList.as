package com.moviestarplanet.valueObjects
{
   public class PagedEntityCommentList
   {
      
      public var totalRecords:int;
      
      public var pageindex:int;
      
      public var pagesize:int;
      
      public var _items:Array;
      
      public function PagedEntityCommentList()
      {
         super();
      }
      
      public function set items(param1:*) : void
      {
         if(param1 is Array)
         {
            this._items = param1;
         }
         else if((param1 as Object).hasOwnProperty("toArray"))
         {
            this._items = (param1 as Object)["toArray"]();
         }
      }
      
      public function get items() : Array
      {
         return this._items;
      }
   }
}

