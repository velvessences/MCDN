package com.moviestarplanet.parentalconsent.popup
{
   import com.moviestarplanet.Components.BasePopupCanvas;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.parentalconsent.ParentalConsentHandler;
   import com.moviestarplanet.services.wrappers.parentalconsentwebservice.ParentalConsentWebService;
   import com.moviestarplanet.utils.Utils;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.valueObjects.ActorParentalConsent;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.events.Event;
   import mx.containers.Grid;
   import mx.containers.GridItem;
   import mx.containers.GridRow;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.IToolTip;
   import mx.managers.ToolTipManager;
   
   public class EnterParentalCodePopup extends BasePopupCanvas implements WindowStackableInterface
   {
      
      private static var actorParentalConsent:ActorParentalConsent;
      
      private var WIDTH:int = 520;
      
      private var titleText:String;
      
      private var subheadTextMobilePayment:String;
      
      private var pleaseEnterCodeText:String;
      
      private var rememberCodeText:String;
      
      private var alertTextMailSent:String;
      
      private var noCodeEntered:String;
      
      private var wrongCodeEntered:String;
      
      private var buttonSendAgainText:String;
      
      private var buttonConfirmText:String;
      
      private var buttonSendAgain:Button;
      
      private var buttonConfirm:Button;
      
      private var parentalCodeInputField:TextInput;
      
      private var rememberParentalCodeCheckBox:CheckBox;
      
      private var callBack:Function;
      
      private var showingToolTip:Boolean = false;
      
      private var parentalCodeErrorTip:IToolTip = null;
      
      public function EnterParentalCodePopup(param1:int, param2:Function)
      {
         var actorConsentFetched:Function = null;
         var actionCode:int = param1;
         var callBackFunction:Function = param2;
         this.titleText = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_ENTER_CODE_TITLE");
         this.subheadTextMobilePayment = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_MOBILE_PURCHASE_NEED_PARENTAL_CODE");
         this.pleaseEnterCodeText = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_ENTER_PARENTAL_CODE_HERE");
         this.rememberCodeText = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_REMEMBER_PARENTAL_CODE");
         this.alertTextMailSent = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_PARENTAL_CODE_MAIL_SENT");
         this.noCodeEntered = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_PLEASE_TYPE_VALID_CODE");
         this.wrongCodeEntered = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_CODE_INCORRECT");
         this.buttonSendAgainText = MSPLocaleManagerWeb.getInstance().getString("SEND_AGAIN");
         this.buttonConfirmText = MSPLocaleManagerWeb.getInstance().getString("CONFIRM");
         actorConsentFetched = function(param1:ActorParentalConsent):void
         {
            if(param1 == null)
            {
               callBack(false);
               return;
            }
            actorParentalConsent = param1;
            if(param1.ShowParentalConsentCode && param1.ActorId == ActorSession.loggedInActor.ActorId)
            {
               callBack(true);
            }
            else
            {
               loadCanvas(actionCode);
            }
         };
         super();
         this.callBack = callBackFunction;
         ParentalConsentWebService.GetActorParentalConsent(ActorSession.loggedInActor.ActorId,actorConsentFetched);
      }
      
      private function GetSubHeadText(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case ParentalConsentHandler.ACTION_MOBILE_PAYMENT:
               _loc2_ = this.subheadTextMobilePayment;
         }
         return _loc2_;
      }
      
      private function loadCanvas(param1:int) : void
      {
         var _loc5_:GridRow = null;
         minWidth = this.WIDTH;
         minHeight = 300;
         title = this.titleText;
         var _loc2_:Grid = new Grid();
         _loc2_.setStyle("left",20);
         _loc2_.setStyle("right",20);
         _loc2_.setStyle("top",80);
         _loc2_.setStyle("bottom",20);
         _loc2_.setStyle("borderThickness",0);
         _loc2_.width = this.WIDTH;
         var _loc3_:GridRow = new GridRow();
         var _loc4_:GridRow = new GridRow();
         _loc5_ = new GridRow();
         var _loc6_:GridRow = new GridRow();
         var _loc7_:GridRow = new GridRow();
         var _loc8_:GridRow = new GridRow();
         _loc3_.percentWidth = 100;
         _loc4_.percentWidth = 100;
         _loc5_.percentWidth = 100;
         _loc6_.percentWidth = 100;
         _loc7_.percentWidth = 100;
         _loc8_.percentWidth = 100;
         var _loc9_:GridItem = new GridItem();
         _loc9_.width = this.WIDTH;
         _loc9_.colSpan = 2;
         var _loc10_:Text = new Text();
         _loc10_.width = this.WIDTH;
         _loc10_.setStyle("fontSize",14);
         _loc10_.setStyle("left","30");
         _loc10_.setStyle("color","0x000000");
         _loc10_.text = this.GetSubHeadText(param1);
         _loc9_.addChild(_loc10_);
         _loc3_.addChild(_loc9_);
         _loc2_.addChild(_loc3_);
         var _loc11_:GridItem = new GridItem();
         _loc11_.width = this.WIDTH;
         _loc11_.colSpan = 2;
         var _loc12_:Text = new Text();
         _loc12_.setStyle("fontSize",16);
         _loc12_.setStyle("fontWeight","bold");
         _loc12_.setStyle("color","0x000000");
         _loc11_.setStyle("horizontalAlign","center");
         _loc12_.text = ActorSession.loggedInActor.ActorPersonalInfo.ParentEmail;
         _loc11_.addChild(_loc12_);
         _loc4_.addChild(_loc11_);
         _loc2_.addChild(_loc4_);
         var _loc13_:GridItem = new GridItem();
         _loc13_.width = this.WIDTH;
         _loc13_.colSpan = 2;
         var _loc14_:Text = new Text();
         _loc14_.setStyle("fontSize",14);
         _loc14_.setStyle("left","30");
         _loc14_.setStyle("color","0x000000");
         _loc14_.text = this.pleaseEnterCodeText;
         _loc14_.width = this.WIDTH;
         _loc13_.addChild(_loc14_);
         _loc5_.addChild(_loc13_);
         _loc2_.addChild(_loc5_);
         var _loc15_:GridItem = new GridItem();
         _loc15_.width = this.WIDTH;
         _loc15_.colSpan = 2;
         this.parentalCodeInputField = new TextInput();
         this.parentalCodeInputField.width = 300;
         this.parentalCodeInputField.setStyle("backgroundColor","0xffffff");
         this.parentalCodeInputField.setStyle("color","0x000000");
         _loc15_.setStyle("horizontalAlign","center");
         _loc15_.addChild(this.parentalCodeInputField);
         _loc6_.addChild(_loc15_);
         _loc2_.addChild(_loc6_);
         var _loc16_:GridItem = new GridItem();
         _loc16_.width = this.WIDTH;
         _loc16_.colSpan = 2;
         this.rememberParentalCodeCheckBox = new CheckBox();
         this.rememberParentalCodeCheckBox.label = this.rememberCodeText;
         this.rememberParentalCodeCheckBox.setStyle("backgroundColor","0xffffff");
         this.rememberParentalCodeCheckBox.setStyle("color","0x000000");
         this.rememberParentalCodeCheckBox.setStyle("horizontalAlign","center");
         _loc16_.addChild(this.rememberParentalCodeCheckBox);
         _loc7_.addChild(_loc16_);
         _loc2_.addChild(_loc7_);
         var _loc17_:GridItem = new GridItem();
         var _loc18_:GridItem = new GridItem();
         _loc17_.setStyle("horizontalAlign","right");
         _loc17_.setStyle("paddingRight","20");
         _loc17_.horizontalScrollPolicy = "off";
         _loc18_.setStyle("horizontalAlign","left");
         _loc18_.setStyle("paddingLeft","20");
         this.buttonSendAgain = new Button();
         this.buttonConfirm = new Button();
         this.buttonSendAgain.label = this.buttonSendAgainText;
         this.buttonConfirm.label = this.buttonConfirmText;
         DisplayObjectUtilities.buttonize(this.buttonSendAgain,this.sendAgainClickCallback,false);
         DisplayObjectUtilities.buttonize(this.buttonConfirm,this.confirmClickCallback,false);
         this.buttonSendAgain.styleName = "settingsButton";
         this.buttonConfirm.styleName = "settingsButton";
         _loc17_.addChild(this.buttonSendAgain);
         _loc18_.addChild(this.buttonConfirm);
         _loc8_.addChild(_loc17_);
         _loc8_.addChild(_loc18_);
         _loc2_.addChild(_loc8_);
         addChild(_loc2_);
      }
      
      public function sendAgainClickCallback(param1:Event) : void
      {
         ParentalConsentWebService.ReSendParentalConsentCode(ActorSession.loggedInActor.ActorId);
         Prompt.show(this.alertTextMailSent);
      }
      
      public function confirmClickCallback(param1:Event) : void
      {
         if(this.parentalCodeErrorTip != null)
         {
            ToolTipManager.destroyToolTip(this.parentalCodeErrorTip);
            this.showingToolTip = false;
         }
         if(actorParentalConsent == null)
         {
            this.close();
         }
         if(this.parentalCodeInputField.text == null || this.parentalCodeInputField.text == "")
         {
            this.parentalCodeErrorTip = Utils.ShowErrorTip(this.parentalCodeInputField,this.noCodeEntered);
            this.showingToolTip = true;
            return;
         }
         if(this.parentalCodeInputField.text != actorParentalConsent.ParentalConsentCode)
         {
            this.parentalCodeErrorTip = Utils.ShowErrorTip(this.parentalCodeInputField,this.wrongCodeEntered);
            this.showingToolTip = true;
            return;
         }
         if(this.rememberParentalCodeCheckBox.selected)
         {
            ParentalConsentWebService.RememberParentalConsentCode(ActorSession.loggedInActor.ActorId);
         }
         this.callBack(true);
      }
      
      override protected function close(param1:Event = null) : void
      {
         this.callBack(false);
         if(this.parentalCodeErrorTip != null && this.showingToolTip)
         {
            ToolTipManager.destroyToolTip(this.parentalCodeErrorTip);
         }
         super.close(param1);
      }
   }
}

