package com.moviestarplanet.payment.valueobject
{
   public class CountryPrices
   {
      
      public var country:String;
      
      public var currency:String;
      
      public var currencySymbol:String;
      
      public var currencySymbolOrientation:String;
      
      public var keyPriceArray:Array;
      
      public function CountryPrices()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:KeyPrice = null;
         this.country = param1.country as String;
         this.currency = param1.currency as String;
         this.currencySymbol = param1.currencySymbol as String;
         this.currencySymbolOrientation = param1.currencySymbolOrientation as String;
         this.keyPriceArray = new Array();
         for each(_loc2_ in param1.keyPriceArray)
         {
            _loc3_ = new KeyPrice();
            _loc3_.parseObject(_loc2_);
            this.keyPriceArray.push(_loc3_);
         }
      }
   }
}

