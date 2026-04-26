package com.moviestarplanet.color.tooltipwrapper
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public interface IColorTooltip
   {
      
      function isFlex(param1:DisplayObjectContainer) : Boolean;
      
      function createWrapperFor(param1:DisplayObjectContainer) : DisplayObject;
   }
}

