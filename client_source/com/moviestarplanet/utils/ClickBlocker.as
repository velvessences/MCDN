package com.moviestarplanet.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.Quad;
   
   public class ClickBlocker
   {
      
      private var blocker:Sprite;
      
      private var blockerVisibilityValue:Boolean = true;
      
      public function ClickBlocker()
      {
         super();
      }
      
      public static function createClickBlocker(param1:Rectangle, param2:int = 0, param3:int = 0, param4:Number = 0) : Sprite
      {
         var _loc5_:Sprite = new Sprite();
         var _loc6_:Shape = new Shape();
         _loc6_.graphics.beginFill(0);
         _loc6_.graphics.drawRect(param1.x,param1.y,param1.width,param1.height);
         _loc6_.graphics.endFill();
         _loc5_.addChild(_loc6_);
         _loc5_.alpha = param4;
         _loc5_.x = param2;
         _loc5_.y = param3;
         return _loc5_;
      }
      
      public static function createClickBlockerStarling(param1:int, param2:int) : Quad
      {
         var _loc3_:Quad = new Quad(param1,param2);
         _loc3_.alpha = 0;
         return _loc3_;
      }
      
      public function setVisibility(param1:Boolean) : void
      {
         this.blockerVisibilityValue = param1;
         if(this.blocker != null)
         {
            this.blocker.visible = this.blockerVisibilityValue;
         }
      }
      
      public function activateClickBlocker(param1:DisplayObjectContainer) : void
      {
         param1.addEventListener(Event.ENTER_FRAME,this.doActivateBlocker);
      }
      
      private function doActivateBlocker(param1:Event) : void
      {
         var _loc2_:DisplayObjectContainer = param1.target as DisplayObjectContainer;
         _loc2_.removeEventListener(Event.ENTER_FRAME,this.doActivateBlocker);
         var _loc3_:Point = this.findAbsoluteScale(_loc2_);
         var _loc4_:Point = this.findAbsolutePosition(_loc2_);
         var _loc5_:Rectangle = new Rectangle(0,0,_loc2_.stage.stageWidth / _loc3_.x,_loc2_.stage.stageHeight / _loc3_.y);
         this.blocker = ClickBlocker.createClickBlocker(_loc5_,-_loc4_.x,-_loc4_.y,0.5);
         this.blocker.visible = this.blockerVisibilityValue;
         _loc2_.addChildAt(this.blocker,_loc2_.numChildren - 1);
      }
      
      private function findAbsolutePosition(param1:DisplayObjectContainer) : Point
      {
         var _loc2_:DisplayObject = param1;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         while(!(_loc2_ is Stage))
         {
            if(_loc2_ == null)
            {
               break;
            }
            _loc3_ += _loc2_.x / _loc2_.scaleX;
            _loc4_ += _loc2_.y / _loc2_.scaleY;
            _loc2_ = _loc2_.parent;
         }
         return new Point(_loc3_,_loc4_);
      }
      
      private function findAbsoluteScale(param1:DisplayObject) : Point
      {
         var _loc2_:DisplayObject = param1;
         var _loc3_:Number = 1;
         var _loc4_:Number = 1;
         while(!(_loc2_ is Stage))
         {
            if(_loc2_ == null)
            {
               break;
            }
            _loc3_ *= _loc2_.scaleX;
            _loc4_ *= _loc2_.scaleY;
            _loc2_ = _loc2_.parent;
         }
         return new Point(_loc3_,_loc4_);
      }
      
      public function removeClickBlocker() : void
      {
         if(this.blocker)
         {
            this.blocker.parent.removeChild(this.blocker);
            this.blocker = null;
         }
      }
   }
}

