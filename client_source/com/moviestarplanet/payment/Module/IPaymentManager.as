package com.moviestarplanet.payment.Module
{
   import com.moviestarplanet.Module.ModuleManagerInterface;
   import com.moviestarplanet.payment.valueobject.PurchaseTypeDomain;
   import flash.display.DisplayObjectContainer;
   
   public interface IPaymentManager extends ModuleManagerInterface
   {
      
      function openOffersView(param1:Boolean = false, param2:Array = null, param3:int = 0) : void;
      
      function openSelectPaymentView(param1:PurchaseTypeDomain, param2:String, param3:String, param4:Boolean, param5:Boolean = false) : void;
      
      function openPayments() : void;
      
      function openVipDetailsView() : void;
      
      function transactionSuccess(param1:Number) : void;
      
      function placeItemsInOneRow(param1:DisplayObjectContainer, param2:Array) : void;
      
      function showDisableRecurringPaymentLoginPopup(param1:int, param2:int, param3:int) : void;
   }
}

