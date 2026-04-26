package com.moviestarplanet.controls.pager
{
   public interface PagerInterface
   {
      
      function FirstPage(param1:Function = null) : void;
      
      function PrevPage(param1:Function = null) : Boolean;
      
      function NextPage(param1:Function = null) : Boolean;
      
      function get IsAtFirstPage() : Boolean;
      
      function get IsAtLastPage() : Boolean;
      
      function get CurrentPageIndex() : int;
      
      function get PageSize() : int;
   }
}

