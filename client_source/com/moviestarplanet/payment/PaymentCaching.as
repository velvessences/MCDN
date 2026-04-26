package com.moviestarplanet.payment
{
   import com.moviestarplanet.payment.services.PaymentAmfService;
   import com.moviestarplanet.payment.valueobject.CountryPrices;
   import flash.utils.getQualifiedClassName;
   
   public class PaymentCaching
   {
      
      private static var prices:CountryPrices;
      
      private static var waitingCalls:Vector.<Function> = new Vector.<Function>();
      
      public function PaymentCaching()
      {
         super();
         throw new Error("Do not instantiate caching class " + getQualifiedClassName(this));
      }
      
      public static function getPrices(param1:Function) : void
      {
         var iPricesResult:Function;
         var result:Function = param1;
         var notify:Function = function():void
         {
            var _loc1_:int = 0;
            while(_loc1_ < waitingCalls.length)
            {
               waitingCalls[_loc1_].apply(null,[prices]);
               _loc1_++;
            }
            waitingCalls = new Vector.<Function>();
         };
         if(prices == null)
         {
            waitingCalls.push(result);
            if(waitingCalls.length <= 1)
            {
               iPricesResult = function(param1:Object):void
               {
                  prices = new CountryPrices();
                  prices.parseObject(param1);
                  notify();
               };
               new PaymentAmfService().GetBokuPricePoints(iPricesResult);
            }
         }
         else
         {
            result.apply(null,[prices]);
         }
      }
   }
}

