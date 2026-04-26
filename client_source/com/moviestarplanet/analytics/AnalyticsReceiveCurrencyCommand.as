package com.moviestarplanet.analytics
{
   import com.moviestarplanet.analytics.constants.AnalyticsConstants;
   import com.swrve.SwrveService;
   
   public class AnalyticsReceiveCurrencyCommand
   {
      
      public function AnalyticsReceiveCurrencyCommand()
      {
         super();
      }
      
      public static function execute(param1:String, param2:int) : void
      {
         var _loc3_:Object = new Object();
         _loc3_.source = param1;
         _loc3_.amount = param2;
         var _loc4_:SwrveService = SwrveService.getInstance();
         _loc4_.receiveCurrency(param2,AnalyticsConstants.STARCOINS);
         _loc4_.event(AnalyticsConstants.ECONOMY_COINS_SOURCE,_loc3_);
         _loc4_.event(param1,_loc3_);
      }
   }
}

