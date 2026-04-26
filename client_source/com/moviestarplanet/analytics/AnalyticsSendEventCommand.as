package com.moviestarplanet.analytics
{
   import com.swrve.SwrveService;
   
   public class AnalyticsSendEventCommand
   {
      
      public function AnalyticsSendEventCommand()
      {
         super();
      }
      
      public static function execute(param1:String, param2:Object = null) : void
      {
         var _loc3_:SwrveService = SwrveService.getInstance();
         _loc3_.event(param1,param2);
      }
   }
}

