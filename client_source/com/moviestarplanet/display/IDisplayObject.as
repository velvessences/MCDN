package com.moviestarplanet.display
{
   import flash.display.DisplayObjectContainer;
   
   public interface IDisplayObject
   {
      
      function get height() : Number;
      
      function set height(param1:Number) : void;
      
      function get visible() : Boolean;
      
      function set visible(param1:Boolean) : void;
      
      function get width() : Number;
      
      function set width(param1:Number) : void;
      
      function get x() : Number;
      
      function set x(param1:Number) : void;
      
      function get y() : Number;
      
      function set y(param1:Number) : void;
      
      function get scaleX() : Number;
      
      function set scaleX(param1:Number) : void;
      
      function get scaleY() : Number;
      
      function set scaleY(param1:Number) : void;
      
      function get alpha() : Number;
      
      function set alpha(param1:Number) : void;
      
      function get parent() : DisplayObjectContainer;
   }
}

