package com.moviestarplanet.math
{
   public class NumberUtils
   {
      
      public function NumberUtils()
      {
         super();
      }
      
      public static function random(param1:Number, param2:Number = 0) : Number
      {
         var _loc5_:Number = NaN;
         if(param1 > param2)
         {
            _loc5_ = param1;
            param1 = param2;
            param2 = _loc5_;
         }
         var _loc3_:Number = param2 - param1 + 1;
         var _loc4_:Number = Math.random() * _loc3_;
         _loc4_ = _loc4_ + param1;
         return Math.floor(_loc4_);
      }
      
      public static function nearestPow2(param1:Number) : int
      {
         var _loc2_:Number = Number(Math.log(param1));
         var _loc3_:Number = Number(Math.log(2));
         var _loc4_:Number = _loc2_ / _loc3_;
         return Number(Math.pow(2,Math.round(_loc4_)));
      }
   }
}

