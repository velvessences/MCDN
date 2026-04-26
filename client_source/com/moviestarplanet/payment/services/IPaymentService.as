package com.moviestarplanet.payment.services
{
   public interface IPaymentService
   {
      
      function redeemCode(param1:int, param2:String, param3:int, param4:Function) : void;
      
      function getAvailablePurchaseTypes(param1:int, param2:Function) : void;
      
      function givePurchaseTypeProperties(param1:int, param2:int, param3:Function) : void;
      
      function GetTransactionsFilterByType(param1:String, param2:String, param3:int, param4:int, param5:Function) : void;
      
      function GetTransactions(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function GetRecurringPaymentSubscription(param1:int, param2:Function) : void;
      
      function GetBokuPricePoints(param1:Function) : void;
      
      function GetTransactionPurchaseItems(param1:int, param2:int, param3:Function) : void;
      
      function GetTransactionPurchaseInfo(param1:int, param2:int, param3:Function) : void;
      
      function GetCurrentPaymentPossibilities(param1:int, param2:Function) : void;
      
      function GetTransactionPurchaseTypes(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function GetTransactionPurchaseTypesIncludingManual(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function GetTransactionPurchaseList(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function GetTransactionPurchaseListIncludingManual(param1:int, param2:int, param3:int, param4:Function) : void;
      
      function DisableAutomaticRenewal(param1:int, param2:Function) : void;
      
      function GetPaymentMethods(param1:String, param2:Function) : void;
      
      function GetBokuUrl(param1:String, param2:Number, param3:String, param4:String, param5:String, param6:Function) : void;
      
      function VerifyBokuTransaction(param1:String, param2:Function) : void;
   }
}

