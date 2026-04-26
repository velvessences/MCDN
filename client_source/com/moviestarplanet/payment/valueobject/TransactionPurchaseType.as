package com.moviestarplanet.payment.valueobject
{
   import mx.utils.StringUtil;
   
   public class TransactionPurchaseType
   {
      
      public var ActorId:int;
      
      public var Amount:Number;
      
      public var ContentId:String;
      
      public var Currency:String;
      
      public var ProductId:int;
      
      public var PurchaseStarCoinsAmount:int;
      
      public var PurchaseVipAmount:int;
      
      public var resultCode:int;
      
      public var Timestamp:Date;
      
      public var TransactionId:int;
      
      public var trx_id:String;
      
      public var Type:String;
      
      public var transactionIsAutomatic:Boolean;
      
      public var IsUpgrade:Boolean;
      
      public var PriceWithCurrency:String;
      
      public function TransactionPurchaseType()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.ActorId = param1.ActorId as int;
         this.Amount = (param1.Amount != null ? param1.Amount : Number.NaN) as Number;
         this.ContentId = StringUtil.trim(param1.ContentId as String);
         this.Currency = StringUtil.trim(param1.Currency as String);
         this.ProductId = param1.ProductId as int;
         this.PurchaseStarCoinsAmount = param1.PurchaseStarCoinsAmount as int;
         this.PurchaseVipAmount = param1.PurchaseVipAmount as int;
         this.resultCode = param1.resultCode as int;
         this.Timestamp = param1.Timestamp as Date;
         this.TransactionId = param1.TransactionId as int;
         this.trx_id = StringUtil.trim(param1.trx_id as String);
         this.Type = StringUtil.trim(param1.Type as String);
         this.transactionIsAutomatic = param1.transactionIsAutomatic as Boolean;
         this.IsUpgrade = param1.IsUpgrade as Boolean;
         this.PriceWithCurrency = param1.PriceWithCurrency as String;
      }
   }
}

