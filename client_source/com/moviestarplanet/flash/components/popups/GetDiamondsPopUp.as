package com.moviestarplanet.flash.components.popups
{
   import com.moviestarplanet.controls.buttons.CloseButton;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.payment.PaymentModuleExternalManager;
   import com.moviestarplanet.utils.ComponentUtilities;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.sound.Sounds;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.utils.translation.TranslationUtilities;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import com.moviestarplanet.window.stack.WindowStack;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import mx.controls.SWFLoader;
   
   public class GetDiamondsPopUp extends Sprite
   {
      
      private static const POSITION_X:int = 400;
      
      private static const POSITION_Y:int = 200;
      
      private static var defaultText:String = MSPLocaleManagerWeb.getInstance().getString("DIAMONDS_GETNOW_GENERICTEXT");
      
      private var message:String;
      
      private const SWF_URL:String = "swf/popups/GetDiamonds.swf";
      
      public function GetDiamondsPopUp(param1:String)
      {
         super();
         this.message = param1;
         FlashInstanceUtils.loadFlashInstance(ApplicationDomain.currentDomain,new RawUrl(this.SWF_URL),this.loadDone);
      }
      
      public static function Show(param1:String = null) : void
      {
         if(!param1)
         {
            param1 = defaultText;
         }
         var _loc2_:GetDiamondsPopUp = new GetDiamondsPopUp(param1);
         WindowStack.showSpriteAsViewStackable(_loc2_,POSITION_X,POSITION_Y,WindowStack.Z_INFO);
         SoundManager.Instance().playSoundEffect(Sounds.DIAMONDS_GET_DIAMONDS_POPUP);
      }
      
      private function loadDone(param1:SWFLoader) : void
      {
         TranslationUtilities.translateDisplayObject(param1.content,true);
         var _loc2_:TextField = ComponentUtilities.findInstanceBFS("Text",param1.content) as TextField;
         _loc2_.text = this.message;
         var _loc3_:MovieClip = ComponentUtilities.findInstanceBFS("BuyButton",param1.content) as MovieClip;
         var _loc4_:DisplayObjectContainer = ComponentUtilities.findInstanceBFS("CloseButton",param1.content) as DisplayObjectContainer;
         var _loc5_:CloseButton = new CloseButton();
         _loc5_.addEventListener(MouseEvent.CLICK,this.clickButtonClose);
         _loc5_.width = _loc4_.width;
         _loc5_.height = _loc4_.height;
         _loc4_.addChild(_loc5_);
         DisplayObjectUtilities.buttonizeFrames(_loc3_,this.buyButtonClicked);
         addChild(param1.content);
      }
      
      private function buyButtonClicked(param1:MouseEvent) : void
      {
         this.close();
         PaymentModuleExternalManager.getInstance().openPurchaseFlow();
      }
      
      private function clickButtonClose(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function close() : void
      {
         WindowStack.removeSpriteViewStackable(this);
      }
   }
}

