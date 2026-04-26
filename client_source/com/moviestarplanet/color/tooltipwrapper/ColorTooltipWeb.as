package com.moviestarplanet.color.tooltipwrapper
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import mx.core.IFlexDisplayObject;
   import mx.core.UIComponent;
   
   public class ColorTooltipWeb implements IColorTooltip
   {
      
      public function ColorTooltipWeb()
      {
         super();
      }
      
      public function isFlex(param1:DisplayObjectContainer) : Boolean
      {
         return param1 is IFlexDisplayObject;
      }
      
      public function createWrapperFor(param1:DisplayObjectContainer) : DisplayObject
      {
         var _loc2_:UIComponent = new UIComponent();
         _loc2_.addChild(param1);
         return _loc2_;
      }
   }
}

