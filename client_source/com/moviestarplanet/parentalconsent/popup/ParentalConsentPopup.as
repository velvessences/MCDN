package com.moviestarplanet.parentalconsent.popup
{
   import com.moviestarplanet.Components.BasePopupCanvas;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.services.wrappers.parentalconsentwebservice.ParentalConsentWebService;
   import com.moviestarplanet.usersession.service.UserSessionAMFService;
   import com.moviestarplanet.usersession.valueobjects.ActorEmail;
   import com.moviestarplanet.utils.Utils;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.containers.Grid;
   import mx.containers.GridItem;
   import mx.containers.GridRow;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.IToolTip;
   import mx.managers.ToolTipManager;
   
   public class ParentalConsentPopup extends BasePopupCanvas implements WindowStackableInterface
   {
      
      private var STATE_NO_PARENT_EMAIL:int = 0;
      
      private var STATE_PARENT_EMAIL_NOT_SENT:int = 1;
      
      private var STATE_PARENT_EMAIL_SENT:int = 2;
      
      private var WIDTH:int = 550;
      
      private var actorUserState:int = -1;
      
      private var consentTitle:String = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_REQUIRED");
      
      private var subheadtext:String = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_REQUIRED_FOR_PII_COLLECT");
      
      private var subheadAddendumKnowParentEmail:String = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_EMAIL_WITH_INSTRUCTIONS_SENT");
      
      private var subheadAddendumDontKnowParentsEmail:String = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_ENTER_PARENT_EMAIL");
      
      private var subheadAddendumAlreadySentEmail:String = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_HAVE_PREVIOUS_SENT_EMAIL");
      
      private var subheadAddendumComeBack:String = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_COME_BACK_TRY_AGAIN");
      
      private var subheadAddendumComeBackSendEmail:String = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_CLICK_TO_SEND_MAIL");
      
      private var parentsEmailLabeltext:String = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_PARENTS_EMAIL");
      
      private var pleaseTypeEmailErrorText:String = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_INVALID_EMAIL_ERROR");
      
      private var emailSameAsActorsErrorText:String = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_SAME_EMAIL_AS_ACTOR_ERROR");
      
      private var buttonTextSend:String = MSPLocaleManagerWeb.getInstance().getString("SEND");
      
      private var buttonTextOk:String = MSPLocaleManagerWeb.getInstance().getString("OK");
      
      private var buttonTextSendAgain:String = MSPLocaleManagerWeb.getInstance().getString("SEND_MAIL_AGAIN");
      
      private var button:Button;
      
      private var parentEmailErrorTip:IToolTip = null;
      
      private var parentEmailInputField:TextInput;
      
      private var showingToolTip:Boolean = false;
      
      public function ParentalConsentPopup()
      {
         super();
         minWidth = this.WIDTH;
         minHeight = 300;
         title = this.consentTitle;
         var _loc1_:Grid = new Grid();
         _loc1_.setStyle("left",20);
         _loc1_.setStyle("right",20);
         _loc1_.setStyle("top",60);
         _loc1_.setStyle("borderThickness",1);
         _loc1_.width = this.WIDTH;
         this.addTextArea(this.subheadtext,_loc1_);
         this.actorUserState = this.getState();
         switch(this.actorUserState)
         {
            case this.STATE_NO_PARENT_EMAIL:
               this.addTextArea(this.subheadAddendumDontKnowParentsEmail,_loc1_);
               this.addTextField(_loc1_);
               this.addTextArea(this.subheadAddendumComeBack,_loc1_);
               this.addButton(this.buttonTextSend,this.saveParentEmailAndSendConsentMail);
               break;
            case this.STATE_PARENT_EMAIL_NOT_SENT:
               ParentalConsentWebService.RequestParentalConsent(ActorSession.loggedInActor.ActorId);
               ActorSession.loggedInActor.ActorPersonalInfo.ParentConsentEmailSent = true;
               this.addTextArea(this.subheadAddendumKnowParentEmail,_loc1_);
               this.showParentEmail(_loc1_);
               this.addTextArea(this.subheadAddendumComeBack,_loc1_);
               this.addButton(this.buttonTextOk,this.closeWindow);
               break;
            case this.STATE_PARENT_EMAIL_SENT:
               this.addTextArea(this.subheadAddendumAlreadySentEmail,_loc1_);
               this.showParentEmail(_loc1_);
               this.addTextArea(this.subheadAddendumComeBack + " " + this.subheadAddendumComeBackSendEmail,_loc1_);
               this.addButton(this.buttonTextSendAgain,this.sendConsentMail);
         }
         addChild(_loc1_);
      }
      
      public function showParentEmail(param1:Grid) : void
      {
         var _loc2_:GridRow = new GridRow();
         _loc2_.width = this.WIDTH;
         var _loc3_:GridItem = new GridItem();
         _loc3_.width = this.WIDTH;
         var _loc4_:String = ActorSession.loggedInActor.ActorPersonalInfo.ParentEmail;
         var _loc5_:Text = new Text();
         _loc5_.text = _loc4_;
         _loc5_.setStyle("borderThickness",0);
         _loc5_.setStyle("backgroundAlpha",0);
         _loc5_.setStyle("color","0x000000");
         _loc5_.setStyle("fontSize",18);
         _loc5_.setStyle("fontWeight","bold");
         _loc5_.setStyle("paddingTop",10);
         _loc5_.setStyle("paddingBottom",10);
         _loc5_.percentWidth = 100;
         _loc3_.addChild(_loc5_);
         _loc2_.addChild(_loc3_);
         param1.addChild(_loc2_);
      }
      
      private function addButton(param1:String, param2:Function) : void
      {
         this.button = new Button();
         this.button.label = param1;
         this.button.setStyle("horizontalCenter",width / 2);
         this.button.setStyle("bottom",20);
         this.button.setStyle("fontSize",22);
         this.button.addEventListener(MouseEvent.CLICK,param2);
         addChild(this.button);
      }
      
      private function addTextArea(param1:String, param2:Grid) : void
      {
         var _loc3_:GridRow = new GridRow();
         _loc3_.width = this.WIDTH;
         var _loc4_:GridItem = new GridItem();
         _loc4_.width = this.WIDTH;
         var _loc5_:Text = new Text();
         _loc5_.htmlText = param1;
         _loc5_.setStyle("borderThickness",0);
         _loc5_.setStyle("backgroundAlpha",0);
         _loc5_.setStyle("color","0x000000");
         _loc5_.percentWidth = 100;
         _loc4_.addChild(_loc5_);
         _loc3_.addChild(_loc4_);
         param2.addChild(_loc3_);
      }
      
      private function addTextField(param1:Grid) : void
      {
         var _loc4_:Grid = null;
         var _loc2_:GridRow = new GridRow();
         _loc2_.width = this.WIDTH;
         var _loc3_:GridItem = new GridItem();
         _loc3_.width = this.WIDTH;
         _loc4_ = new Grid();
         _loc4_.setStyle("left",20);
         _loc4_.setStyle("right",20);
         _loc4_.setStyle("paddingTop",20);
         _loc4_.setStyle("paddingBottom",20);
         var _loc5_:GridRow = new GridRow();
         _loc5_.percentWidth = 100;
         var _loc6_:Label = new Label();
         _loc6_.setStyle("color","0x000000");
         _loc6_.setStyle("fontSize",14);
         _loc6_.setStyle("fontWeight","bold");
         _loc6_.text = this.parentsEmailLabeltext;
         this.parentEmailInputField = new TextInput();
         this.parentEmailInputField.width = 240;
         this.parentEmailInputField.setStyle("backgroundColor","0xffffff");
         this.parentEmailInputField.setStyle("color","0x000000");
         var _loc7_:GridItem = new GridItem();
         var _loc8_:GridItem = new GridItem();
         _loc8_.setStyle("paddingRight",30);
         _loc7_.addChild(_loc6_);
         _loc8_.addChild(this.parentEmailInputField);
         _loc5_.addChild(_loc7_);
         _loc5_.addChild(_loc8_);
         _loc4_.addChild(_loc5_);
         _loc3_.addChild(_loc4_);
         _loc2_.addChild(_loc3_);
         param1.addChild(_loc2_);
      }
      
      public function getState() : int
      {
         var _loc1_:String = ActorSession.loggedInActor.ActorPersonalInfo.ParentEmail;
         if(_loc1_ == null || _loc1_.length == 0)
         {
            return this.STATE_NO_PARENT_EMAIL;
         }
         if(ActorSession.loggedInActor.ActorPersonalInfo.ParentConsentEmailSent)
         {
            return this.STATE_PARENT_EMAIL_SENT;
         }
         return this.STATE_PARENT_EMAIL_NOT_SENT;
      }
      
      public function saveParentEmailAndSendConsentMail(param1:Event) : void
      {
         var emailRegExp:RegExp;
         var actorEmailLoaded:Function = null;
         var MSPEvent:Event = param1;
         actorEmailLoaded = function(param1:ActorEmail):void
         {
            var done:Function;
            var parentEmail:String = null;
            var email:ActorEmail = param1;
            parentEmail = parentEmailInputField.text;
            if(email.Email == parentEmail)
            {
               parentEmailErrorTip = Utils.ShowErrorTip(parentEmailInputField,emailSameAsActorsErrorText);
               showingToolTip = true;
            }
            else
            {
               done = function(param1:Boolean):void
               {
                  if(!param1)
                  {
                     return;
                  }
                  ParentalConsentWebService.RequestParentalConsent(ActorSession.loggedInActor.ActorId);
                  ActorSession.loggedInActor.ActorPersonalInfo.ParentEmail = parentEmail;
                  ActorSession.loggedInActor.ActorPersonalInfo.ParentConsentEmailSent = true;
                  close();
               };
               ParentalConsentWebService.SaveParentEmailAddress(ActorSession.loggedInActor.ActorId,parentEmail,done);
            }
         };
         if(this.parentEmailErrorTip != null)
         {
            ToolTipManager.destroyToolTip(this.parentEmailErrorTip);
            this.showingToolTip = false;
         }
         emailRegExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/i;
         if(this.parentEmailInputField.text == null || this.parentEmailInputField.text == "" || !emailRegExp.test(this.parentEmailInputField.text))
         {
            this.parentEmailErrorTip = Utils.ShowErrorTip(this.parentEmailInputField,this.pleaseTypeEmailErrorText);
            this.showingToolTip = true;
            return;
         }
         UserSessionAMFService.instance.loadActorEmail(ActorSession.loggedInActor.ActorId,actorEmailLoaded);
      }
      
      public function sendConsentMail(param1:Event) : void
      {
         ParentalConsentWebService.RequestParentalConsent(ActorSession.loggedInActor.ActorId);
         this.close();
      }
      
      public function closeWindow(param1:Event) : void
      {
         this.close();
      }
      
      override protected function close(param1:Event = null) : void
      {
         if(this.parentEmailErrorTip != null && this.showingToolTip)
         {
            ToolTipManager.destroyToolTip(this.parentEmailErrorTip);
         }
         super.close(param1);
      }
   }
}

