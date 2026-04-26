package com.moviestarplanet.color.colortooltip
{
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class ColorTooltipModel extends EventDispatcher implements ColorTooltipModelInterface
   {
      
      private var initialColors:Array;
      
      private var defaultColors:Array;
      
      private var currentColors:Array;
      
      private var result:Function;
      
      private var update:Function;
      
      private var pickerQuadrant:int;
      
      private var toolTipOffset:Point;
      
      public function ColorTooltipModel(param1:Array, param2:Array, param3:Function, param4:Function, param5:int, param6:Point)
      {
         super();
         this.initialColors = param1;
         this.defaultColors = param2;
         this.currentColors = param1.concat();
         this.update = param4;
         this.result = param3;
         this.pickerQuadrant = param5;
         this.toolTipOffset = param6;
      }
      
      public function getPickerQuadrant() : int
      {
         return this.pickerQuadrant;
      }
      
      public function getNumberOfColors() : int
      {
         return this.defaultColors.length;
      }
      
      public function getCurrentColor(param1:int) : uint
      {
         return this.currentColors[param1];
      }
      
      public function getDefaultColor(param1:int) : uint
      {
         return this.defaultColors[param1];
      }
      
      public function getToolTipOffset() : Point
      {
         return this.toolTipOffset;
      }
      
      public function updateColor(param1:int, param2:int) : void
      {
         if(param2 < 0)
         {
            param2 = int(this.initialColors[param1]);
         }
         this.changeColor(param1,param2);
         this.invokeColor(this.update,param1,param2);
      }
      
      public function resultColor(param1:int, param2:int) : void
      {
         this.initialColors[param1] = param2;
         this.changeColor(param1,param2);
         this.invokeColor(this.result,param1,param2);
      }
      
      private function invokeColor(param1:Function, param2:int, param3:uint) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.length == 2)
         {
            param1(param2,param3);
         }
         else if(param1.length == 0)
         {
            param1();
         }
      }
      
      private function changeColor(param1:int, param2:int) : void
      {
         this.currentColors[param1] = param2;
         this.dispatchColorchange(param1,param2);
      }
      
      public function resetColor(param1:int) : void
      {
         this.currentColors[param1] = this.defaultColors[param1];
         this.dispatchColorchange(param1,this.currentColors[param1]);
         this.invokeColor(this.update,param1,this.defaultColors[param1]);
         this.invokeColor(this.result,param1,this.defaultColors[param1]);
      }
      
      private function dispatchColorchange(param1:int, param2:int) : void
      {
         dispatchEvent(new ColorTooltipModelEvent(ColorTooltipModelEvent.COLOR_CHANGED,{
            "index":param1,
            "color":this.currentColors[param1]
         }));
      }
   }
}

