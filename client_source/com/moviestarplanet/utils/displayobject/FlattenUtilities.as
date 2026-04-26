package com.moviestarplanet.utils.displayobject
{
   import avmplus.getQualifiedClassName;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class FlattenUtilities
   {
      
      public function FlattenUtilities()
      {
         super();
         throw new Error("FlattenUtilities is a static class and should not be instantiated");
      }
      
      public static function flattenSprite(param1:Sprite, param2:Number = -1, param3:Boolean = true, param4:Boolean = false, param5:Boolean = true, param6:Vector.<BitmapData> = null) : Boolean
      {
         var rect:Rectangle;
         var bitmap:Bitmap = null;
         var resSprite:Sprite = null;
         var minScale:Number = NaN;
         var scrollRect:Rectangle = null;
         var sprite:Sprite = param1;
         var scale:Number = param2;
         var smoothing:Boolean = param3;
         var trim:Boolean = param4;
         var enableAlpha:Boolean = param5;
         var bitmapDatas:Vector.<BitmapData> = param6;
         if(sprite.numChildren == 1 && sprite.getChildAt(0) is Sprite && (sprite.getChildAt(0) as Sprite).numChildren == 1 && (sprite.getChildAt(0) as Sprite).getChildAt(0) is Bitmap)
         {
            return true;
         }
         rect = sprite.getBounds(sprite);
         if(Boolean(isNaN(scale)) || !isFinite(scale))
         {
            trace("!!! Invalid scale being used for sprite : " + sprite);
            return false;
         }
         try
         {
            if(scale == -1)
            {
               scale = RootScaleUtil.getAggregateScale(sprite);
            }
            minScale = Number(Math.max(1,scale));
            if(rect.width * minScale > DisplayConverter.WIDTH_LIMIT || rect.height * minScale > DisplayConverter.HEIGHT_LIMIT)
            {
               scrollRect = sprite.scrollRect != null ? sprite.scrollRect : rect;
               resSprite = DisplayConverter.CreateTiledSprite(sprite,scrollRect,minScale,smoothing,trim,enableAlpha,bitmapDatas);
               sprite.removeChildren();
            }
            else
            {
               if(scale > 1)
               {
                  bitmap = DisplayConverter.spriteToScaledBitmap(sprite,rect,scale,smoothing,trim,enableAlpha,bitmapDatas);
               }
               else
               {
                  scale = 1;
                  bitmap = DisplayConverter.spriteToBitmap(sprite,rect,smoothing,trim,enableAlpha,bitmapDatas);
               }
               sprite.removeChildren();
               resSprite = new Sprite();
               resSprite.addChild(bitmap);
               resSprite.x = rect.x;
               resSprite.y = rect.y;
            }
            resSprite.scaleX = 1 / scale;
            resSprite.scaleY = 1 / scale;
            sprite.addChild(resSprite);
            sprite.mask = null;
         }
         catch(err:Error)
         {
            trace("FlattenSprite has an InvalidBitmapData... name: " + sprite.name + ", class: " + getQualifiedClassName(sprite) + ", error: " + err.message);
            return false;
         }
         return true;
      }
      
      public static function simpleFlatten(param1:DisplayObject, param2:Boolean = false, param3:Boolean = false) : Bitmap
      {
         var _loc4_:Rectangle = param1.getBounds(param1);
         var _loc5_:BitmapData = new BitmapData(_loc4_.width,_loc4_.height,param3,16777215);
         var _loc6_:Matrix = new Matrix();
         _loc6_.tx = -_loc4_.x;
         _loc6_.ty = -_loc4_.y;
         _loc5_.draw(param1,_loc6_,null,null,null,param2);
         return new Bitmap(_loc5_);
      }
   }
}

