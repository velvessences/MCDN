package com.moviestarplanet.color
{
   import flash.display.DisplayObject;
   
   public class ColorRequest implements ColorRequestInterface
   {
      
      private var closeRequest:Function;
      
      private var _view:DisplayObject;
      
      public function ColorRequest(param1:Function, param2:DisplayObject)
      {
         super();
         this.closeRequest = param1;
         this._view = param2;
      }
      
      public function requestClose() : void
      {
         this.closeRequest();
      }
      
      public function get view() : DisplayObject
      {
         return this._view;
      }
   }
}

