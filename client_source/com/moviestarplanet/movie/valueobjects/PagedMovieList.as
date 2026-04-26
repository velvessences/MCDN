package com.moviestarplanet.movie.valueobjects
{
   public class PagedMovieList
   {
      
      public var totalRecords:int;
      
      public var pageindex:int;
      
      public var pagesize:int;
      
      private var _list:Array;
      
      public function PagedMovieList()
      {
         super();
      }
      
      public function set list(param1:*) : void
      {
         if(this._list != param1)
         {
            if(param1 == null)
            {
               this._list = null;
            }
            else if(param1 is Array)
            {
               this._list = param1;
            }
            else
            {
               if(!(param1 as Object).hasOwnProperty("toArray"))
               {
                  throw new Error("value of list must be a collection");
               }
               this._list = (param1 as Object)["toArray"]();
            }
         }
      }
      
      public function get list() : Array
      {
         return this._list;
      }
   }
}

