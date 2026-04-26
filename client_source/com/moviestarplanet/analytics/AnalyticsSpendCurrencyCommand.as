package com.moviestarplanet.analytics
{
   import com.swrve.SwrveService;
   
   public class AnalyticsSpendCurrencyCommand
   {
      
      public function AnalyticsSpendCurrencyCommand()
      {
         super();
      }
      
      public static function execute(param1:String, param2:String, param3:int) : void
      {
         var _loc4_:SwrveService = SwrveService.getInstance();
         _loc4_.purchase(param1,param2,param3);
      }
   }
}

