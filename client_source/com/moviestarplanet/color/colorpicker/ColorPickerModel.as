package com.moviestarplanet.color.colorpicker
{
   public class ColorPickerModel implements ColorPickerModelInterface
   {
      
      private var colorScheme:Array;
      
      private var result:Function;
      
      private var update:Function;
      
      public function ColorPickerModel(param1:Array, param2:Function, param3:Function)
      {
         super();
         this.colorScheme = param1;
         this.result = param2;
         this.update = param3;
      }
      
      public function getNumberOfColors() : int
      {
         return this.colorScheme.length;
      }
      
      public function getColor(param1:int) : uint
      {
         return this.colorScheme[param1];
      }
      
      public function indexClicked(param1:int) : void
      {
         this.result(this.colorScheme[param1]);
      }
      
      public function indexConsidered(param1:int) : void
      {
         if(param1 < 0)
         {
            this.update(-1);
         }
         else
         {
            this.update(this.colorScheme[param1]);
         }
      }
   }
}

