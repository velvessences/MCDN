package com.moviestarplanet.controls.pager
{
   public interface PagerBufferedInterface extends PagerInterface
   {
      
      function ClearBuffer() : void;
      
      function get TotalRecords() : int;
   }
}

