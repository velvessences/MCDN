package com.moviestarplanet.utils.color
{
   import flash.display.DisplayObject;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   
   public class ColorFilterUtilities
   {
      
      public function ColorFilterUtilities()
      {
         super();
      }
      
      public static function dim(param1:DisplayObject) : void
      {
         setColorMatrix(param1,-20,-20,-50);
      }
      
      public static function setColorMatrix(param1:DisplayObject, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         if(param1 != null)
         {
            if(param1)
            {
               param1.filters = [setBrightness(param2),setContrast(param3),setSaturation(param4)];
            }
         }
      }
      
      public static function setBrightness(param1:Number) : ColorMatrixFilter
      {
         param1 *= 255 / 250;
         var _loc2_:Array = new Array();
         _loc2_ = _loc2_.concat([1,0,0,0,param1]);
         _loc2_ = _loc2_.concat([0,1,0,0,param1]);
         _loc2_ = _loc2_.concat([0,0,1,0,param1]);
         _loc2_ = _loc2_.concat([0,0,0,1,0]);
         return new ColorMatrixFilter(_loc2_);
      }
      
      public static function setContrast(param1:Number) : ColorMatrixFilter
      {
         param1 /= 100;
         var _loc2_:Number = param1 + 1;
         var _loc3_:Number = 128 * (1 - _loc2_);
         var _loc4_:Array = new Array();
         _loc4_ = _loc4_.concat([_loc2_,0,0,0,_loc3_]);
         _loc4_ = _loc4_.concat([0,_loc2_,0,0,_loc3_]);
         _loc4_ = _loc4_.concat([0,0,_loc2_,0,_loc3_]);
         _loc4_ = _loc4_.concat([0,0,0,1,0]);
         return new ColorMatrixFilter(_loc4_);
      }
      
      public static function setSaturation(param1:Number) : ColorMatrixFilter
      {
         var _loc2_:Number = 0.212671;
         var _loc3_:Number = 0.71516;
         var _loc4_:Number = 0.072169;
         var _loc5_:Number = param1 / 100 + 1;
         var _loc6_:Number = 1 - _loc5_;
         var _loc7_:Number = _loc6_ * _loc2_;
         var _loc8_:Number = _loc6_ * _loc3_;
         var _loc9_:Number = _loc6_ * _loc4_;
         var _loc10_:Array = new Array();
         _loc10_ = _loc10_.concat([_loc7_ + _loc5_,_loc8_,_loc9_,0,0]);
         _loc10_ = _loc10_.concat([_loc7_,_loc8_ + _loc5_,_loc9_,0,0]);
         _loc10_ = _loc10_.concat([_loc7_,_loc8_,_loc9_ + _loc5_,0,0]);
         _loc10_ = _loc10_.concat([0,0,0,1,0]);
         return new ColorMatrixFilter(_loc10_);
      }
      
      public static function getTint(param1:uint, param2:Number) : ColorTransform
      {
         var _loc3_:ColorTransform = new ColorTransform();
         _loc3_.redMultiplier = _loc3_.greenMultiplier = _loc3_.blueMultiplier = 1 - param2;
         _loc3_.redOffset = Math.round(((param1 & 0xFF0000) >> 16) * param2);
         _loc3_.greenOffset = Math.round(((param1 & 0xFF00) >> 8) * param2);
         _loc3_.blueOffset = Math.round((param1 & 0xFF) * param2);
         return _loc3_;
      }
      
      public static function desaturate() : ColorMatrixFilter
      {
         var _loc1_:Number = 0.212671;
         var _loc2_:Number = 0.71516;
         var _loc3_:Number = 0.072169;
         var _loc4_:Array = [_loc1_,_loc2_,_loc3_,0,0,_loc1_,_loc2_,_loc3_,0,0,_loc1_,_loc2_,_loc3_,0,0,0,0,0,1,0];
         return new ColorMatrixFilter(_loc4_);
      }
      
      public static function desaturateDisplayObject(param1:DisplayObject) : void
      {
         var _loc2_:Array = param1.filters;
         _loc2_.push(ColorFilterUtilities.desaturate());
         param1.filters = _loc2_;
      }
   }
}

