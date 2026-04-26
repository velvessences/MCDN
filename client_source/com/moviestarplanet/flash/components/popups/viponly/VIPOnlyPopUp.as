package com.moviestarplanet.flash.components.popups.viponly
{
   import com.moviestarplanet.flash.icons.ScreenIcons;
   import com.moviestarplanet.payment.PaymentModuleExternalManager;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.translation.TranslationUtilities;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import com.moviestarplanet.window.stack.WindowStack;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.registerClassAlias;
   import flash.system.ApplicationDomain;
   import mx.controls.SWFLoader;
   
   public class VIPOnlyPopUp extends Sprite
   {
      
      private static const POSITION_X:int = 400;
      
      private static const POSITION_Y:int = 200;
      
      private var vipOnlyPopUpCtrls:VIPOnlyPopUpCtrls;
      
      private var message:String;
      
      private const SWF_URL:String = "swf/popups/VIPOnly.swf";
      
      private var closebtn:MovieClip;
      
      public function VIPOnlyPopUp(param1:String)
      {
         super();
         this.message = param1;
         registerClassAlias("VIPOnlyPopUpCtrl",VIPOnlyPopUpCtrls);
         FlashInstanceUtils.loadFlashInstance(ApplicationDomain.currentDomain,new RawUrl(this.SWF_URL),this.loadDone);
      }
      
      public static function Show(param1:String, param2:int = 9) : void
      {
         var _loc3_:VIPOnlyPopUp = new VIPOnlyPopUp(param1);
         WindowStack.showSpriteAsViewStackable(_loc3_,POSITION_X,POSITION_Y,param2);
      }
      
      private function loadDone(param1:SWFLoader) : void
      {
         this.addContents(param1.content);
         this.initLabels();
         this.initButtons();
      }
      
      private function addContents(param1:Object) : void
      {
         TranslationUtilities.translateDisplayObject(param1 as DisplayObject,true);
         this.vipOnlyPopUpCtrls = param1.VIPOnly as VIPOnlyPopUpCtrls;
         addChild(this.vipOnlyPopUpCtrls);
      }
      
      private function initLabels() : void
      {
         this.vipOnlyPopUpCtrls.text.text = this.message;
      }
      
      private function initButtons() : void
      {
         DisplayObjectUtilities.buttonize(this.vipOnlyPopUpCtrls.Button,this.clickButtonBecomeVIP);
         this.closebtn = new ScreenIcons.CloseIcon();
         this.vipOnlyPopUpCtrls.ButtonClose.addChild(this.closebtn);
         DisplayObjectUtilities.buttonizeFrames(this.closebtn,this.clickButtonClose);
      }
      
      private function clickButtonBecomeVIP(param1:MouseEvent) : void
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
         DisplayObjectUtilities.unbuttonizeFrames(this.closebtn,this.clickButtonClose);
         WindowStack.removeSpriteViewStackable(this);
      }
   }
}

