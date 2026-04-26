package com.moviestarplanet.utils.displayobject
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DisplayConverter
   {
      
      public static const WIDTH_LIMIT:Number = 2880;
      
      public static const HEIGHT_LIMIT:Number = 2880;
      
      public static const PIXEL_LIMIT:Number = WIDTH_LIMIT * HEIGHT_LIMIT;
      
      private static const TILE_OVERLAP:Number = 4;
      
      private static const ZERO_POINT:Point = new Point();
      
      private static var MATRIX:Matrix = new Matrix();
      
      public function DisplayConverter()
      {
         super();
         trace("DisplayConverter is a static class and should not be instantiated");
      }
      
      public static function bitmapToSprite(param1:Bitmap, param2:Boolean = false) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         _loc3_.addChild(new Bitmap(param1.bitmapData.clone(),"auto",param2));
         return _loc3_;
      }
      
      public static function getVisibleBounds(param1:DisplayObject) : Rectangle
      {
         MATRIX.identity();
         var _loc2_:Rectangle = param1.getBounds(param1);
         MATRIX.tx = -_loc2_.x;
         MATRIX.ty = -_loc2_.y;
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc3_.draw(param1,MATRIX);
         var _loc4_:Rectangle = _loc3_.getColorBoundsRect(4294967295,0,false);
         _loc3_.dispose();
         _loc4_.x += _loc2_.x;
         _loc4_.y += _loc2_.y;
         return _loc4_;
      }
      
      public static function spriteToBitmap(param1:DisplayObject, param2:Rectangle, param3:Boolean = false, param4:Boolean = false, param5:Boolean = true, param6:Vector.<BitmapData> = null) : Bitmap
      {
         var _loc7_:Bitmap = null;
         var _loc9_:Rectangle = null;
         var _loc10_:BitmapData = null;
         MATRIX.identity();
         MATRIX.tx = -param2.x;
         MATRIX.ty = -param2.y;
         var _loc8_:BitmapData = new BitmapData(param2.width,param2.height,param5,0);
         _loc8_.draw(param1,MATRIX);
         if(param4)
         {
            _loc9_ = _loc8_.getColorBoundsRect(4294967295,0,false);
            _loc10_ = new BitmapData(_loc9_.width,_loc9_.height,true,0);
            _loc10_.copyPixels(_loc8_,_loc9_,ZERO_POINT);
            param2.x += _loc9_.x;
            param2.y += _loc9_.y;
            _loc7_ = new Bitmap(_loc10_,"auto",param3);
            _loc8_.dispose();
            if(param6 != null)
            {
               param6.push(_loc10_);
            }
         }
         else
         {
            _loc7_ = new Bitmap(_loc8_,"auto",param3);
            if(param6 != null)
            {
               param6.push(_loc8_);
            }
         }
         return _loc7_;
      }
      
      public static function spriteToScaledBitmap(param1:Sprite, param2:Rectangle, param3:Number, param4:Boolean = false, param5:Boolean = false, param6:Boolean = true, param7:Vector.<BitmapData> = null) : Bitmap
      {
         var _loc9_:Rectangle = null;
         var _loc10_:BitmapData = null;
         MATRIX.identity();
         MATRIX.tx = -param2.x * param3;
         MATRIX.ty = -param2.y * param3;
         MATRIX.a = param3;
         MATRIX.d = param3;
         var _loc8_:BitmapData = new BitmapData(param2.width * param3,param2.height * param3,param6,16777215);
         _loc8_.draw(param1,MATRIX);
         if(param5)
         {
            _loc9_ = _loc8_.getColorBoundsRect(4294967295,0,false);
            _loc10_ = new BitmapData(_loc9_.width,_loc9_.height,true,0);
            _loc10_.copyPixels(_loc8_,_loc9_,ZERO_POINT);
            param2.x += _loc9_.x / param3;
            param2.y += _loc9_.y / param3;
            _loc8_.dispose();
            if(param7 != null)
            {
               param7.push(_loc10_);
            }
            return new Bitmap(_loc10_,"auto",param4);
         }
         if(param7 != null)
         {
            param7.push(_loc8_);
         }
         return new Bitmap(_loc8_,"auto",param4);
      }
      
      public static function CreateTiledSprite(param1:Sprite, param2:Rectangle, param3:Number, param4:Boolean = false, param5:Boolean = false, param6:Boolean = true, param7:Vector.<BitmapData> = null) : Sprite
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Bitmap = null;
         var _loc19_:BitmapData = null;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc10_:Number = param2.width * param3 * (param2.height * param3);
         var _loc11_:Sprite = new Sprite();
         var _loc12_:Number = param2.width * param3;
         var _loc13_:Number = param2.height * param3;
         var _loc14_:Number = Number(Math.ceil(_loc12_ / WIDTH_LIMIT));
         var _loc15_:Number = Number(Math.ceil(_loc13_ / HEIGHT_LIMIT));
         var _loc22_:Rectangle = new Rectangle(0,0,WIDTH_LIMIT,HEIGHT_LIMIT);
         MATRIX.identity();
         MATRIX.tx = -param2.x * param3;
         MATRIX.ty = -param2.y * param3;
         MATRIX.a = param3;
         MATRIX.d = param3;
         _loc8_ = 0;
         while(_loc8_ < _loc15_)
         {
            _loc17_ = _loc8_ * HEIGHT_LIMIT - _loc8_ * TILE_OVERLAP;
            _loc24_ = _loc8_ * HEIGHT_LIMIT - _loc8_ * TILE_OVERLAP;
            _loc21_ = _loc24_ + HEIGHT_LIMIT < _loc13_ ? HEIGHT_LIMIT : _loc13_ - _loc24_;
            _loc9_ = 0;
            while(_loc9_ < _loc14_)
            {
               _loc16_ = _loc9_ * WIDTH_LIMIT - _loc9_ * TILE_OVERLAP;
               _loc23_ = _loc9_ * WIDTH_LIMIT - _loc9_ * TILE_OVERLAP;
               _loc20_ = _loc23_ + WIDTH_LIMIT < _loc12_ ? WIDTH_LIMIT : _loc12_ - _loc23_;
               _loc19_ = new BitmapData(_loc20_,_loc21_,param6,0);
               MATRIX.tx = -_loc23_;
               MATRIX.ty = -_loc24_;
               MATRIX.a = param3;
               MATRIX.d = param3;
               _loc22_.width = _loc20_;
               _loc22_.height = _loc21_;
               _loc19_.draw(param1,MATRIX,null,null,_loc22_,param4);
               _loc18_ = new Bitmap(_loc19_,"auto",param4);
               _loc18_.x = _loc16_;
               _loc18_.y = _loc17_;
               _loc11_.addChild(_loc18_);
               if(param7 != null)
               {
                  param7.push(_loc19_);
               }
               _loc9_++;
            }
            _loc8_++;
         }
         return _loc11_;
      }
      
      public static function spriteToXYScaledBitmap(param1:Sprite, param2:Rectangle, param3:Number, param4:Number, param5:Boolean = false) : Bitmap
      {
         var _loc6_:BitmapData = new BitmapData(param2.width * param3,param2.height * param4,true,16777215);
         MATRIX.identity();
         MATRIX.tx = -param2.x * param3;
         MATRIX.ty = -param2.y * param4;
         MATRIX.a = param3;
         MATRIX.d = param4;
         _loc6_.draw(param1,MATRIX);
         return new Bitmap(_loc6_,"auto",param5);
      }
   }
}

