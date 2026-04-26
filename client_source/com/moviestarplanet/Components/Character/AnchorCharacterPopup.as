package com.moviestarplanet.Components.Character
{
   import com.moviestarplanet.Components.Character.Buttons.FriendButtonSponsorCharacter;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.anchorCharacters.valueobjects.AnchorCharacterInfoVO;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.services.wrappers.FriendshipsService;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.tooltips.MSP_ToolTipManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   
   public class AnchorCharacterPopup extends CharacterPopUp
   {
      
      private var fontColorOnNameTextfield:uint = 16777215;
      
      public function AnchorCharacterPopup(param1:CharacterContainer)
      {
         super(param1);
      }
      
      override public function updateFriendShipButton() : void
      {
      }
      
      override public function updateRelationshipText() : void
      {
         var _loc1_:int = AnchorCharacters.getSpecialCharacterInfo(actorId).CharacterType;
         if(_loc1_ == AnchorCharacterInfoVO.TYPE_ANCHOR)
         {
            if(actor.isFemale == ActorSession.loggedInActor.isFemale)
            {
               characterPopUpCtrls.TextYouAreFriends.text = getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_STATUS_FRIENDS"));
            }
            else
            {
               characterPopUpCtrls.TextYouAreFriends.text = getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_STATUS_NOTFRIENDS"));
            }
         }
         else
         {
            super.updateRelationshipText();
         }
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
         this.setupButtonsForSpecialCharacter();
      }
      
      protected function setupButtonsForSpecialCharacter() : void
      {
         myProfileButton.clickDisabled = false;
         myRoomButton.clickDisabled = false;
         characterPopUpCtrls.ActionReportBlock.visible = false;
         characterPopUpCtrls.TextLevelt.visible = false;
         showButtons(false);
         var _loc1_:int = AnchorCharacters.getSpecialCharacterInfo(actorId).CharacterType;
         if(_loc1_ != AnchorCharacterInfoVO.TYPE_ANCHOR)
         {
            removeFriendButton.visible = friendShipStatus == FriendshipsService.FRIENDS;
            askToBeFriendButton.visible = !removeFriendButton.visible;
         }
         judgeButton.clickDisabled = false;
         celebButton.clickDisabled = false;
         var _loc2_:TextFormat = characterPopUpCtrls.TextName_tlf.defaultTextFormat;
         _loc2_.color = this.getColorOfNameTextfield();
         characterPopUpCtrls.TextName_tlf.setTextFormat(_loc2_);
      }
      
      protected function getColorOfNameTextfield() : uint
      {
         return this.fontColorOnNameTextfield;
      }
      
      override protected function addVipBadge() : void
      {
      }
      
      override protected function loadMovieStar() : void
      {
         var _loc1_:MovieStarCharacter = new MovieStarCharacter();
         _loc1_.Load(actor.ActorId,movieStarLoaded,1,false,true,false,true);
      }
      
      override protected function updateFriendThumbnails() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         clearFriendThumbnails();
         var _loc1_:int = AnchorCharacters.getSpecialCharacterInfo(actorId).CharacterType;
         var _loc2_:AnchorCharacterInfoVO = AnchorCharacters.getSpecialCharacterInfo(AnchorCharacters.GOSSIP_GIRL);
         if(_loc1_ == AnchorCharacterInfoVO.TYPE_ANCHOR)
         {
            _loc3_ = characterPopUpCtrls["Bestfriend1"].getChildByName("BestfriendImage1") as MovieClip;
            numBestFriends = 1;
            FlashInstanceUtils.loadContentForInstance(new SnapshotUrl(AnchorCharacters.getIdOfBestFriend(actorId),EntityTypeType.MOVIESTAR,"moviestar"),_loc3_,null);
            _loc3_.visible = true;
            _loc4_ = AnchorCharacters.getIdOfBestFriend(actorId);
            DisplayObjectUtilities.buttonize(characterPopUpCtrls["Bestfriend1"],onFriendClickedClosure(_loc4_),true,false);
            MSP_ToolTipManager.add(characterPopUpCtrls["Bestfriend1"],AnchorCharacters.getNameForId(_loc4_));
            if(_loc2_ != null)
            {
               _loc4_ = AnchorCharacters.GOSSIP_GIRL;
               _loc3_ = characterPopUpCtrls["Bestfriend2"].getChildByName("BestfriendImage2") as MovieClip;
               numBestFriends = 2;
               FlashInstanceUtils.loadContentForInstance(new SnapshotUrl(_loc4_,EntityTypeType.MOVIESTAR,"moviestar"),_loc3_,null);
               _loc3_.visible = true;
               DisplayObjectUtilities.buttonize(characterPopUpCtrls["Bestfriend2"],onFriendClickedClosure(_loc4_),true,false);
               MSP_ToolTipManager.add(characterPopUpCtrls["Bestfriend2"],_loc2_.Name);
            }
         }
         else if(actorId == AnchorCharacters.GOSSIP_GIRL && _loc2_ != null)
         {
            _loc3_ = characterPopUpCtrls["Bestfriend1"].getChildByName("BestfriendImage1") as MovieClip;
            numBestFriends = 2;
            FlashInstanceUtils.loadContentForInstance(new SnapshotUrl(AnchorCharacters.FEMALE_ANCHOR,EntityTypeType.MOVIESTAR,"moviestar"),_loc3_,null);
            _loc3_.visible = true;
            DisplayObjectUtilities.buttonize(characterPopUpCtrls["Bestfriend1"],onFriendClickedClosure(AnchorCharacters.FEMALE_ANCHOR),true,false);
            MSP_ToolTipManager.add(characterPopUpCtrls["Bestfriend1"],AnchorCharacters.getNameForId(AnchorCharacters.FEMALE_ANCHOR));
            _loc3_ = characterPopUpCtrls["Bestfriend2"].getChildByName("BestfriendImage2") as MovieClip;
            FlashInstanceUtils.loadContentForInstance(new SnapshotUrl(AnchorCharacters.MALE_ANCHOR,EntityTypeType.MOVIESTAR,"moviestar"),_loc3_,null);
            _loc3_.visible = true;
            DisplayObjectUtilities.buttonize(characterPopUpCtrls["Bestfriend2"],onFriendClickedClosure(AnchorCharacters.MALE_ANCHOR),true,false);
            MSP_ToolTipManager.add(characterPopUpCtrls["Bestfriend2"],AnchorCharacters.getNameForId(AnchorCharacters.MALE_ANCHOR));
         }
      }
   }
}

