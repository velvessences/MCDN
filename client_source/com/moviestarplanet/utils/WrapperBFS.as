package com.moviestarplanet.utils
{
   import flash.display.DisplayObject;
   
   internal class WrapperBFS
   {
      
      public var displayObject:DisplayObject;
      
      public var level:int;
      
      public function WrapperBFS(param1:DisplayObject, param2:int)
      {
         super();
         this.displayObject = param1;
         this.level = param2;
      }
   }
}

