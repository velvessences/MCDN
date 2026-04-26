package com.moviestarplanet.payment.services
{
   import com.adobe.utils.StringUtil;
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.payment.valueobject.PropertyAvailable;
   import com.moviestarplanet.payment.valueobject.PurchaseTypeDomain;
   
   public class PaymentAmfService implements IPaymentService
   {
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.Payment.AMFPaymentService");
      
      public function PaymentAmfService()
      {
         super();
      }
      
      public function redeemCode(param1:int, param2:String, param3:int, param4:Function) : void
      {
         amfCaller.callFunction("RedeemCode",[param1,param2,param3],true,param4);
      }
      
      public function getAvailablePurchaseTypes(param1:int, param2:Function) : void
      {
         var parseResult:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         parseResult = function(param1:*):void
         {
            var _loc4_:PurchaseTypeDomain = null;
            var _loc2_:Array = param1.Data;
            var _loc3_:int = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_] as PurchaseTypeDomain;
               _loc4_.ContentId = StringUtil.trim(_loc4_.ContentId);
               _loc3_++;
            }
            callback(param1);
         };
         amfCaller.callFunction("GetAvailablePurchaseTypes",[actorId],true,parseResult);
      }
      
      public function getTimeLimitedPurchaseType(param1:int, param2:Function) : void
      {
         var parseResult:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         parseResult = function(param1:*):void
         {
            var _loc5_:PurchaseTypeDomain = null;
            var _loc2_:Array = param1.Data;
            var _loc3_:int = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc5_ = _loc2_[_loc3_] as PurchaseTypeDomain;
               _loc5_.ContentId = StringUtil.trim(_loc5_.ContentId);
               _loc3_++;
            }
            var _loc4_:PurchaseTypeDomain = _loc2_[0] as PurchaseTypeDomain;
            callback(_loc4_);
         };
         amfCaller.callFunction("GetTimeLimitedPurchaseType",[actorId],true,parseResult);
      }
      
      public function givePurchaseTypeProperties(param1:int, param2:int, param3:Function) : void
      {
         amfCaller.callFunction("GivePurchaseTypeProperties",[param1,param2],true,param3);
      }
      
      private function toPropertyAvailable(param1:*, param2:int, param3:Array) : PropertyAvailable
      {
         return PropertyAvailable.fromAny(param1);
      }
      
      public function GetTransactionsFilterByType(param1:String, param2:String, param3:int, param4:int, param5:Function) : void
      {
         amfCaller.callFunction("GetTransactionsFilterByType",[param1,param2,param3,param4],true,param5);
      }
      
      public function GetTransactions(param1:int, param2:int, param3:int, param4:Function) : void
      {
         amfCaller.callFunction("GetTransactionsAsModerator",[param1,param2,param3],true,param4);
      }
      
      public function GetRecurringPaymentSubscription(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("GetRecurringPaymentSubscription",[param1],true,param2);
      }
      
      public function GetBokuPricePoints(param1:Function) : void
      {
         amfCaller.callFunction("GetBokuPricePoints",[],true,param1);
      }
      
      public function GetTransactionPurchaseItems(param1:int, param2:int, param3:Function) : void
      {
         amfCaller.callFunction("GetTransactionPurchaseItems",[param1,param2],true,param3);
      }
      
      public function GetTransactionPurchaseInfo(param1:int, param2:int, param3:Function) : void
      {
         amfCaller.callFunction("GetTransactionPurchaseInfo",[param1,param2],true,param3);
      }
      
      public function GetCurrentPaymentPossibilities(param1:int, param2:Function) : void
      {
         var parseResult:Function = null;
         var types:int = param1;
         var callback:Function = param2;
         parseResult = function(param1:*):void
         {
            var _loc4_:PurchaseTypeDomain = null;
            var _loc2_:Array = param1.Data.source;
            var _loc3_:int = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_] as PurchaseTypeDomain;
               _loc4_.ContentId = StringUtil.trim(_loc4_.ContentId);
               _loc3_++;
            }
            callback(param1);
         };
         amfCaller.callFunction("GetCurrentPaymentPossibilities",[types],true,parseResult);
      }
      
      public function GetTransactionPurchaseTypesIncludingManual(param1:int, param2:int, param3:int, param4:Function) : void
      {
         amfCaller.callFunction("GetTransactionPurchaseTypesIncludingManual",[param1,param2,param3],true,param4);
      }
      
      public function GetTransactionPurchaseTypes(param1:int, param2:int, param3:int, param4:Function) : void
      {
         amfCaller.callFunction("GetTransactionPurchaseTypes",[param1,param2,param3],true,param4);
      }
      
      public function GetTransactionPurchaseListIncludingManual(param1:int, param2:int, param3:int, param4:Function) : void
      {
         amfCaller.callFunction("GetTransactionPurchaseListIncludingManual",[param1,param2,param3],true,param4);
      }
      
      public function GetTransactionPurchaseList(param1:int, param2:int, param3:int, param4:Function) : void
      {
         amfCaller.callFunction("GetTransactionPurchaseList",[param1,param2,param3],true,param4);
      }
      
      public function DisableAutomaticRenewal(param1:int, param2:Function) : void
      {
         amfCaller.callFunction("DisableAutomaticRenewal",[param1],true,param2);
      }
      
      public function GetPaymentMethods(param1:String, param2:Function) : void
      {
         amfCaller.callFunction("GetPaymentMethods",[param1],true,param2);
      }
      
      public function GetBokuUrl(param1:String, param2:Number, param3:String, param4:String, param5:String, param6:Function) : void
      {
         amfCaller.callFunction("GetBokuBuyUrlNew",[param1,param2,param3,param4,param5],true,param6);
      }
      
      public function VerifyBokuTransaction(param1:String, param2:Function) : void
      {
         amfCaller.callFunction("VerifyBokuTransaction",[param1],true,param2);
      }
   }
}

