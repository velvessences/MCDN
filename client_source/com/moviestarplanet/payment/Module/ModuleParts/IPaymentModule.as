package com.moviestarplanet.payment.Module.ModuleParts
{
   import com.moviestarplanet.Module.ModuleInterface;
   import com.moviestarplanet.payment.valueobject.PurchaseTypeDomain;
   import flash.display.DisplayObjectContainer;
   
   public interface IPaymentModule extends ModuleInterface
   {
      
      function openOffersView(param1:Boolean, param2:Array, param3:int = 0) : void;
      
      function openSelectPaymentView(param1:PurchaseTypeDomain, param2:String, param3:String, param4:Boolean, param5:Boolean = false) : void;
      
      function openPayments() : void;
      
      function openVipDetailsView() : void;
      
      function transactionSuccess(param1:Number) : void;
      
      function placeItemsInOneRow(param1:DisplayObjectContainer, param2:Array) : void;
      
      function showDisableRecurringPaymentLoginPopup(param1:int, param2:int, param3:int) : void;
   }
}

