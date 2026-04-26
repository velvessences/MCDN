package com.moviestarplanet.managers
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.ui.MouseCursorData;
   
   public class MSP_CursorManager
   {
      
      private static var BUSY_CURSOR:Class = MSP_CursorManager_BUSY_CURSOR;
      
      public function MSP_CursorManager()
      {
         super();
      }
      
      public static function setMoveCursor() : void
      {
         Mouse.cursor = MouseCursor.HAND;
      }
      
      public static function setNormalCursor() : void
      {
         Mouse.cursor = MouseCursor.AUTO;
      }
      
      public static function setBusy() : void
      {
         var _loc9_:Bitmap = null;
         var _loc1_:MouseCursorData = new MouseCursorData();
         _loc1_.hotSpot = new Point(10,10);
         var _loc2_:Bitmap = new BUSY_CURSOR();
         var _loc3_:int = int(_loc2_.height);
         var _loc4_:Rectangle = new Rectangle(0,0,_loc3_,_loc3_);
         var _loc5_:Point = new Point();
         var _loc6_:int = int(Math.floor(_loc2_.width / _loc2_.height));
         var _loc7_:Vector.<BitmapData> = new Vector.<BitmapData>(_loc6_,true);
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_)
         {
            _loc9_ = new Bitmap(new BitmapData(_loc3_,_loc3_));
            _loc9_.bitmapData.copyPixels(_loc2_.bitmapData,_loc4_,_loc5_);
            _loc7_[_loc8_] = _loc9_.bitmapData;
            _loc4_.x = _loc3_ * _loc8_;
            _loc8_++;
         }
         _loc1_.data = _loc7_;
         _loc1_.frameRate = 24;
         Mouse.registerCursor("myAnimatedCursor",_loc1_);
         Mouse.cursor = "myAnimatedCursor";
      }
   }
}

