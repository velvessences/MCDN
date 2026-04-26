package com.moviestarplanet.color.colorpicker
{
   public interface ColorPickerModelInterface
   {
      
      function getNumberOfColors() : int;
      
      function getColor(param1:int) : uint;
      
      function indexClicked(param1:int) : void;
      
      function indexConsidered(param1:int) : void;
   }
}

