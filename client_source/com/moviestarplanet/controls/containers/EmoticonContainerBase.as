package com.moviestarplanet.controls.containers
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class EmoticonContainerBase extends MovieClip
   {
      
      private static const CONTENT_PADDING:Number = 10;
      
      public var background:MovieClip;
      
      public function EmoticonContainerBase()
      {
         super();
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:DisplayObject = super.addChild(param1);
         _loc2_.x = CONTENT_PADDING;
         _loc2_.y = CONTENT_PADDING;
         this.background.width = _loc2_.width + CONTENT_PADDING * 2;
         this.background.height = _loc2_.height + CONTENT_PADDING * 2;
         return _loc2_;
      }
   }
}

