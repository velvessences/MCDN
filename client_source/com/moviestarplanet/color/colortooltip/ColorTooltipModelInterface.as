package com.moviestarplanet.color.colortooltip
{
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public interface ColorTooltipModelInterface extends IEventDispatcher
   {
      
      function getPickerQuadrant() : int;
      
      function getNumberOfColors() : int;
      
      function getCurrentColor(param1:int) : uint;
      
      function getDefaultColor(param1:int) : uint;
      
      function getToolTipOffset() : Point;
      
      function updateColor(param1:int, param2:int) : void;
      
      function resultColor(param1:int, param2:int) : void;
      
      function resetColor(param1:int) : void;
   }
}

