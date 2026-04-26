package com.moviestarplanet.parentalconsent.popup
{
   import com.moviestarplanet.Components.BasePopupCanvas;
   import com.moviestarplanet.services.wrappers.UserService;
   import com.moviestarplanet.services.wrappers.parentalconsentwebservice.ParentalConsentWebService;
   import com.moviestarplanet.usersession.service.UserSessionAMFService;
   import com.moviestarplanet.usersession.valueobjects.ActorPersonalInfo;
   import com.moviestarplanet.utils.StringUtilities;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.events.Event;
   import mx.containers.Grid;
   import mx.containers.GridItem;
   import mx.containers.GridRow;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Text;
   
   public class ConfirmParentalConsentPopup extends BasePopupCanvas implements WindowStackableInterface
   {
      
      private var WIDTH:int = 570;
      
      private var consentTitle:String;
      
      private var myChildsUsernameText:String;
      
      private var parentsEmailAddressText:String;
      
      private var messageText:String;
      
      private var legalMessageText:String;
      
      private var buttonTextSend:String;
      
      private var button:Button;
      
      private var ActorId:int;
      
      private var ParentalConsentConfirmCode:String;
      
      private var personalInfo:ActorPersonalInfo;
      
      private var ActorName:String;
      
      public function ConfirmParentalConsentPopup(param1:int, param2:String)
      {
         var actorFetched:Function = null;
         var nameFetched:Function = null;
         var actorId:int = param1;
         var parentalConsentConfirmCode:String = param2;
         this.consentTitle = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_CONFIRMATION");
         this.myChildsUsernameText = MSPLocaleManagerWeb.getInstance().getString("MY_CHILDS_USERNAME");
         this.parentsEmailAddressText = MSPLocaleManagerWeb.getInstance().getString("MY_EMAIL_ADDRESS");
         this.messageText = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_MSG");
         this.legalMessageText = MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_CONFIRM_TERMS");
         this.buttonTextSend = MSPLocaleManagerWeb.getInstance().getString("SEND");
         actorFetched = function(param1:ActorPersonalInfo):void
         {
            if(param1 == null)
            {
               close();
            }
            personalInfo = param1;
            UserSessionAMFService.instance.GetActorNameFromId(ActorId,nameFetched);
         };
         nameFetched = function(param1:String):void
         {
            ActorName = param1;
            minWidth = WIDTH;
            minHeight = 300;
            title = consentTitle;
            var _loc2_:Grid = new Grid();
            _loc2_.setStyle("left",20);
            _loc2_.setStyle("right",20);
            _loc2_.setStyle("top",100);
            _loc2_.setStyle("bottom",20);
            _loc2_.setStyle("borderThickness",0);
            _loc2_.width = WIDTH;
            var _loc3_:GridRow = new GridRow();
            var _loc4_:GridRow = new GridRow();
            var _loc5_:GridRow = new GridRow();
            _loc3_.percentWidth = 100;
            _loc4_.percentWidth = 100;
            _loc5_.percentWidth = 100;
            buildChildUserNameRow(_loc2_);
            buildParentEmailRow(_loc2_);
            var _loc6_:GridItem = new GridItem();
            _loc6_.width = WIDTH;
            _loc6_.colSpan = 2;
            var _loc7_:Label = new Label();
            _loc7_.setStyle("fontSize",14);
            _loc7_.setStyle("fontWeight","bold");
            _loc7_.setStyle("left","30");
            _loc7_.text = messageText;
            _loc6_.addChild(_loc7_);
            _loc3_.addChild(_loc6_);
            _loc2_.addChild(_loc3_);
            var _loc8_:GridItem = new GridItem();
            _loc8_.percentWidth = 100;
            _loc8_.colSpan = 2;
            _loc8_.setStyle("borderStyle","solid");
            var _loc9_:Text = new Text();
            _loc9_.setStyle("fontSize",12);
            _loc9_.setStyle("left","30");
            _loc9_.setStyle("color","0x000000");
            _loc9_.text = StringUtilities.convertBreaksToNewLines(legalMessageText);
            _loc9_.width = WIDTH;
            _loc8_.addChild(_loc9_);
            _loc4_.addChild(_loc8_);
            _loc2_.addChild(_loc4_);
            var _loc10_:GridItem = new GridItem();
            _loc10_.percentWidth = 100;
            _loc10_.colSpan = 2;
            _loc10_.setStyle("horizontalAlign","center");
            button = new Button();
            button.label = buttonTextSend;
            DisplayObjectUtilities.buttonize(button,clickCallback,false);
            button.styleName = "settingsButton";
            _loc10_.addChild(button);
            _loc5_.addChild(_loc10_);
            _loc2_.addChild(_loc5_);
            addChild(_loc2_);
         };
         super();
         titleLabel.setStyle("fontSize",24);
         this.ActorId = actorId;
         this.ParentalConsentConfirmCode = parentalConsentConfirmCode;
         UserService.GetActorPersonalInfo(this.ActorId,actorFetched);
      }
      
      public function clickCallback(param1:Event) : void
      {
         var done:Function = null;
         var e:Event = param1;
         done = function(param1:int):void
         {
            if(param1 == 1)
            {
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_SAVED"),MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_SAVED_TITLE"));
               close();
            }
            else if(param1 == 0)
            {
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("PARENTAL_CONSENT_ALREADY_GIVEN"),MSPLocaleManagerWeb.getInstance().getString("ERROR"));
               close();
            }
            else if(param1 == -1)
            {
            }
         };
         ParentalConsentWebService.GrantParentalConsent(this.ActorId,this.ParentalConsentConfirmCode,done);
      }
      
      public function buildChildUserNameRow(param1:Grid) : void
      {
         var _loc2_:GridRow = new GridRow();
         _loc2_.percentWidth = 100;
         var _loc3_:Label = new Label();
         _loc3_.setStyle("color","0x000000");
         _loc3_.setStyle("fontSize",14);
         _loc3_.setStyle("fontWeight","bold");
         _loc3_.text = this.myChildsUsernameText;
         var _loc4_:Label = new Label();
         _loc4_.setStyle("color","0x000000");
         _loc4_.setStyle("fontSize",14);
         _loc4_.text = this.ActorName;
         var _loc5_:GridItem = new GridItem();
         _loc5_.percentWidth = 30;
         var _loc6_:GridItem = new GridItem();
         _loc6_.percentWidth = 70;
         _loc6_.setStyle("borderStyle","solid");
         _loc6_.setStyle("paddingRight",30);
         _loc5_.addChild(_loc3_);
         _loc6_.addChild(_loc4_);
         _loc2_.addChild(_loc5_);
         _loc2_.addChild(_loc6_);
         param1.addChild(_loc2_);
      }
      
      public function buildParentEmailRow(param1:Grid) : void
      {
         var _loc2_:GridRow = new GridRow();
         _loc2_.percentWidth = 100;
         var _loc3_:Label = new Label();
         _loc3_.setStyle("color","0x000000");
         _loc3_.setStyle("fontSize",14);
         _loc3_.setStyle("fontWeight","bold");
         _loc3_.text = this.parentsEmailAddressText;
         var _loc4_:Label = new Label();
         _loc4_.setStyle("color","0x000000");
         _loc4_.setStyle("fontSize",14);
         _loc4_.text = this.personalInfo.ParentEmail;
         var _loc5_:GridItem = new GridItem();
         var _loc6_:GridItem = new GridItem();
         _loc5_.percentWidth = 30;
         _loc6_.percentWidth = 70;
         _loc6_.setStyle("borderStyle","solid");
         _loc6_.setStyle("paddingRight",30);
         _loc5_.addChild(_loc3_);
         _loc6_.addChild(_loc4_);
         _loc2_.addChild(_loc5_);
         _loc2_.addChild(_loc6_);
         param1.addChild(_loc2_);
      }
   }
}

