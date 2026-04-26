package com.moviestarplanet.valueObjects
{
   import mx.collections.ArrayCollection;
   
   public class PagedMobileFriendList
   {
      
      public var totalRecords:int;
      
      public var pageindex:int;
      
      public var pagesize:int;
      
      public var items:ArrayCollection;
      
      public function PagedMobileFriendList()
      {
         super();
      }
   }
}

