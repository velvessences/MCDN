package com.moviestarplanet.utils.displayobject
{
   import com.moviestarplanet.utils.ComponentUtilities;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DisplayObjectUtil
   {
      
      private static const MAX_WIDTH:int = 1024;
      
      private static const MAX_HEIGHT:int = 1024;
      
      private static var MATRIX_HELPER:Matrix = new Matrix();
      
      private static var BMD_HELPER:BitmapData = new BitmapData(MAX_WIDTH,MAX_HEIGHT,true,0);
      
      private static var BMD_CLEAR_HELPER:BitmapData = new BitmapData(MAX_WIDTH,MAX_HEIGHT,true,0);
      
      private static var RECT_HELPER:Rectangle = new Rectangle(0,0,MAX_WIDTH,MAX_HEIGHT);
      
      private static const POINT_HELPER:Point = new Point();
      
      public function DisplayObjectUtil()
      {
         super();
      }
      
      public static function getVisibleBounds(param1:DisplayObject) : Rectangle
      {
         var _loc2_:Matrix = new Matrix();
         var _loc3_:Rectangle = param1.getBounds(param1);
         _loc2_.tx = -_loc3_.x;
         _loc2_.ty = -_loc3_.y;
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc4_.draw(param1,_loc2_);
         var _loc5_:Rectangle = _loc4_.getColorBoundsRect(4294967295,0,false);
         _loc4_.dispose();
         _loc5_.x += _loc3_.x;
         _loc5_.y += _loc3_.y;
         return _loc5_;
      }
      
      public static function getVisibleBoundsOptimized(param1:DisplayObject) : Rectangle
      {
         BMD_HELPER.copyPixels(BMD_CLEAR_HELPER,RECT_HELPER,POINT_HELPER);
         MATRIX_HELPER.identity();
         var _loc2_:Rectangle = param1.getBounds(param1);
         MATRIX_HELPER.tx = -_loc2_.x;
         MATRIX_HELPER.ty = -_loc2_.y;
         BMD_HELPER.draw(param1,MATRIX_HELPER);
         var _loc3_:Rectangle = BMD_HELPER.getColorBoundsRect(4294967295,0,false);
         _loc3_.x += _loc2_.x;
         _loc3_.y += _loc2_.y;
         return _loc3_;
      }
      
      public static function gotoAndStopAllMovieClips(param1:DisplayObject, param2:uint) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 != null)
         {
            _loc3_ = ComponentUtilities.findInstancesByClass(param1,MovieClip);
            _loc4_ = 0;
            _loc5_ = int(_loc3_.length);
            while(_loc4_ < _loc5_)
            {
               _loc3_[_loc4_].gotoAndStop(1);
               _loc4_++;
            }
         }
      }
      
      public static function stopAllMovieclips(param1:DisplayObject) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 != null)
         {
            _loc2_ = ComponentUtilities.findInstancesByClass(param1,MovieClip);
            _loc3_ = 0;
            _loc4_ = int(_loc2_.length);
            while(_loc3_ < _loc4_)
            {
               _loc2_[_loc3_].stop();
               _loc3_++;
            }
         }
      }
      
      public static function addStopFameScript(param1:MovieClip, param2:int) : void
      {
         var stopMc:Function = null;
         var mc:MovieClip = param1;
         var frame:int = param2;
         stopMc = function():void
         {
            mc.stop();
         };
         mc.addFrameScript(frame,stopMc);
      }
      
      public static function drawItemIntoBitmapData(param1:DisplayObject, param2:Rectangle, param3:Number = 1) : BitmapData
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:BitmapData = null;
         var _loc8_:Matrix = null;
         if(param1 is DisplayObjectContainer)
         {
            _loc4_ = (param1 as DisplayObjectContainer).getChildByName("mask");
         }
         if(_loc4_ != null)
         {
            param2 = new Rectangle(_loc4_.x,_loc4_.y,_loc4_.width,_loc4_.height);
         }
         param1.scaleX = param1.scaleY = 1;
         _loc8_ = param1.transform.matrix;
         _loc8_.tx = -param2.x;
         _loc8_.ty = -param2.y;
         _loc8_.scale(param3,param3);
         _loc5_ = (param2.width + 0.5) * param3;
         _loc6_ = (param2.height + 0.5) * param3;
         _loc7_ = new BitmapData(_loc5_,_loc6_,true,0);
         _loc7_.draw(param1,_loc8_,param1.transform.colorTransform);
         return _loc7_;
      }
      
      public static function recursiveDestroy(param1:DisplayObjectContainer) : void
      {
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:Bitmap = null;
         var _loc2_:int = int(param1.numChildren);
         if(_loc2_ == 0)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            if(_loc4_ is DisplayObjectContainer)
            {
               _loc5_ = _loc4_ as DisplayObjectContainer;
               recursiveDestroy(_loc5_);
               _loc5_.removeChildren();
            }
            if(_loc4_ is Bitmap)
            {
               _loc6_ = _loc4_ as Bitmap;
               if(_loc6_.bitmapData != null)
               {
                  _loc6_.bitmapData.dispose();
               }
            }
            if(_loc4_ is Loader)
            {
               (_loc4_ as Loader).unload();
            }
            if(_loc4_ is Shape)
            {
               (_loc4_ as Shape).graphics.clear();
            }
            _loc3_++;
         }
         _loc4_ = null;
         _loc5_ = null;
         _loc6_ = null;
      }
   }
}

