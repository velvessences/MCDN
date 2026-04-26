package com.moviestarplanet.Windows
{
   import com.moviestarplanet.display.IWindowScaler;
   import flash.display.DisplayObject;
   
   public class WindowScalerWeb implements IWindowScaler
   {
      
      public function WindowScalerWeb()
      {
         super();
      }
      
      public function scale(param1:DisplayObject, param2:Number = 10, param3:Boolean = false, param4:Number = 90) : void
      {
         param1.x = 440 - param1.width / 2;
      }
   }
}

