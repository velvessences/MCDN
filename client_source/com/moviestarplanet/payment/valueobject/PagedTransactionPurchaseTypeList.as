package com.moviestarplanet.payment.valueobject
{
   public class PagedTransactionPurchaseTypeList
   {
      
      public var totalRecords:int;
      
      public var pageindex:int;
      
      public var pagesize:int;
      
      public var items:Array;
      
      public function PagedTransactionPurchaseTypeList()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:TransactionPurchaseType = null;
         this.totalRecords = param1.totalRecords as int;
         this.pageindex = param1.pageindex as int;
         this.pagesize = param1.pagesize as int;
         this.items = new Array();
         for each(_loc2_ in param1.items)
         {
            _loc3_ = new TransactionPurchaseType();
            _loc3_.parseObject(_loc2_);
            this.items.push(_loc3_);
         }
      }
   }
}

