package com.moviestarplanet.payment
{
   import com.moviestarplanet.Module.AbstractFlashModuleManager;
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.membership.UserTypeDeterminator;
   import com.moviestarplanet.model.ActorModel;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.payment.Module.ModuleParts.catalog.PaymentCatalog;
   import com.moviestarplanet.payment.Module.PaymentManager;
   import com.moviestarplanet.payment.services.IPaymentService;
   import com.moviestarplanet.payment.services.PaymentAmfService;
   import com.moviestarplanet.payment.valueobject.CountryPrices;
   import com.moviestarplanet.payment.valueobject.PurchaseTypeDomain;
   import com.moviestarplanet.services.wrappers.SessionService;
   import com.moviestarplanet.utils.DateUtils;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.window.loading.LoadingBar;
   
   public class PaymentModuleExternalManager extends AbstractFlashModuleManager
   {
      
      private static var _instance:PaymentModuleExternalManager;
      
      private static var _purchasablePacks:Array;
      
      private static var _paymentOptions:Object;
      
      private static var loadingBar:LoadingBar;
      
      public static const USE_OLD_VIP:int = 2;
      
      public static const USE_NEW_VIP_TIERS:int = 1;
      
      public function PaymentModuleExternalManager(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : PaymentModuleExternalManager
      {
         if(_instance == null)
         {
            _instance = new PaymentModuleExternalManager(new SingletonEnforcer());
            loadingBar = new LoadingBar();
         }
         return _instance;
      }
      
      public function openPurchaseFlow() : void
      {
         loadingBar.show();
         ActorReload.getInstance().requestReload(this.actorReloaded);
      }
      
      private function actorReloaded() : void
      {
         var done:Function = null;
         done = function(param1:PurchaseTypeDomain, param2:int, param3:Number = -1):void
         {
         };
         if(ActorSession.loggedInActor.LastTransactionId == 0)
         {
            SessionService.GetAppSetting("PurchaseFlow",this.purchaseFlowSwitchFetched);
         }
         else if(ActorSession.loggedInActor.MembershipTimeoutDate < DateUtils.nowUTC)
         {
            new PaymentProvider().GetTransactionPurchaseInfo(ActorSession.getActorId(),ActorSession.loggedInActor.LastTransactionId,done);
            SessionService.GetAppSetting("PurchaseFlow",this.purchaseFlowSwitchFetched);
         }
         else
         {
            loadingBar.hide();
         }
      }
      
      private function purchaseFlowSwitchFetched(param1:int) : void
      {
         if(param1 == USE_OLD_VIP)
         {
            loadingBar.hide();
            PaymentManager.getInstance().openOffersView(false,null,param1);
         }
         else if(param1 == USE_NEW_VIP_TIERS)
         {
            PaymentCaching.getPrices(this.countryPricesFetched);
         }
      }
      
      private function countryPricesFetched(param1:CountryPrices) : void
      {
         var _loc2_:IPaymentService = new PaymentAmfService();
         _loc2_.getAvailablePurchaseTypes(ActorModel.getInstance().actorId,this.purchaseTypesFetched);
      }
      
      private function purchaseTypesFetched(param1:Object) : void
      {
         var gotPrices:Function = null;
         var result:Object = param1;
         gotPrices = function(param1:CountryPrices):void
         {
            PaymentCatalog.loadPaymentMethods(param1.country,paymentOptionsFetched);
         };
         _purchasablePacks = result.Data as Array;
         var typeOfUser:Number = UserTypeDeterminator.determineUserTypeByDaysLimit(ActorSession.loggedInActor.MembershipTimeoutDate);
         if(typeOfUser == UserTypeDeterminator.IS_VIP)
         {
            this.openTopup();
         }
         else
         {
            PaymentCaching.getPrices(gotPrices);
         }
      }
      
      private function paymentOptionsFetched(param1:Object) : void
      {
         _paymentOptions = param1;
         this.openPurchaseVip();
      }
      
      private function openPurchaseVip() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IPaymentModuleExternal):void
         {
            VipTierAnalyticsInternal.dispatchStartFlow();
            loadingBar.hide();
            param1.openPurchaseVip();
         };
         this.getPaymentModuleExternal(moduleLoaded);
      }
      
      public function openPurchaseGiftCertificate(param1:Function = null) : void
      {
         var moduleLoaded:Function = null;
         var onClose:Function = param1;
         moduleLoaded = function(param1:IPaymentModuleExternal):void
         {
            loadingBar.hide();
            param1.openPurchaseGiftCertificate(onClose);
         };
         this.getPaymentModuleExternal(moduleLoaded);
      }
      
      public function openSpecialOfferView(param1:int, param2:Function) : void
      {
         var moduleLoaded:Function = null;
         var secondsLeft:int = param1;
         var onClose:Function = param2;
         moduleLoaded = function(param1:IPaymentModuleExternal):void
         {
            loadingBar.hide();
            param1.openSpecialOfferView(secondsLeft,onClose);
         };
         this.getPaymentModuleExternal(moduleLoaded);
      }
      
      public function openUpgradeVip() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IPaymentModuleExternal):void
         {
            VipTierAnalyticsInternal.dispatchStartFlow();
            loadingBar.hide();
            param1.openUpgradeVip();
         };
         loadingBar.show();
         this.getPaymentModuleExternal(moduleLoaded);
      }
      
      private function openTopup() : void
      {
         var _loc1_:Boolean = true;
         var _loc2_:Array = new Array();
         var _loc3_:int = 4;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(_purchasablePacks[_loc4_]);
            _loc4_++;
         }
         _loc2_.sort(this.sortByCost);
         loadingBar.hide();
         PaymentManager.getInstance().openOffersView(_loc1_,_loc2_);
      }
      
      private function sortByCost(param1:PurchaseTypeDomain, param2:PurchaseTypeDomain) : int
      {
         if(param1.Cost > param2.Cost)
         {
            return -1;
         }
         if(param1.Cost < param2.Cost)
         {
            return 1;
         }
         return 0;
      }
      
      private function getPaymentModuleExternal(param1:Function) : void
      {
         var moduleLoaded:Function;
         var callback:Function = param1;
         var module:IFlashModule = getModule();
         if(module == null)
         {
            moduleLoaded = function():void
            {
               initModule();
               callback(IPaymentModuleExternal(getModule()));
            };
            loadModule(moduleLoaded);
         }
         else
         {
            this.initModule();
            this.updateNewData();
            callback(IPaymentModuleExternal(module));
         }
      }
      
      private function updateNewData() : void
      {
         if(_purchasablePacks != null)
         {
            (getModule() as IPaymentModuleExternal).setPurchasablePacks(_purchasablePacks);
            (getModule() as IPaymentModuleExternal).setMembershipTimeoutDate(ActorSession.loggedInActor.MembershipTimeoutDate);
         }
      }
      
      private function initModule() : void
      {
         (getModule() as IPaymentModuleExternal).setActorModel(ActorModel.getInstance());
         (getModule() as IPaymentModuleExternal).setFontManager(new FontManager());
         (getModule() as IPaymentModuleExternal).setPurchasablePacks(_purchasablePacks);
         (getModule() as IPaymentModuleExternal).setCountryPrices();
         (getModule() as IPaymentModuleExternal).setPaymentOptions(_paymentOptions);
         if(ActorSession.loggedInActor)
         {
            (getModule() as IPaymentModuleExternal).setMembershipTimeoutDate(ActorSession.loggedInActor.MembershipTimeoutDate);
         }
      }
      
      override protected function get moduleName() : String
      {
         return "PaymentModuleExternal";
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
