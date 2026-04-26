package com.moviestarplanet.utils.numbers
{
   public class NumberFormatter
   {
      
      public static var country:String;
      
      public function NumberFormatter()
      {
         super();
      }
      
      public static function formatNumber(param1:Number, param2:String, param3:String = null, param4:String = null, param5:Boolean = false) : String
      {
         var _loc6_:String = "";
         return NumberFormatterWeb.formatNumberInner(param1,param2,param3,param4,param5);
      }
      
      public static function reset(param1:String) : void
      {
         NumberFormatterWeb.reset(param1);
      }
   }
}

