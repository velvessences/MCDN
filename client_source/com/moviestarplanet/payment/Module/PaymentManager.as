package com.moviestarplanet.payment.Module
{
   import com.moviestarplanet.Module.AbstractModuleManager;
   import com.moviestarplanet.Module.ModuleInterface;
   import com.moviestarplanet.advertisement.TrafficTracking;
   import com.moviestarplanet.payment.Module.ModuleParts.IPaymentModule;
   import com.moviestarplanet.payment.valueobject.PurchaseTypeDomain;
   import flash.display.DisplayObjectContainer;
   
   public class PaymentManager extends AbstractModuleManager implements IPaymentManager
   {
      
      private static var instance:PaymentManager;
      
      public function PaymentManager()
      {
         super();
      }
      
      public static function getInstance() : PaymentManager
      {
         if(instance == null)
         {
            instance = new PaymentManager();
         }
         return instance;
      }
      
      override protected function getLoadingThemeColor() : uint
      {
         return 0;
      }
      
      override protected function get moduleName() : String
      {
         return "PaymentModule";
      }
      
      private function getPaymentModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:ModuleInterface = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               callback(IPaymentModule(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IPaymentModule(module));
         }
      }
      
      public function openOffersView(param1:Boolean = false, param2:Array = null, param3:int = 0) : void
      {
         var moduleReturned:Function = null;
         var openFromExternalModule:Boolean = param1;
         var topUpPacksFromExternalModule:Array = param2;
         var vipTiersSwitch:int = param3;
         moduleReturned = function(param1:IPaymentModule):void
         {
            param1.openOffersView(openFromExternalModule,topUpPacksFromExternalModule,vipTiersSwitch);
         };
         TrafficTracking.ProductOveriew();
         this.getPaymentModule(moduleReturned);
      }
      
      public function openSelectPaymentView(param1:PurchaseTypeDomain, param2:String, param3:String, param4:Boolean, param5:Boolean = false) : void
      {
         var moduleReturned:Function = null;
         var offerBarProperties:PurchaseTypeDomain = param1;
         var country:String = param2;
         var extraParams:String = param3;
         var isUpgrade:Boolean = param4;
         var isFrontPage:Boolean = param5;
         moduleReturned = function(param1:IPaymentModule):void
         {
            param1.openSelectPaymentView(offerBarProperties,country,extraParams,isUpgrade,isFrontPage);
         };
         TrafficTracking.PaymentOption();
         this.getPaymentModule(moduleReturned);
      }
      
      public function openPayments() : void
      {
         var moduleReturned:Function = null;
         moduleReturned = function(param1:IPaymentModule):void
         {
            param1.openPayments();
         };
         this.getPaymentModule(moduleReturned);
      }
      
      public function openVipDetailsView() : void
      {
         var moduleReturned:Function = null;
         moduleReturned = function(param1:IPaymentModule):void
         {
            param1.openVipDetailsView();
         };
         this.getPaymentModule(moduleReturned);
      }
      
      public function transactionSuccess(param1:Number) : void
      {
         var moduleReturned:Function = null;
         var transactionId:Number = param1;
         moduleReturned = function(param1:IPaymentModule):void
         {
            param1.transactionSuccess(transactionId);
         };
         this.getPaymentModule(moduleReturned);
      }
      
      public function placeItemsInOneRow(param1:DisplayObjectContainer, param2:Array) : void
      {
         var moduleReturned:Function = null;
         var itembox:DisplayObjectContainer = param1;
         var itemLoaders:Array = param2;
         moduleReturned = function(param1:IPaymentModule):void
         {
            param1.placeItemsInOneRow(itembox,itemLoaders);
         };
         this.getPaymentModule(moduleReturned);
      }
      
      public function showDisableRecurringPaymentLoginPopup(param1:int, param2:int, param3:int) : void
      {
         var moduleReturned:Function = null;
         var subscriptionId:int = param1;
         var _left:int = param2;
         var _top:int = param3;
         moduleReturned = function(param1:IPaymentModule):void
         {
            param1.showDisableRecurringPaymentLoginPopup(subscriptionId,_left,_top);
         };
         this.getPaymentModule(moduleReturned);
      }
   }
}

