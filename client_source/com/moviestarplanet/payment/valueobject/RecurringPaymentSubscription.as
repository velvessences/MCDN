package com.moviestarplanet.payment.valueobject
{
   public class RecurringPaymentSubscription
   {
      
      public var actorHasRecurringSubscription:Boolean;
      
      public var recurringSubscriptionId:int;
      
      public var purchaseTypeId:int;
      
      public var DaysVip:int;
      
      public var purchaseTypeName:String;
      
      public var price:int;
      
      public var currency:String;
      
      public function RecurringPaymentSubscription()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.actorHasRecurringSubscription = param1.actorHasRecurringSubscription as Boolean;
         this.recurringSubscriptionId = param1.recurringSubscriptionId as int;
         this.purchaseTypeId = param1.purchaseTypeId as int;
         this.DaysVip = param1.DaysVip as int;
         this.purchaseTypeName = param1.purchaseTypeName as String;
         this.price = param1.price as int;
         this.currency = param1.currency as String;
      }
   }
}

