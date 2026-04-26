package com.moviestarplanet.display
{
   import flash.display.DisplayObject;
   
   public interface IWindowScaler
   {
      
      function scale(param1:DisplayObject, param2:Number = 10, param3:Boolean = false, param4:Number = 90) : void;
   }
}

