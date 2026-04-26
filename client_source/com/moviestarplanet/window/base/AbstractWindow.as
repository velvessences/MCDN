package com.moviestarplanet.window.base
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class AbstractWindow extends Sprite
   {
      
      private var _isClosable:Boolean = true;
      
      public function AbstractWindow()
      {
         super();
      }
      
      public function getWindowRectangle() : Rectangle
      {
         throw new Error("Subclass of AbstractWindow must override \'getWindowRectangle\'");
      }
      
      public function getZIndex() : int
      {
         return WindowLayers.NOTICE;
      }
      
      protected function set isClosable(param1:Boolean) : void
      {
         this._isClosable = param1;
      }
   }
}

