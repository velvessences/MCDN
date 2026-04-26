package com.moviestarplanet.payment.valueobject
{
   import mx.utils.StringUtil;
   
   public class VerifyBokuTransactionResult
   {
      
      public var transactionId:String;
      
      public var resultCode:String;
      
      public var resultMessage:String;
      
      public function VerifyBokuTransactionResult()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         this.transactionId = StringUtil.trim(param1.transactionId as String);
         this.resultCode = StringUtil.trim(param1.resultCode as String);
         this.resultMessage = StringUtil.trim(param1.resultMessage as String);
      }
   }
}

