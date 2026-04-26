package com.moviestarplanet.core.controller.commands
{
   import com.moviestarplanet.emoticon.purchase.EmoticonPurchaseController;
   import com.moviestarplanet.emoticon.valueobjects.EmoticonPackage;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.components.popups.GetDiamondsPopUp;
   import com.moviestarplanet.flash.components.popups.GetStarCoinsPopup;
   import com.moviestarplanet.flash.components.popups.viponly.VIPOnlyPopUp;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.look.service.ILookService;
   import com.moviestarplanet.look.service.LookAMFService;
   import com.moviestarplanet.look.valueobjects.LookItem;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.moviestar.MovieStar;
   import com.moviestarplanet.msg.events.ShopOffersEvent;
   import com.moviestarplanet.payment.Module.PaymentManager;
   import com.moviestarplanet.payment.PaymentModuleExternalManager;
   import com.moviestarplanet.shopping.ShoppingModuleManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   
   public class ShopOffersCommand
   {
      
      public function ShopOffersCommand()
      {
         super();
      }
      
      public static function openPaymentOffers(param1:MsgEvent) : void
      {
         PaymentModuleExternalManager.getInstance().openPurchaseFlow();
      }
      
      public static function openVipPopup(param1:MsgEvent) : void
      {
         var _loc2_:String = param1.data as String;
         VIPOnlyPopUp.Show(_loc2_);
      }
      
      public static function openStarcoinsPopup(param1:MsgEvent) : void
      {
         new GetStarCoinsPopup();
      }
      
      public static function openDiamondsPopup(param1:MsgEvent) : void
      {
         GetDiamondsPopUp.Show();
      }
      
      public static function openCampaignPopup(param1:MsgEvent) : void
      {
         PaymentModuleExternalManager.getInstance().openPurchaseGiftCertificate();
      }
      
      private static function openPaymentPopup(param1:MsgEvent) : void
      {
         PaymentManager.getInstance().openSelectPaymentView(param1.data[0],param1.data[1],param1.data[2],param1.data[3]);
      }
      
      private static function openShoppingModuleWithLook(param1:MsgEvent) : void
      {
         var look:LookItem = null;
         var lookFetched:Function = null;
         var movieStarLoaded:Function = null;
         var e:MsgEvent = param1;
         lookFetched = function(param1:LookItem):void
         {
            look = param1;
            var _loc2_:MovieStar = new MovieStar();
            var _loc3_:Object = SerializeUtils.deserialize(look.LookData);
            _loc2_.LoadWithAppearanceData(look.ActorId,_loc3_,movieStarLoaded);
         };
         movieStarLoaded = function(param1:MovieStar):void
         {
            var _loc2_:String = null;
            if(look.ActorId != ActorSession.getActorId())
            {
               if(param1.GetSkinId() != Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.GetSkinId())
               {
                  _loc2_ = "";
                  if(Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.GetSkinId() == 1)
                  {
                     _loc2_ = MSPLocaleManagerWeb.getInstance().getString("GIRL");
                  }
                  else if(Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.GetSkinId() == 2)
                  {
                     _loc2_ = MSPLocaleManagerWeb.getInstance().getString("BOY");
                  }
                  Prompt.show(MSPLocaleManagerWeb.getInstance().getString("CANT_BUY_LOOK",[_loc2_]));
                  return;
               }
               ShoppingModuleManager.getInstance().openClothesShopLook(look);
            }
         };
         var lookId:int = int(e.data as int);
         var lookService:ILookService = new LookAMFService();
         lookService.GetLookById(lookId,lookFetched);
      }
      
      private static function showPurchaseEmoticonPopup(param1:MsgEvent) : void
      {
         EmoticonPurchaseController.OpenEmoticonPurchase(param1.data.emoticonPackage as EmoticonPackage,param1.data.parentContainer);
      }
      
      public function execute() : void
      {
         MessageCommunicator.subscribe(ShopOffersEvent.PAYMENT_OFFERS,openPaymentOffers);
         MessageCommunicator.subscribe(ShopOffersEvent.VIP,openVipPopup);
         MessageCommunicator.subscribe(ShopOffersEvent.STARTCOINS,openStarcoinsPopup);
         MessageCommunicator.subscribe(ShopOffersEvent.DIAMONDS,openDiamondsPopup);
         MessageCommunicator.subscribe(ShopOffersEvent.CAMPAIGN,openCampaignPopup);
         MessageCommunicator.subscribe(ShopOffersEvent.OPEN_PAYMENT_SCREEN,openPaymentPopup);
         MessageCommunicator.subscribe(ShopOffersEvent.OPEN_SHOPPING_MODULE_WITH_LOOK,openShoppingModuleWithLook);
         MessageCommunicator.subscribe(ShopOffersEvent.EMOTICON_PURCHASE_REQUIRED,showPurchaseEmoticonPopup);
      }
   }
}

