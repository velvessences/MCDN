package com.moviestarplanet.utils.tooltips.interfaces
{
   import com.moviestarplanet.utils.tooltips.ToolTipsElement;
   
   public interface ITooltipWrapper
   {
      
      function createTooltip(param1:ToolTipsElement) : void;
      
      function setPosition(param1:Number, param2:Number) : void;
      
      function hasToolTip() : Boolean;
      
      function get width() : Number;
      
      function get height() : Number;
      
      function destroy() : void;
   }
}

