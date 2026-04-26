package com.moviestarplanet.flash.components.popups
{
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.flash.components.buttons.ButtonWithFrames;
   import com.moviestarplanet.flash.icons.ScreenIcons;
   import com.moviestarplanet.payment.PaymentModuleExternalManager;
   import com.moviestarplanet.utils.displayobject.FlattenUtilities;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.windowpopup.popup.BaseSwfPopup;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class GetStarCoinsPopup extends BaseSwfPopup
   {
      
      private var closeBtn:MovieClip;
      
      public function GetStarCoinsPopup()
      {
         super("swf/popups/GetStarCoinsPopUp.swf");
      }
      
      override protected function loadDone(param1:MSP_FlashLoader) : void
      {
         super.loadDone(param1);
         var _loc2_:MovieClip = content as MovieClip;
         FlattenUtilities.flattenSprite(_loc2_.GetStarCoins.Background);
         new ButtonWithFrames(_loc2_.GetStarCoins.Button,this.buyMoreStarCoins,true);
         this.closeBtn = new ScreenIcons.CloseIcon();
         this.closeBtn.x = 550;
         this.closeBtn.y = 5;
         addChild(this.closeBtn);
         Buttonizer.buttonizeFrames(this.closeBtn,this.closeClicked);
      }
      
      private function closeClicked(param1:Event) : void
      {
         Buttonizer.unbuttonizeFrames(this.closeBtn,this.closeClicked);
         close();
      }
      
      private function buyMoreStarCoins(param1:MouseEvent) : void
      {
         close();
         PaymentModuleExternalManager.getInstance().openPurchaseFlow();
      }
   }
}

