package com.moviestarplanet.payment.valueobject
{
   public class KeyPrice
   {
      
      public var key:String;
      
      public var price:int;
      
      public var standardPrice:int;
      
      public var standardPriceApple:String;
      
      public var standardPriceGoogle:String;
      
      public function KeyPrice()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.key = param1.key as String;
         this.price = param1.price as int;
         this.standardPrice = param1.standardPrice as int;
         this.standardPriceApple = param1.standardPriceApple as String;
         this.standardPriceGoogle = param1.standardPriceGoogle as String;
      }
   }
}

