package com.moviestarplanet.payment
{
   import com.moviestarplanet.amf.PagerResultObject;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.mangroveanalytics.MangroveAnalytics;
   import com.moviestarplanet.payment.services.IPaymentService;
   import com.moviestarplanet.payment.valueobject.CountryPrices;
   import com.moviestarplanet.payment.valueobject.GetBokuBuyUrlResult;
   import com.moviestarplanet.payment.valueobject.PagedTransactionList;
   import com.moviestarplanet.payment.valueobject.PagedTransactionPurchaseTypeList;
   import com.moviestarplanet.payment.valueobject.PaymentMethodDescriptor;
   import com.moviestarplanet.payment.valueobject.PurchaseTypeDomain;
   import com.moviestarplanet.payment.valueobject.RecurringPaymentSubscription;
   import com.moviestarplanet.payment.valueobject.ServiceResultDataOfListOfPurchaseTypeDomain;
   import com.moviestarplanet.payment.valueobject.VerifyBokuTransactionResult;
   import com.moviestarplanet.utils.Cache;
   import com.moviestarplanet.valueObjects.ServiceResultDataOfListOfCertificateGift;
   import mx.collections.ArrayCollection;
   
   public class PaymentProvider
   {
      
      public static const REDEEM_CODE_TYPE_GIFT_CERTIFICATE:int = 0;
      
      public static const REDEEM_CODE_TYPE_EGMONT_MAGAZINE:int = 1;
      
      private static const CACHE_KEY_PAYMENT_POSSIBILITIES:String = "CACHE_KEY_PAYMENT_POSSIBILITIES";
      
      [Inject]
      public var paymentService:IPaymentService;
      
      public function PaymentProvider()
      {
         super();
         InjectionManager.manager().injectMe(this);
      }
      
      public function redeemCode(param1:int, param2:String, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var code:String = param2;
         var codeType:int = param3;
         var resultCallback:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:ServiceResultDataOfListOfCertificateGift = null;
            if(param1 != null)
            {
               _loc2_ = new ServiceResultDataOfListOfCertificateGift();
               _loc2_.Data = param1.Data;
               _loc2_.Code = param1.Code;
               _loc2_.Description = param1.Description;
               resultCallback(_loc2_);
            }
         };
         this.paymentService.redeemCode(actorId,code,codeType,doneCallback);
      }
      
      public function GetTransactionsFilterByType(param1:Object, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var params:Object = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:PagedTransactionList = new PagedTransactionList();
            _loc2_.parseObject(param1);
            var _loc3_:Boolean = _loc2_.items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items,pageIndex);
            resultCallBack(_loc4_);
         };
         var filterValue:String = params.filterValue;
         var filterType:String = params.filterType;
         this.paymentService.GetTransactionsFilterByType(filterValue,filterType,pageIndex,pageSize,doneCallback);
      }
      
      public function GetTransactions(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:PagedTransactionList = new PagedTransactionList();
            _loc2_.parseObject(param1);
            var _loc3_:Boolean = _loc2_.items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items,pageIndex);
            resultCallBack(_loc4_);
         };
         this.paymentService.GetTransactions(actorId,pageIndex,pageSize,doneCallback);
      }
      
      public function GetRecurringPaymentSubscription(param1:int, param2:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallBack:Function = param2;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:RecurringPaymentSubscription = new RecurringPaymentSubscription();
            _loc2_.parseObject(param1);
            resultCallBack(_loc2_);
         };
         this.paymentService.GetRecurringPaymentSubscription(actorId,doneCallback);
      }
      
      public function GetBokuPricePoints(param1:Function) : void
      {
         var doneCallback:Function = null;
         var resultCallBack:Function = param1;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:CountryPrices = new CountryPrices();
            _loc2_.parseObject(param1);
            resultCallBack(_loc2_);
         };
         this.paymentService.GetBokuPricePoints(doneCallback);
      }
      
      public function getTransactionPurchaseItems(param1:int, param2:int, param3:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var transactionId:int = param2;
         var callback:Function = param3;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:PurchaseTypeDomain = new PurchaseTypeDomain();
            _loc2_.parseObject(param1);
            callback(_loc2_);
         };
         this.paymentService.GetTransactionPurchaseItems(actorId,transactionId,doneCallback);
      }
      
      public function GetTransactionPurchaseInfo(param1:int, param2:int, param3:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var transactionId:int = param2;
         var callback:Function = param3;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:PurchaseTypeDomain = new PurchaseTypeDomain();
            _loc2_.parseObject(param1.purchaseTypeDomain);
            MangroveAnalytics.registerMoneyTransaction(transactionId.toString(),_loc2_.getMangroveItemContexts());
            callback(_loc2_,param1.UpgradeVIPTier,transactionId);
         };
         this.paymentService.GetTransactionPurchaseInfo(actorId,transactionId,doneCallback);
      }
      
      public function GetCurrentPaymentPossibilities(param1:int, param2:Function) : void
      {
         var doneCallback:Function = null;
         var types:int = param1;
         var result:Function = param2;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:ServiceResultDataOfListOfPurchaseTypeDomain = new ServiceResultDataOfListOfPurchaseTypeDomain();
            _loc2_.parseObject(param1);
            Cache.cacheItem(param1.result,CACHE_KEY_PAYMENT_POSSIBILITIES + ",TYPES:" + types);
            result(_loc2_);
         };
         var cachedResult:Object = Cache.getFromCache(CACHE_KEY_PAYMENT_POSSIBILITIES + ",TYPES:" + types);
         if(cachedResult != null)
         {
            result(cachedResult);
            return;
         }
         this.paymentService.GetCurrentPaymentPossibilities(types,doneCallback);
      }
      
      public function GetTransactionPurchaseTypes(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:PagedTransactionPurchaseTypeList = new PagedTransactionPurchaseTypeList();
            _loc2_.parseObject(param1);
            var _loc3_:Boolean = _loc2_.items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items,pageIndex);
            resultCallBack(_loc4_);
         };
         this.paymentService.GetTransactionPurchaseTypes(actorId,pageIndex,pageSize,doneCallback);
      }
      
      public function GetTransactionPurchaseListIncludingManual(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:PagedTransactionPurchaseTypeList = new PagedTransactionPurchaseTypeList();
            _loc2_.parseObject(param1);
            var _loc3_:Boolean = _loc2_.items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items,pageIndex);
            resultCallBack(_loc4_);
         };
         this.paymentService.GetTransactionPurchaseListIncludingManual(actorId,pageIndex,pageSize,doneCallback);
      }
      
      public function GetTransactionPurchaseList(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var pageIndex:int = param2;
         var pageSize:int = param3;
         var resultCallBack:Function = param4;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:PagedTransactionPurchaseTypeList = new PagedTransactionPurchaseTypeList();
            _loc2_.parseObject(param1);
            var _loc3_:Boolean = _loc2_.items.length == pageSize;
            var _loc4_:PagerResultObject = new PagerResultObject(_loc2_.totalRecords,_loc3_,_loc2_.items,pageIndex);
            resultCallBack(_loc4_);
         };
         this.paymentService.GetTransactionPurchaseList(actorId,pageIndex,pageSize,doneCallback);
      }
      
      public function DisableAutomaticRenewal(param1:int, param2:Function) : void
      {
         var doneCallback:Function = null;
         var actorId:int = param1;
         var resultCallBack:Function = param2;
         doneCallback = function(param1:Object):void
         {
            resultCallBack(param1);
         };
         this.paymentService.DisableAutomaticRenewal(actorId,doneCallback);
      }
      
      public function GetPaymentMethods(param1:String, param2:Function) : void
      {
         var doneCallback:Function = null;
         var country:String = param1;
         var resultCallback:Function = param2;
         doneCallback = function(param1:Array):void
         {
            var _loc2_:ArrayCollection = null;
            var _loc3_:Object = null;
            var _loc4_:PaymentMethodDescriptor = null;
            if(resultCallback != null)
            {
               _loc2_ = new ArrayCollection();
               for each(_loc3_ in param1)
               {
                  _loc4_ = new PaymentMethodDescriptor();
                  _loc4_.parseObject(_loc3_);
                  _loc2_.addItem(_loc4_);
               }
               resultCallback(_loc2_);
            }
         };
         this.paymentService.GetPaymentMethods(country,doneCallback);
      }
      
      public function GetBokuUrl(param1:String, param2:Number, param3:String, param4:String = "", param5:String = "600px", param6:Function = null) : void
      {
         var doneCallback:Function = null;
         var key:String = param1;
         var purchaseTypeId:Number = param2;
         var param:String = param3;
         var msisdn:String = param4;
         var bokuPanelStyle:String = param5;
         var resultCallBack:Function = param6;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:GetBokuBuyUrlResult = new GetBokuBuyUrlResult();
            _loc2_.parseObject(param1);
            resultCallBack(_loc2_);
         };
         this.paymentService.GetBokuUrl(key,purchaseTypeId,param,msisdn,bokuPanelStyle,doneCallback);
      }
      
      public function VerifyBokuTransaction(param1:String, param2:Function = null) : void
      {
         var doneCallback:Function = null;
         var transactionId:String = param1;
         var resultCallBack:Function = param2;
         doneCallback = function(param1:Object):void
         {
            var _loc2_:VerifyBokuTransactionResult = new VerifyBokuTransactionResult();
            _loc2_.parseObject(param1);
            resultCallBack(_loc2_);
         };
         this.paymentService.VerifyBokuTransaction(transactionId,doneCallback);
      }
   }
}

