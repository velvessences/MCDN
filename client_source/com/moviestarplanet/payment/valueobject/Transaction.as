package com.moviestarplanet.payment.valueobject
{
   public class Transaction
   {
      
      public var TransactionId:int;
      
      public var ActorId:int;
      
      public var Amount:int;
      
      public var Currency:String;
      
      public var MobileNumber:String;
      
      public var trx_id:String;
      
      public var Timestamp:Date;
      
      public var StarCoinsBefore:int;
      
      public var StarCoinsAfter:int;
      
      public var result_code:int;
      
      public var content_id:String;
      
      public var CardNumber:String;
      
      public var ReceiptEmail:String;
      
      public var ReceiptSent:int;
      
      public var Provider:String;
      
      public var ProductId:int;
      
      public var RecurringPaymentSubscriptionId:int;
      
      public var GivenPurchaseItemsPurchaseTypeId:int;
      
      public var CountryCode:String;
      
      public var OrderType:int;
      
      public var ProcessedTransactionId:int;
      
      public var CarrierName:String;
      
      public function Transaction()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.TransactionId = param1.TransactionId as int;
         this.ActorId = param1.ActorId as int;
         this.Amount = param1.Amount as int;
         this.Currency = param1.Currency as String;
         this.MobileNumber = param1.MobileNumber as String;
         this.trx_id = param1.trx_id as String;
         this.Timestamp = param1.Timestamp as Date;
         this.StarCoinsBefore = param1.StarCoinsBefore as int;
         this.StarCoinsAfter = param1.StarCoinsAfter as int;
         this.result_code = param1.result_code as int;
         this.content_id = param1.content_id as String;
         this.CardNumber = param1.CardNumber as String;
         this.ReceiptEmail = param1.ReceiptEmail as String;
         this.ReceiptSent = param1.ReceiptSent as int;
         this.Provider = param1.Provider as String;
         this.ProductId = param1.ProductId as int;
         this.RecurringPaymentSubscriptionId = param1.RecurringPaymentSubscriptionId as int;
         this.GivenPurchaseItemsPurchaseTypeId = param1.GivenPurchaseItemsPurchaseTypeId as int;
         this.CountryCode = param1.CountryCode as String;
         this.OrderType = param1.OrderType as int;
         this.ProcessedTransactionId = param1.ProcessedTransactionId as int;
         this.CarrierName = param1.CarrierName as String;
      }
   }
}

