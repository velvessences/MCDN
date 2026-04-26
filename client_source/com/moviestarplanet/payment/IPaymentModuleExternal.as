package com.moviestarplanet.payment
{
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.font.IFontManager;
   import com.moviestarplanet.model.IActorModel;
   
   public interface IPaymentModuleExternal extends IFlashModule
   {
      
      function openPurchaseVip() : void;
      
      function openUpgradeVip() : void;
      
      function openPurchaseGiftCertificate(param1:Function = null) : void;
      
      function openSpecialOfferView(param1:int, param2:Function) : void;
      
      function setActorModel(param1:IActorModel) : void;
      
      function setFontManager(param1:IFontManager) : void;
      
      function setPurchasablePacks(param1:Array) : void;
      
      function setPaymentOptions(param1:Object) : void;
      
      function setCountryPrices() : void;
      
      function setMembershipTimeoutDate(param1:Date) : void;
   }
}

