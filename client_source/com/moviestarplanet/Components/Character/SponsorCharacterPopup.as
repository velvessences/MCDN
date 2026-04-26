package com.moviestarplanet.Components.Character
{
   import com.moviestarplanet.Components.Character.Buttons.FriendButtonSponsorCharacter;
   import com.moviestarplanet.SpecialCharacters.SpCharGraphicsManager;
   import com.moviestarplanet.activityservice.valueObjects.WallPostLink;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.services.wrappers.FriendshipsService;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.utils.linking.WallPostLinking;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import flash.display.DisplayObjectContainer;
   import mx.controls.SWFLoader;
   
   public class SponsorCharacterPopup extends AnchorCharacterPopup
   {
      
      private var fontColorOnNameTextfield:uint = 0;
      
      public function SponsorCharacterPopup(param1:CharacterContainer)
      {
         super(param1);
      }
      
      private function setSponsorLanguage() : void
      {
         var _loc1_:String = Config.overrideLanguage;
         characterPopUpCtrls.GfxCountry.gotoAndStop(_loc1_);
      }
      
      override protected function getColorOfNameTextfield() : uint
      {
         return this.fontColorOnNameTextfield;
      }
      
      override protected function addAskToBeFriendButton() : void
      {
         askToBeFriendButton = new FriendButtonSponsorCharacter(this,characterPopUpCtrls.ButtonAskToBeFriend);
      }
      
      override protected function addRemoveFriendButton() : void
      {
         removeFriendButton = new FriendButtonSponsorCharacter(this,characterPopUpCtrls.RemoveFriend);
      }
      
      override public function update() : void
      {
         setupButtonsForSpecialCharacter();
         askToBeFriendButton.changeStatus(friendShipStatus);
         removeFriendButton.changeStatus(friendShipStatus);
         if(friendShipStatus == FriendshipsService.NOT_FRIENDS)
         {
            askToBeFriendButton.clickDisabled = false;
            askToBeFriendButton.visible = true;
            removeFriendButton.clickDisabled = true;
            removeFriendButton.visible = false;
         }
         else
         {
            askToBeFriendButton.clickDisabled = true;
            askToBeFriendButton.visible = false;
            removeFriendButton.clickDisabled = false;
            removeFriendButton.visible = true;
         }
      }
      
      override protected function loadMovieStar() : void
      {
         SpCharGraphicsManager.loadSponsoredCharacterGraphic(actorId,SpCharGraphicsManager.PROFILE_POPUP_WEB,this.onSponsorCharacterLoaded);
         SpCharGraphicsManager.loadSponsoredCharacterGraphic(actorId,SpCharGraphicsManager.BRAND_LOGO_PROFILE_WEB,this.onSponsorLogoLoaded);
      }
      
      private function onSponsorCharacterLoaded(param1:DisplayObjectContainer) : void
      {
         var _loc2_:String = null;
         var _loc3_:WallPostLink = null;
         characterPopUpCtrls.MovieStar.mouseChildren = false;
         characterPopUpCtrls.MovieStar.removeChildren();
         characterPopUpCtrls.MovieStar.addChild(param1);
         characterPopUpCtrls.MovieStar.visible = true;
         if(actorSummary.AnimationMood != null)
         {
            characterPopUpCtrls.TextWAYD_tlf.senderId = actorId;
            _loc2_ = UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromStrings(actorSummary.AnimationMood.TextLineBlacklisted,actorSummary.AnimationMood.TextLineWhitelisted,actorSummary.AnimationMood.TextLine,actorId);
            if(actorSummary.AnimationMood.WallPostLinks != null && actorSummary.AnimationMood.WallPostLinks.length > 0)
            {
               _loc3_ = actorSummary.AnimationMood.WallPostLinks[0];
               linkHighlighter = WallPostLinking.createLink(_loc3_,_loc2_,characterPopUpCtrls.TextWAYD_tlf);
            }
            else
            {
               characterPopUpCtrls.TextWAYD_tlf.senderId = actorId;
               characterPopUpCtrls.TextWAYD_tlf.emoticonText = _loc2_;
            }
            truncateText(characterPopUpCtrls.TextWAYD_tlf,6);
         }
         else
         {
            characterPopUpCtrls.TextWAYD_tlf.emoticonText = MSPLocaleManagerWeb.getInstance().getString("HAS_NOT_TWIT",[actor.Name]);
         }
      }
      
      private function onSponsorLogoLoaded(param1:DisplayObjectContainer) : void
      {
         param1.mouseChildren = false;
         this.addChild(param1);
      }
      
      override protected function loadDone(param1:SWFLoader) : void
      {
         super.loadDone(param1);
         characterPopUpCtrls.TextName_tlf.text = "";
         this.setSponsorLanguage();
      }
      
      override protected function updateFriendThumbnails() : void
      {
      }
   }
}

