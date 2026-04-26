package com.moviestarplanet.Components.ViewComponent
{
   public interface IViewComponent
   {
      
      function Enter() : void;
      
      function Exit() : void;
      
      function RequestExit(param1:Function) : void;
   }
}

