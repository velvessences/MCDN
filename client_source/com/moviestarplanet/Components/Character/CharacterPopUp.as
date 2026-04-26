package com.moviestarplanet.Components.Character
{
   import com.moviestarplanet.Components.Character.Buttons.AdminButton;
   import com.moviestarplanet.Components.Character.Buttons.AdminDeleteButton;
   import com.moviestarplanet.Components.Character.Buttons.BaseButton;
   import com.moviestarplanet.Components.Character.Buttons.BestFriendButton;
   import com.moviestarplanet.Components.Character.Buttons.BoyfriendButton;
   import com.moviestarplanet.Components.Character.Buttons.CelebButton;
   import com.moviestarplanet.Components.Character.Buttons.ChangeClothesButton;
   import com.moviestarplanet.Components.Character.Buttons.FriendButton;
   import com.moviestarplanet.Components.Character.Buttons.GiveAutographButton;
   import com.moviestarplanet.Components.Character.Buttons.GiveGiftButton;
   import com.moviestarplanet.Components.Character.Buttons.JudgeButton;
   import com.moviestarplanet.Components.Character.Buttons.JuryButton;
   import com.moviestarplanet.Components.Character.Buttons.MyProfileButton;
   import com.moviestarplanet.Components.Character.Buttons.MyRoomButton;
   import com.moviestarplanet.Components.Character.Buttons.ReportBlockButton;
   import com.moviestarplanet.Components.Character.Buttons.SendMessageButton;
   import com.moviestarplanet.Components.Character.Buttons.TradeButton;
   import com.moviestarplanet.Components.Character.Buttons.VIPButton;
   import com.moviestarplanet.Components.Friends.BestFriendSelectionArgs;
   import com.moviestarplanet.Components.Friends.FriendshipContainer;
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.activityservice.valueObjects.Todo;
   import com.moviestarplanet.activityservice.valueObjects.WallPostLink;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.clientcensor.textfield.MSP_EmoticonTextFlowArea;
   import com.moviestarplanet.constants.friendship.ConstantsRelationshipStatus;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.icons.ScreenIcons;
   import com.moviestarplanet.friends.FriendsManager;
   import com.moviestarplanet.friendship.service.FriendshipServiceWeb;
   import com.moviestarplanet.friendship.valueobjects.ActorRelationshipType;
   import com.moviestarplanet.friendship.valueobjects.ActorSpecialRelationshipStatus;
   import com.moviestarplanet.friendship.valueobjects.ActorSpecialSummary;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.level.configuration.ILevelConfiguration;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.membership.renderer.MembershipGraphicUtils;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.model.friends.ConstantsFriendshipStatus;
   import com.moviestarplanet.model.friends.ConstantsFriendshipType;
   import com.moviestarplanet.moviestar.utils.ActorCache;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.msg.FriendActivityEvent;
   import com.moviestarplanet.msg.MSP_Event;
   import com.moviestarplanet.msg.MovieStarPopupEvent;
   import com.moviestarplanet.safety.MovieStarSafetySticker;
   import com.moviestarplanet.services.wrappers.FriendshipsService;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.usersession.valueobjects.ActorDetails;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.MSPTextFieldUtils;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.displayobject.FlattenUtilities;
   import com.moviestarplanet.utils.linking.WallPostLinkHighlighter;
   import com.moviestarplanet.utils.linking.WallPostLinking;
   import com.moviestarplanet.utils.loader.RawUrl;
   import com.moviestarplanet.utils.tooltips.MSP_ToolTipManager;
   import com.moviestarplanet.utils.translation.Localizer;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.utils.translation.TranslationUtilities;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import com.moviestarplanet.valueObjects.MySpecialFriend;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.registerClassAlias;
   import flash.system.ApplicationDomain;
   import mx.controls.SWFLoader;
   import mx.events.PropertyChangeEvent;
   
   public class CharacterPopUp extends Sprite
   {
      
      private static const MASK_START_X:Number = 214;
      
      private static const MASK_START_Y:Number = 88;
      
      private static const MASK_TOP_LEFT:Point = new Point(30,88);
      
      private static const MASK_BOTTOM_RIGHT:Point = new Point(214,320);
      
      [Inject]
      public var levelConfiguration:ILevelConfiguration;
      
      private var mspLocaleManager:ILocaleManager;
      
      public var characterPopUpCtrls:CharacterPopUpCtrls;
      
      private var _actorDetails:ActorDetails;
      
      private var _actor:Actor;
      
      private var _actorId:int;
      
      private var parentContainer:CharacterContainer;
      
      protected var numBestFriends:int;
      
      private var bestFriendSelections:Vector.<BestFriendSelectionArgs>;
      
      public var _content:DisplayObject;
      
      private var _hasActorChanged:Boolean = false;
      
      private var _friendShipStatus:String = null;
      
      protected var askToBeFriendButton:FriendButton;
      
      protected var askToBeBestFriendButton:BestFriendButton;
      
      protected var askToBeBoyfriendButton:BoyfriendButton;
      
      private var cancelFriendRequest:FriendButton;
      
      private var cancelBestfriendRequest:BestFriendButton;
      
      private var cancelBoyfriendRequest:BoyfriendButton;
      
      protected var removeFriendButton:FriendButton;
      
      protected var removeBestFriendButton:BestFriendButton;
      
      protected var removeBoyfriendButton:BoyfriendButton;
      
      private var vipButton:VIPButton;
      
      private var vipButtonGrahic:MovieClip;
      
      protected var judgeButton:JudgeButton;
      
      protected var juryButton:JuryButton;
      
      protected var celebButton:CelebButton;
      
      private var sendMessageButton:SendMessageButton;
      
      private var tradeButton:TradeButton;
      
      private var reportBlockButton:ReportBlockButton;
      
      private var giveGiftButton:GiveGiftButton;
      
      private var giveAutographButton:GiveAutographButton;
      
      protected var myProfileButton:MyProfileButton;
      
      protected var myRoomButton:MyRoomButton;
      
      public var changeClothesButton:ChangeClothesButton;
      
      private var adminButton:AdminButton;
      
      private var adminDeleteButton:AdminDeleteButton;
      
      private var closeButton:MovieClip;
      
      protected var actorSummary:ActorSpecialSummary;
      
      private var petMovieStar:MovieStarCharacter;
      
      protected var linkHighlighter:WallPostLinkHighlighter;
      
      private var isTodosVisible:Boolean = false;
      
      private var isVIP:Boolean = false;
      
      private var isMyProfile:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      private var mouseoverMask:MovieClip;
      
      private var isMaskAdded:Boolean = false;
      
      private var mFlattenList:Vector.<Sprite>;
      
      private var _movieStar:MovieStarCharacter;
      
      private var moderatorSticker:MovieStarSafetySticker;
      
      public function CharacterPopUp(param1:CharacterContainer)
      {
         super();
         this.parentContainer = param1;
         this.mspLocaleManager = MSPLocaleManagerWeb.getInstance();
         InjectionManager.manager().injectMe(this);
      }
      
      private function get isShown() : Boolean
      {
         return parent != null;
      }
      
      public function get friendShipStatus() : String
      {
         return this._friendShipStatus;
      }
      
      public function set friendShipStatus(param1:String) : void
      {
         var _loc2_:Boolean = false;
         if(this._friendShipStatus == null)
         {
            _loc2_ = true;
         }
         this._friendShipStatus = param1;
         this.updateFriendShipButton();
         this.updateRelationshipText();
         if(this._friendShipStatus == FriendshipsService.NOT_FRIENDS)
         {
            this.askToBeBestFriendButton.visible = true;
            this.removeBestFriendButton.visible = false;
         }
         if(_loc2_ == true)
         {
            MessageCommunicator.send(new MovieStarPopupEvent(MovieStarPopupEvent.FRIENDSHIP_STATUS_UPDATED,this));
         }
         MessageCommunicator.send(new MovieStarPopupEvent(MovieStarPopupEvent.FRIENDSHIP_STATUS_LOADED,this));
      }
      
      private function setSpecialRelationshipButtonsEnabled() : void
      {
         var _loc1_:Boolean = this.friendShipStatus == FriendshipsService.FRIENDS;
         var _loc2_:ActorDetails = ActorSession.loggedInActor;
         var _loc3_:int = _loc2_.GetBestFriendStatus(this.actorId);
         var _loc4_:int = _loc2_.GetBoyfriendStatusById(this.actorId);
         if(!_loc1_ || _loc4_ == ActorSpecialRelationshipStatus.WAITINGFORANSWER || !_loc2_.canFriendActor(this._actor.Moderator))
         {
            this.askToBeBestFriendButton.clickDisabled = true;
         }
         else
         {
            this.askToBeBestFriendButton.clickDisabled = false;
         }
         if(!_loc1_ || _loc3_ == ActorSpecialRelationshipStatus.WAITINGFORANSWER || !_loc2_.canFriendActor(this._actor.Moderator))
         {
            this.askToBeBoyfriendButton.clickDisabled = true;
         }
         else
         {
            this.askToBeBoyfriendButton.clickDisabled = false;
         }
      }
      
      public function get actor() : Actor
      {
         return this._actor;
      }
      
      public function set actor(param1:Actor) : void
      {
         this._actor = param1;
      }
      
      public function set vipTier(param1:int) : void
      {
         this.actor.VipTier = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get actorDetails() : ActorDetails
      {
         return this._actorDetails;
      }
      
      private function set _2081141389actorDetails(param1:ActorDetails) : void
      {
         if(this._actorDetails != param1)
         {
            this._actorDetails = param1;
         }
      }
      
      public function get actorId() : int
      {
         return this._actorId;
      }
      
      public function set actorId(param1:int) : void
      {
         this._actorId = param1;
         ActorCache.loadActor(this.actorId,this.loadActorDone);
      }
      
      private function get content() : DisplayObject
      {
         return this._content;
      }
      
      private function set content(param1:DisplayObject) : void
      {
         if(this._content != null && Boolean(this.contains(this._content)))
         {
            removeChild(this._content);
         }
         this._content = param1;
         addChild(this._content);
      }
      
      public function isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      private function loadActorDone(param1:Actor) : void
      {
         this.actor = param1;
         this.isMyProfile = ActorSession.loggedInActor.ActorId == param1.ActorId;
         this.isVIP = this.actor.isVip;
         var _loc2_:String = CharacterPopUpStyleSelector.getPopUpStylePath(this.actor,this.isVIP);
         this.loadSwf(_loc2_);
      }
      
      public function loadSwf(param1:String) : void
      {
         registerClassAlias("CharacterPopUp",CharacterPopUpCtrls);
         FlashInstanceUtils.loadFlashInstance(ApplicationDomain.currentDomain,new RawUrl(param1),this.loadDone);
      }
      
      protected function loadDone(param1:SWFLoader) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Sprite = null;
         var _loc5_:Number = NaN;
         var _loc3_:Object = param1.content;
         TranslationUtilities.translateDisplayObject(param1.content,true);
         if(_loc3_.CharacterPopUp == null)
         {
            return;
         }
         this.characterPopUpCtrls = _loc3_.CharacterPopUp as CharacterPopUpCtrls;
         addChild(this.characterPopUpCtrls);
         this.localize();
         this.characterPopUpCtrls.TextSelfView.visible = false;
         this.characterPopUpCtrls.ButtonMyClothing.visible = false;
         this.characterPopUpCtrls.ButtonMyProfileSelfView.visible = false;
         this.characterPopUpCtrls.ButtonMyRoomSelfView.visible = false;
         this.characterPopUpCtrls.ButtonAskToBeFriend.visible = false;
         this.characterPopUpCtrls.ButtonAskToBeBestFriend.visible = false;
         this.characterPopUpCtrls.ButtonAskToBeBoyfriend.visible = false;
         this.characterPopUpCtrls.RemoveFriend.visible = false;
         this.characterPopUpCtrls.RemoveBestFriend.visible = false;
         this.characterPopUpCtrls.RemoveBoyfriend.visible = false;
         this.characterPopUpCtrls.BadgeCeleb.visible = false;
         this.characterPopUpCtrls.BadgeJury.visible = false;
         this.characterPopUpCtrls.BadgeJudge.visible = false;
         this.characterPopUpCtrls.ButtonAdmin.visible = false;
         this.characterPopUpCtrls.ButtonAdminDelete.visible = false;
         this.characterPopUpCtrls.ButtonAccept.visible = false;
         this.characterPopUpCtrls.ButtonReject.visible = false;
         this.characterPopUpCtrls.MovieStar.visible = false;
         this.characterPopUpCtrls.Pet.visible = false;
         this.characterPopUpCtrls.CancelFriendRequest.visible = false;
         this.characterPopUpCtrls.CancelBestfriendRequest.visible = false;
         this.characterPopUpCtrls.CancelBoyfriendRequest.visible = false;
         this.characterPopUpCtrls.ActionReportBlock.visible = false;
         if(this.isMyProfile)
         {
            this.characterPopUpCtrls.ActionSendMessage.visible = false;
            this.characterPopUpCtrls.ActionTrade.visible = false;
            this.characterPopUpCtrls.ActionGiveGift.visible = false;
            this.characterPopUpCtrls.ActionGiveAutograph.visible = false;
            this.characterPopUpCtrls.ButtonMyProfile.visible = false;
            this.characterPopUpCtrls.ButtonMyRoom.visible = false;
            this.characterPopUpCtrls.TextActions.visible = false;
            this.characterPopUpCtrls.TextYouAreFriends.visible = false;
         }
         this.characterPopUpCtrls.TextWAYD_tlf = MSPTextFieldUtils.text2EmoticonTextField(this.characterPopUpCtrls.TextWAYD);
         this.characterPopUpCtrls.TextWAYD_tlf.height = 100;
         this.characterPopUpCtrls.TextName_tlf = MSPTextFieldUtils.text2TLFTextField(this.characterPopUpCtrls.TextName);
         FontManager.remapFonts(this.characterPopUpCtrls.TextActions);
         FontManager.remapFonts(this.characterPopUpCtrls.TextYouAreFriends);
         FontManager.remapFonts(this.characterPopUpCtrls.TextBestFriends);
         FontManager.remapTlfFonts(this.characterPopUpCtrls.TextWAYD_tlf);
         FontManager.remapTlfFonts(this.characterPopUpCtrls.TextName_tlf);
         FontManager.remapFonts(this.characterPopUpCtrls.TextLevelt);
         if(this.isVIP)
         {
            this.addVipBadge();
         }
         this.addAskToBeFriendButton();
         this.askToBeBestFriendButton = new BestFriendButton(this,this.characterPopUpCtrls.ButtonAskToBeBestFriend);
         this.askToBeBoyfriendButton = new BoyfriendButton(this,this.characterPopUpCtrls.ButtonAskToBeBoyfriend);
         this.addRemoveFriendButton();
         this.removeBestFriendButton = new BestFriendButton(this,this.characterPopUpCtrls.RemoveBestFriend);
         this.removeBoyfriendButton = new BoyfriendButton(this,this.characterPopUpCtrls.RemoveBoyfriend);
         this.cancelFriendRequest = new FriendButton(this,this.characterPopUpCtrls.CancelFriendRequest);
         this.cancelBestfriendRequest = new BestFriendButton(this,this.characterPopUpCtrls.CancelBestfriendRequest);
         this.cancelBoyfriendRequest = new BoyfriendButton(this,this.characterPopUpCtrls.CancelBoyfriendRequest);
         this.judgeButton = new JudgeButton(this,this.characterPopUpCtrls.BadgeJudge);
         this.juryButton = new JuryButton(this,this.characterPopUpCtrls.BadgeJury);
         this.celebButton = new CelebButton(this,this.characterPopUpCtrls.BadgeCeleb);
         this.adminButton = new AdminButton(this,this.characterPopUpCtrls.ButtonAdmin);
         this.adminDeleteButton = new AdminDeleteButton(this,this.characterPopUpCtrls.ButtonAdminDelete);
         this.mFlattenList = new Vector.<Sprite>();
         this.mFlattenList.push(this.askToBeFriendButton.mcContainer);
         this.mFlattenList.push(this.askToBeBestFriendButton.mcContainer);
         this.mFlattenList.push(this.askToBeBoyfriendButton.mcContainer);
         this.mFlattenList.push(this.removeFriendButton.mcContainer);
         this.mFlattenList.push(this.removeBestFriendButton.mcContainer);
         this.mFlattenList.push(this.removeBoyfriendButton.mcContainer);
         this.mFlattenList.push(this.cancelFriendRequest.mcContainer);
         this.mFlattenList.push(this.cancelBestfriendRequest.mcContainer);
         this.mFlattenList.push(this.cancelBoyfriendRequest.mcContainer);
         this.mFlattenList.push(this.judgeButton.mcContainer);
         this.mFlattenList.push(this.juryButton.mcContainer);
         this.mFlattenList.push(this.celebButton.mcContainer);
         this.mFlattenList.push(this.adminButton.mcContainer);
         this.mFlattenList.push(this.adminDeleteButton.mcContainer);
         if(!this.isMyProfile)
         {
            this.sendMessageButton = new SendMessageButton(this,this.characterPopUpCtrls.ActionSendMessage);
            this.sendMessageButton.toolTip = MSPLocaleManagerWeb.getInstance().getString("SEND_MAIL");
            this.tradeButton = new TradeButton(this,this.characterPopUpCtrls.ActionTrade);
            this.tradeButton.toolTip = MSPLocaleManagerWeb.getInstance().getString("TRADE_BUTTON_MOVIESTAR_POPUP");
            this.reportBlockButton = new ReportBlockButton(this,this.characterPopUpCtrls.ActionReportBlock);
            this.reportBlockButton.load("swf/quest/ReportIcon.swf",MSPLocaleManagerWeb.getInstance().getString("REPORT_BAD"));
            this.giveGiftButton = new GiveGiftButton(this,this.characterPopUpCtrls.ActionGiveGift);
            this.giveGiftButton.toolTip = MSPLocaleManagerWeb.getInstance().getString("GIVE_GIFT");
            this.giveAutographButton = new GiveAutographButton(this,this.characterPopUpCtrls.ActionGiveAutograph);
            this.giveAutographButton.toolTip = MSPLocaleManagerWeb.getInstance().getString("GIVE_AUTOGRAPH");
            this.myProfileButton = new MyProfileButton(this,this.characterPopUpCtrls.ButtonMyProfile);
            this.myProfileButton.toolTip = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_ACTIONS_MYPROFILE"));
            this.myRoomButton = new MyRoomButton(this,this.characterPopUpCtrls.ButtonMyRoom);
            this.myRoomButton.toolTip = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_ACTIONS_MYROOM"));
            this.mFlattenList.push(this.sendMessageButton.mcContainer);
            this.mFlattenList.push(this.tradeButton.mcContainer);
            this.mFlattenList.push(this.reportBlockButton.mcContainer);
            this.mFlattenList.push(this.giveGiftButton.mcContainer);
            this.mFlattenList.push(this.giveAutographButton.mcContainer);
            this.mFlattenList.push(this.myProfileButton.mcContainer);
            this.mFlattenList.push(this.myRoomButton.mcContainer);
         }
         else
         {
            this.changeClothesButton = new ChangeClothesButton(this,this.characterPopUpCtrls.ButtonMyClothing);
            this.changeClothesButton.toolTip = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("CHANGE_CLOTHES"));
            this.changeClothesButton.visible = true;
            this.myProfileButton = new MyProfileButton(this,this.characterPopUpCtrls.ButtonMyProfileSelfView);
            this.myProfileButton.toolTip = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_ACTIONS_MYPROFILE"));
            this.myProfileButton.visible = true;
            this.myRoomButton = new MyRoomButton(this,this.characterPopUpCtrls.ButtonMyRoomSelfView);
            this.myRoomButton.toolTip = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_ACTIONS_MYROOM"));
            this.myRoomButton.visible = true;
            this.characterPopUpCtrls.TextSelfView.visible = true;
            this.mFlattenList.push(this.changeClothesButton.mcContainer);
            this.mFlattenList.push(this.myRoomButton.mcContainer);
            this.mFlattenList.push(this.myProfileButton.mcContainer);
         }
         _loc2_ = 0;
         while(_loc2_ < this.characterPopUpCtrls.numChildren)
         {
            if(this.characterPopUpCtrls.getChildAt(_loc2_) is Sprite)
            {
               _loc4_ = Sprite(this.characterPopUpCtrls.getChildAt(_loc2_));
               if((Boolean(_loc4_)) && _loc4_.numChildren > 4)
               {
                  this.mFlattenList.push(_loc4_);
               }
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.mFlattenList.length)
         {
            if(this.mFlattenList[_loc2_])
            {
               _loc5_ = Number(this.mFlattenList[_loc2_].scaleX);
               FlattenUtilities.flattenSprite(this.mFlattenList[_loc2_],_loc5_,true,true);
            }
            _loc2_++;
         }
         if(this.actor.isDeleted)
         {
            this.disableAllButtons();
         }
         new FriendshipServiceWeb().getActorSpecialSummary(this.actor.ActorId,ActorSession.loggedInActor.ActorId,this.updateSummary);
         this.showButtons(false);
      }
      
      protected function addAskToBeFriendButton() : void
      {
         this.askToBeFriendButton = new FriendButton(this,this.characterPopUpCtrls.ButtonAskToBeFriend);
      }
      
      protected function addRemoveFriendButton() : void
      {
         this.removeFriendButton = new FriendButton(this,this.characterPopUpCtrls.RemoveFriend);
      }
      
      protected function addVipBadge() : void
      {
         if(this.characterPopUpCtrls["Background"] != null)
         {
            MembershipGraphicUtils.addCharacterPopupBackgroundToInstance(this.actor.VipTier,this.characterPopUpCtrls.Background["backgroundHolder"],5,5);
         }
         this.vipButtonGrahic = MembershipGraphicUtils.createPopupVipButton(this.actor.VipTier);
         this.vipButtonGrahic.x += 10;
         this.vipButtonGrahic.y += 30;
         addChild(this.vipButtonGrahic);
         this.vipButton = new VIPButton(this,this.vipButtonGrahic);
         this.vipButton.disableClick = false;
      }
      
      protected function showButtons(param1:Boolean) : void
      {
         this.removeFriendButton.visible = param1;
         this.removeBestFriendButton.visible = param1;
         this.removeBoyfriendButton.visible = param1;
         this.cancelBestfriendRequest.visible = param1;
         this.cancelBoyfriendRequest.visible = param1;
         this.cancelFriendRequest.visible = param1;
         if(this.sendMessageButton != null)
         {
            this.sendMessageButton.visible = param1;
            this.tradeButton.visible = param1;
            this.giveGiftButton.visible = param1;
            this.giveAutographButton.visible = param1;
         }
         this.askToBeFriendButton.visible = param1;
         this.askToBeBestFriendButton.visible = param1;
         this.askToBeBoyfriendButton.visible = param1;
      }
      
      private function updateSummary(param1:ActorSpecialSummary) : void
      {
         this.actorSummary = param1;
         this.updateFriendThumbnails();
         if(!this.isMyProfile)
         {
            this.friendShipStatus = this.getFriendShipStatusToString(this.actorSummary.FriendsStatus);
         }
         this.updateData();
      }
      
      public function breakUpRelationLocally(param1:int) : void
      {
         var _loc3_:MySpecialFriend = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.actorSummary.SpecialFriends)
         {
            if(_loc3_.ActorId == ActorSession.loggedInActor.ActorId && _loc3_.RelationshipTypeId == param1)
            {
               this.actorSummary.SpecialFriends.removeItemAt(_loc2_);
            }
            _loc2_++;
         }
         this.updateFriendThumbnails();
      }
      
      protected function updateFriendThumbnails() : void
      {
         var _loc2_:MySpecialFriend = null;
         var _loc3_:String = null;
         var _loc4_:MovieClip = null;
         var _loc5_:BestFriendSelectionArgs = null;
         var _loc6_:String = null;
         this.bestFriendSelections = new Vector.<BestFriendSelectionArgs>();
         this.clearFriendThumbnails();
         var _loc1_:int = 0;
         for each(_loc2_ in this.actorSummary.SpecialFriends)
         {
            if(_loc2_.RelationshipTypeId == ConstantsFriendshipType.BESTFRIEND && _loc2_.Status == ActorSpecialRelationshipStatus.INRELATIONSHIP)
            {
               if(_loc1_ > FriendshipManager.MAX_NUM_BESTFRIENDS - 1)
               {
                  return;
               }
               _loc5_ = new BestFriendSelectionArgs();
               _loc5_.ActorId = _loc2_.ActorId;
               _loc5_.setParent(this);
               this.bestFriendSelections.push(_loc5_);
               _loc3_ = "Bestfriend" + (_loc1_ + 1);
               _loc6_ = "BestfriendImage" + (_loc1_ + 1);
               _loc4_ = this.characterPopUpCtrls[_loc3_].getChildByName(_loc6_) as MovieClip;
               _loc1_++;
            }
            else if(_loc2_.RelationshipTypeId == ConstantsFriendshipType.BOYFRIEND && _loc2_.Status == ActorSpecialRelationshipStatus.INRELATIONSHIP)
            {
               _loc4_ = this.characterPopUpCtrls.Boyfriend.getChildByName("BoyfriendImage") as MovieClip;
               _loc3_ = "Boyfriend";
            }
            FlashInstanceUtils.loadContentForInstance(new SnapshotUrl(_loc2_.ActorId,EntityTypeType.MOVIESTAR,"moviestar"),_loc4_,null);
            _loc4_.visible = true;
            DisplayObjectUtilities.buttonize(this.characterPopUpCtrls[_loc3_],this.onFriendClickedClosure(_loc2_.ActorId),true,false);
            MSP_ToolTipManager.add(this.characterPopUpCtrls[_loc3_],_loc2_.Name);
         }
         this.numBestFriends = _loc1_;
      }
      
      protected function clearFriendThumbnails() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = "Bestfriend" + (_loc1_ + 1);
            _loc3_ = "BestfriendImage" + (_loc1_ + 1);
            _loc4_ = this.characterPopUpCtrls[_loc2_].getChildByName(_loc3_) as MovieClip;
            _loc4_.visible = false;
            _loc1_++;
         }
         (this.characterPopUpCtrls.Boyfriend.getChildByName("BoyfriendImage") as MovieClip).visible = false;
      }
      
      private function getFriendShipStatusToString(param1:int) : String
      {
         var _loc2_:String = FriendshipsService.NOT_FRIENDS;
         switch(param1)
         {
            case 0:
               _loc2_ = FriendshipsService.SAME_USER;
               break;
            case 1:
               _loc2_ = FriendshipsService.NOT_FRIENDS;
               break;
            case 2:
               _loc2_ = FriendshipsService.FRIENDS;
               break;
            case 3:
               _loc2_ = FriendshipsService.WAITING_FOR_ANSWER;
               break;
            case 4:
               _loc2_ = FriendshipsService.WAITING_FOR_ANSWER;
         }
         return _loc2_;
      }
      
      private function updateData() : void
      {
         var _loc1_:Date = new Date();
         var _loc2_:Number = Number(_loc1_.getDate());
         if(this.actorId != ActorSession.loggedInActor.ActorId)
         {
            this.showButtons(true);
         }
         this.loadMovieStar();
         this.updateBadges();
         this.update();
         var _loc3_:String = new SnapshotUrl(this.actorId,EntityTypeType.MOVIESTAR,"moviestar").toString();
         this.judgeButton.disableClick = false;
         this.juryButton.disableClick = false;
         this.celebButton.disableClick = false;
         this.closeButton = new ScreenIcons.CloseIcon();
         Buttonizer.buttonizeFrames(this.closeButton,this.clickButtonClose);
         this.characterPopUpCtrls.ButtonClose.addChild(this.closeButton);
         this.closeButton.stop();
         if(ActorSession.isModerator())
         {
            this.adminButton.load("swf/admin/admin_button.swf","admin button");
            this.adminButton.visible = true;
            this.adminDeleteButton.visible = true;
         }
         this.characterPopUpCtrls.TextName_tlf.text = this.actor.Name;
         this.characterPopUpCtrls.TextLevelt.text = this.actor.Level.toString();
         MSP_ToolTipManager.add(this.characterPopUpCtrls.TextLevelt,this.mspLocaleManager.getString(this.levelConfiguration.getLevelResourceId(this.actor.Level)));
         if(this.isActorBlocked())
         {
            this.disableAllButtons();
            this.reportBlockButton.clickDisabled = false;
            this.characterPopUpCtrls.TextWAYD_tlf.visible = false;
         }
         if(this.haveBlockedUser() && !ActorSession.isModerator())
         {
            this.characterPopUpCtrls.TextYouAreFriends.text = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_BLOCKED_INFO_SELF"));
         }
         else if(this.hasBlockedMe() && !ActorSession.isModerator())
         {
            this.characterPopUpCtrls.TextYouAreFriends.text = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_BLOCKED_INFO_OTHER"));
         }
         FriendsManager.getInstance().addListener(FriendsManager.ACTORCONNECTEDCHANGED,this.onActorConnectedChanged,false,0,true);
         this._isLoaded = true;
         MessageCommunicator.send(new MsgEvent(MSPEvent.CHARACTER_POPUP_LOAD_COMPLETED,this));
         this.HookUp();
      }
      
      public function updateBestFriend() : void
      {
         var _loc1_:Boolean = ActorSession.loggedInActor.IsBestFriend(this.actorId);
         var _loc2_:int = ActorSession.loggedInActor.GetBestFriendStatus(this.actorId);
         var _loc3_:String = CharacterManager.getBestFriendStatusLabel(_loc2_,this.actor.Name);
         this.askToBeBestFriendButton.visible = false;
         this.removeBestFriendButton.visible = false;
         this.cancelBestfriendRequest.visible = false;
         if(this.actor.isDeleted)
         {
            return;
         }
         if(_loc1_)
         {
            this.removeBestFriendButton.visible = true;
            this.removeBestFriendButton.clickDisabled = false;
            this.removeBestFriendButton.toolTip = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("STOP_BESTFRIENDSHIP"));
            if(this.friendShipStatus == FriendshipsService.NOT_FRIENDS)
            {
               this.friendShipStatus = FriendshipsService.FRIENDS;
            }
         }
         else if(_loc2_ == ActorSpecialRelationshipStatus.WAITINGFORANSWER)
         {
            this.cancelBestfriendRequest.visible = true;
            this.cancelBestfriendRequest.toolTip = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_CANCEL_REQUEST"));
            this.askToBeFriendButton.clickDisabled = true;
            this.removeBoyfriendButton.clickDisabled = true;
            this.removeFriendButton.clickDisabled = true;
            if(this.friendShipStatus == FriendshipsService.NOT_FRIENDS)
            {
               this.askToBeFriendButton.clickDisabled = true;
            }
         }
         else
         {
            this.askToBeBestFriendButton.visible = true;
            this.askToBeBestFriendButton.toolTip = _loc3_;
         }
      }
      
      public function updateBoyfriend() : void
      {
         var _loc1_:int = ActorSession.loggedInActor.GetBoyfriendStatusById(this.actorId);
         var _loc2_:String = CharacterManager.getBoyFriendStatusLabel(this.actor);
         this.askToBeBoyfriendButton.visible = false;
         this.removeBoyfriendButton.visible = false;
         this.cancelBoyfriendRequest.visible = false;
         if(this.actor.isDeleted)
         {
            return;
         }
         if(_loc1_ == ActorSpecialRelationshipStatus.INRELATIONSHIP)
         {
            this.removeBoyfriendButton.visible = true;
            this.removeBoyfriendButton.clickDisabled = false;
            this.removeBoyfriendButton.toolTip = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("STOP_RELATIONSHIP"));
            if(this.friendShipStatus == FriendshipsService.NOT_FRIENDS)
            {
               this.friendShipStatus = FriendshipsService.FRIENDS;
            }
         }
         else if(_loc1_ == ActorSpecialRelationshipStatus.WAITINGFORANSWER)
         {
            this.cancelBoyfriendRequest.visible = true;
            this.cancelBoyfriendRequest.toolTip = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_CANCEL_REQUEST"));
            this.askToBeFriendButton.clickDisabled = true;
            this.removeBestFriendButton.clickDisabled = true;
            this.removeFriendButton.clickDisabled = true;
         }
         else
         {
            this.askToBeBoyfriendButton.visible = true;
            this.askToBeBoyfriendButton.toolTip = _loc2_;
         }
      }
      
      public function onAcceptBoyfriendLocal() : void
      {
         var _loc1_:MySpecialFriend = new MySpecialFriend();
         _loc1_.ActorId = ActorSession.loggedInActor.ActorId;
         _loc1_.Status = ConstantsRelationshipStatus.INRELATIONSHIP;
         _loc1_.Name = ActorSession.loggedInActor.Name;
         this.actorSummary.SpecialFriends.addItem(_loc1_);
         this.updateSummary(this.actorSummary);
      }
      
      private function updateFriendShipStatus() : void
      {
         var getFriendshipStatusDone:Function;
         if(this.actor != null)
         {
            if(FriendsManager.getInstance().hasFriend(this.actor.ActorId))
            {
               this.friendShipStatus = FriendshipsService.FRIENDS;
            }
            else
            {
               getFriendshipStatusDone = function(param1:String):void
               {
                  friendShipStatus = getFriendShipStatusToString(int(param1));
               };
               new FriendshipServiceWeb().GetFriendShipStatus(ActorSession.loggedInActor.ActorId,this.actor.ActorId,getFriendshipStatusDone);
            }
         }
      }
      
      private function localize() : void
      {
         var _loc1_:Localizer = new Localizer(this.characterPopUpCtrls);
         _loc1_.addLocalizedPropertyName("text");
         _loc1_.localize();
      }
      
      public function onClicked(param1:MouseEvent) : void
      {
      }
      
      public function close() : void
      {
         dispatchEvent(new Event(Event.CLOSE));
         this.UnHook();
         this.parentContainer.close();
         FriendshipContainer.closeGlobal();
         if(this.linkHighlighter != null)
         {
            this.linkHighlighter.destroy();
            this.linkHighlighter = null;
         }
         if(stage != null)
         {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mousemove);
         }
      }
      
      public function clickButtonClose(param1:MouseEvent) : void
      {
         this.close();
         Buttonizer.unbuttonizeFrames(this.closeButton,this.clickButtonClose);
      }
      
      protected function loadMovieStar() : void
      {
         var _loc1_:MovieStarCharacter = new MovieStarCharacter();
         _loc1_.Load(this.actor.ActorId,this.movieStarLoaded,1,false,true,false,true);
      }
      
      protected function movieStarLoaded(param1:MovieStarCharacter) : void
      {
         param1.scale = 0.46;
         param1.x = this.characterPopUpCtrls.MovieStar.x;
         param1.y += 60;
         if(this._movieStar != null && this._movieStar.parent != null)
         {
            this._movieStar.parent.removeChild(this._movieStar);
         }
         this._movieStar = param1;
         this.characterPopUpCtrls.MovieStar.visible = false;
         this.characterPopUpCtrls.addChild(this._movieStar);
         if(this.actor.Moderator == 1 || this.actor.Moderator == 2)
         {
            this.moderatorSticker = new MovieStarSafetySticker();
            this.moderatorSticker.addSticker(this._movieStar);
         }
         var _loc2_:Rectangle = this.characterPopUpCtrls.getBounds(null);
         this.petMovieStar = new MovieStarCharacter();
         this.petMovieStar.x = this.characterPopUpCtrls.Pet.x;
         this.petMovieStar.y = _loc2_.bottom;
         this.characterPopUpCtrls.Pet.visible = false;
         this.characterPopUpCtrls.addChild(this.petMovieStar);
         this.setupAnimationAndPet(this.petMovieStar);
      }
      
      private function mousemove(param1:MouseEvent) : void
      {
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         _loc2_ = this.characterPopUpCtrls.globalToLocal(_loc2_);
         var _loc3_:Boolean = false;
         if(_loc2_.x > MASK_TOP_LEFT.x && _loc2_.x < MASK_BOTTOM_RIGHT.x && _loc2_.y > MASK_TOP_LEFT.y && _loc2_.y < MASK_BOTTOM_RIGHT.y)
         {
            _loc3_ = true;
         }
         else
         {
            _loc3_ = false;
         }
         if(_loc3_ != this.isMaskAdded)
         {
            this.isMaskAdded = _loc3_;
            if(_loc3_)
            {
               this._movieStar.mask = this.mouseoverMask;
               this._movieStar.addChild(this.mouseoverMask);
            }
            else
            {
               this._movieStar.mask = null;
               if(this.mouseoverMask != null && Boolean(this._movieStar.contains(this.mouseoverMask)))
               {
                  this._movieStar.removeChild(this.mouseoverMask);
               }
            }
         }
      }
      
      private function animationSet() : void
      {
         if(!stage)
         {
            return;
         }
         var _loc1_:Point = new Point(MASK_START_X,MASK_START_Y);
         var _loc2_:Rectangle = this._movieStar.getBounds(this._movieStar);
         _loc1_ = this._movieStar.globalToLocal(this.characterPopUpCtrls.localToGlobal(_loc1_));
         this.mouseoverMask = new MovieClip();
         this.mouseoverMask.graphics.beginFill(16711680);
         this.mouseoverMask.graphics.drawRect(_loc1_.x,_loc1_.y,330,500);
         this.mouseoverMask.graphics.endFill();
         if(stage != null)
         {
            stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mousemove);
         }
      }
      
      private function setupAnimationAndPet(param1:MovieStarCharacter) : void
      {
         var _loc2_:String = null;
         var _loc3_:WallPostLink = null;
         if(this.actorSummary.AnimationMood != null)
         {
            this._movieStar.PlayAnimation(this.actorSummary.AnimationMood.FigureAnimation,this.animationSet,0,this.actorSummary.LastUpdated);
            this._movieStar.SetFaceExpression(this.actorSummary.AnimationMood.FaceAnimation);
            if(this.actorSummary.PetClickItem != null)
            {
               this.petMovieStar.setupPet(this.actorSummary.PetClickItem,0,0,0.45);
            }
            else if(this.actorSummary.BonsterRelItem != null)
            {
               this.petMovieStar.setupBonster(this.actorSummary.BonsterRelItem,50,-5,this._movieStar.scale);
            }
            _loc2_ = UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromStrings(this.actorSummary.AnimationMood.TextLineBlacklisted,this.actorSummary.AnimationMood.TextLineWhitelisted,this.actorSummary.AnimationMood.TextLine,this.actorId);
            if(this.actorSummary.AnimationMood.WallPostLinks != null && this.actorSummary.AnimationMood.WallPostLinks.length > 0)
            {
               _loc3_ = this.actorSummary.AnimationMood.WallPostLinks[0];
               this.linkHighlighter = WallPostLinking.createLink(_loc3_,_loc2_,this.characterPopUpCtrls.TextWAYD_tlf);
            }
            else
            {
               this.characterPopUpCtrls.TextWAYD_tlf.senderId = this.actorId;
               this.characterPopUpCtrls.TextWAYD_tlf.emoticonText = _loc2_;
            }
            this.truncateText(this.characterPopUpCtrls.TextWAYD_tlf,6);
         }
         else
         {
            this.characterPopUpCtrls.TextWAYD_tlf.emoticonText = MSPLocaleManagerWeb.getInstance().getString("HAS_NOT_TWIT",[this.actor.Name]);
         }
      }
      
      private function updateBadges() : void
      {
         this.judgeButton.visible = this.actor.isJudge;
         this.juryButton.visible = this.actor.isJury;
         this.celebButton.visible = this.actor.isCeleb;
      }
      
      public function update() : void
      {
         if(!this.isMyProfile)
         {
            this.updateBoyfriend();
            this.updateBestFriend();
            this.updateFriendShipButton();
            this.updateRelationshipText();
            this.setSpecialRelationshipButtonsEnabled();
            if(this.isActorBlocked())
            {
               this.disableAllButtons();
               this.characterPopUpCtrls.TextWAYD_tlf.visible = false;
            }
            if(this.actor.IsExtra)
            {
               this.characterPopUpCtrls.ActionReportBlock.visible = false;
            }
            else
            {
               this.characterPopUpCtrls.ActionReportBlock.visible = true;
            }
         }
      }
      
      public function updateFriendShipButton() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.isTodosVisible == true)
         {
            return;
         }
         this.askToBeFriendButton.visible = false;
         this.removeFriendButton.visible = false;
         this.cancelFriendRequest.visible = false;
         if(this.actor.isDeleted)
         {
            return;
         }
         if(this.friendShipStatus == FriendshipsService.FRIENDS)
         {
            this.removeFriendButton.changeStatus(this.friendShipStatus);
            this.removeFriendButton.visible = true;
            this.removeFriendButton.clickDisabled = false;
            _loc1_ = ActorSession.loggedInActor.GetBoyfriendStatusById(this.actorId);
            _loc2_ = ActorSession.loggedInActor.GetBestFriendStatus(this.actorId);
            if(_loc1_ == ActorSpecialRelationshipStatus.WAITINGFORANSWER || _loc2_ == ActorSpecialRelationshipStatus.WAITINGFORANSWER)
            {
               this.removeFriendButton.clickDisabled = true;
            }
         }
         else if(this.friendShipStatus == FriendshipsService.WAITING_FOR_ANSWER)
         {
            this.cancelFriendRequest.changeStatus(this.friendShipStatus);
            this.cancelFriendRequest.visible = true;
            this.cancelFriendRequest.clickDisabled = false;
            this.cancelFriendRequest.toolTip = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_CANCEL_REQUEST"));
            this.removeBoyfriendButton.clickDisabled = true;
            this.removeBestFriendButton.clickDisabled = true;
         }
         else
         {
            this.askToBeFriendButton.changeStatus(this.friendShipStatus);
            this.askToBeFriendButton.clickDisabled = false;
            this.askToBeFriendButton.visible = true;
            _loc3_ = ActorSession.loggedInActor.GetBoyfriendStatusById(this.actorId);
            _loc4_ = ActorSession.loggedInActor.GetBestFriendStatus(this.actorId);
            if(_loc3_ == ActorSpecialRelationshipStatus.WAITINGFORANSWER || _loc4_ == ActorSpecialRelationshipStatus.WAITINGFORANSWER)
            {
               this.askToBeFriendButton.clickDisabled = true;
            }
         }
      }
      
      public function onAcceptDone(param1:Todo) : void
      {
         this.updateRelationshipsButtons(param1.Type);
      }
      
      public function onRejectDone(param1:Todo) : void
      {
         this.updateRelationshipsButtons(param1.Type);
      }
      
      private function updateRelationshipsButtons(param1:int) : void
      {
         this.askToBeBestFriendButton.visible = false;
         this.askToBeBoyfriendButton.visible = false;
         this.askToBeFriendButton.visible = false;
         this.removeBestFriendButton.visible = false;
         this.removeBoyfriendButton.visible = false;
         this.removeFriendButton.visible = false;
         this.cancelBestfriendRequest.visible = false;
         this.cancelBoyfriendRequest.visible = false;
         this.cancelFriendRequest.visible = false;
         this.isTodosVisible = false;
         this.update();
         this.updateFriendShipButton();
      }
      
      public function updateRelationshipText() : void
      {
         var _loc1_:int = ActorSession.loggedInActor.GetBestFriendStatus(this.actorId);
         var _loc2_:int = ActorSession.loggedInActor.GetBoyfriendStatusById(this.actorId);
         if(this.friendShipStatus == FriendshipsService.WAITING_FOR_ANSWER || _loc2_ == ActorSpecialRelationshipStatus.WAITINGFORANSWER || _loc1_ == ActorSpecialRelationshipStatus.WAITINGFORANSWER)
         {
            this.characterPopUpCtrls.TextYouAreFriends.text = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_QUESTION_AWAITING"));
            return;
         }
         if(_loc2_ == ActorSpecialRelationshipStatus.INRELATIONSHIP)
         {
            this.characterPopUpCtrls.TextYouAreFriends.text = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_STATUS_RELATIONSHIP"));
            return;
         }
         if(ActorSession.loggedInActor.IsBestFriend(this.actorId))
         {
            this.characterPopUpCtrls.TextYouAreFriends.text = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_STATUS_BESTFRIENDS"));
         }
         else if(this.friendShipStatus == FriendshipsService.FRIENDS)
         {
            this.characterPopUpCtrls.TextYouAreFriends.text = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_STATUS_FRIENDS"));
         }
         else
         {
            this.characterPopUpCtrls.TextYouAreFriends.text = this.getSafeString(MSPLocaleManagerWeb.getInstance().getString("MS_POPUP_STATUS_NOTFRIENDS"));
         }
      }
      
      protected function getSafeString(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1;
      }
      
      private function HookUp() : void
      {
         MessageCommunicator.subscribe(FriendshipManager.BREAKUP,this.onRefreshFriendshipEvent);
         MessageCommunicator.subscribe(FriendshipManager.FRIENDREQ,this.onIncomingFriendRequest);
         MessageCommunicator.subscribe(FriendshipManager.FRIENDACCEPT,this.onIncomingFriendAccept);
         MessageCommunicator.subscribe(FriendshipManager.FRIENDREJECT,this.onIncomingFriendReject);
         MessageCommunicator.subscribe(FriendshipManager.BOYFRIENDREQ,this.onRefreshFriendshipEvent);
         MessageCommunicator.subscribe(FriendshipManager.BOYFRIENDACCEPT,this.onAcceptBoyfriend);
         MessageCommunicator.subscribe(FriendshipManager.BOYFRIENDREJECT,this.onRejectBoyfriend);
         MessageCommunicator.subscribe(FriendshipManager.BESTFRIENDBREAKUP,this.onRefreshFriendshipEvent);
         MessageCommunicator.subscribe(FriendshipManager.BESTFRIENDREQ,this.onRefreshFriendshipEvent);
         MessageCommunicator.subscribe(FriendshipManager.BESTFRIENDACCEPT,this.onRefreshFriendshipEvent);
         MessageCommunicator.subscribe(FriendshipManager.BESTFRIENDREJECT,this.onRejectBestFriend);
         MessageCommunicator.subscribe(FriendshipManager.ACCEPTFRIENDSHIP,this.onAcceptFriendShip);
         MessageCommunicator.subscribe(FriendshipManager.REJECTFRIENDSHIP,this.onRejectFriendShip);
         MessageCommunicator.subscribe(FriendshipManager.REQUESTFRIENDSHIP,this.onRequestFriendShip);
         MessageCommunicator.subscribe(FriendshipManager.ACCEPTBOYFRIEND,this.onRefreshFriendshipEvent);
         MessageCommunicator.subscribe(FriendshipManager.REJECTBOYFRIEND,this.onRefreshFriendshipEvent);
         MessageCommunicator.subscribe(FriendshipManager.ACCEPTBESTFRIEND,this.onRefreshFriendshipEvent);
         MessageCommunicator.subscribe(FriendshipManager.REJECTBESTFRIEND,this.onRefreshFriendshipEvent);
         MessageCommunicator.subscribe(FriendshipManager.STOPFRIENDSHIP,this.onStopFriendShip);
         MessageCommunicator.subscribe(MSPEvent.MY_CLOTHES_CHANGED,this.onClothesChanged);
         MessageCommunicator.subscribe(FriendActivityEvent.RELOAD_APPEARENCE,this.onReloadSkin);
         MessageCommunicator.subscribe(FriendActivityEvent.RELOAD_CLOTHES,this.onReloadClothes);
         MessageCommunicator.subscribe(FriendActivityEvent.TWIT,this.onTwit);
      }
      
      private function UnHook() : void
      {
         MessageCommunicator.unscribe(FriendshipManager.BREAKUP,this.onRefreshFriendshipEvent);
         MessageCommunicator.unscribe(FriendshipManager.FRIENDREQ,this.onIncomingFriendRequest);
         MessageCommunicator.unscribe(FriendshipManager.FRIENDACCEPT,this.onIncomingFriendAccept);
         MessageCommunicator.unscribe(FriendshipManager.FRIENDREJECT,this.onIncomingFriendReject);
         MessageCommunicator.unscribe(FriendshipManager.BOYFRIENDREQ,this.onRefreshFriendshipEvent);
         MessageCommunicator.unscribe(FriendshipManager.BOYFRIENDACCEPT,this.onAcceptBoyfriend);
         MessageCommunicator.unscribe(FriendshipManager.BOYFRIENDREJECT,this.onRejectBoyfriend);
         MessageCommunicator.unscribe(FriendshipManager.BESTFRIENDBREAKUP,this.onRefreshFriendshipEvent);
         MessageCommunicator.unscribe(FriendshipManager.BESTFRIENDREQ,this.onRefreshFriendshipEvent);
         MessageCommunicator.unscribe(FriendshipManager.BESTFRIENDACCEPT,this.onRefreshFriendshipEvent);
         MessageCommunicator.unscribe(FriendshipManager.BESTFRIENDREJECT,this.onRejectBestFriend);
         MessageCommunicator.unscribe(FriendshipManager.ACCEPTFRIENDSHIP,this.onAcceptFriendShip);
         MessageCommunicator.unscribe(FriendshipManager.REJECTFRIENDSHIP,this.onRejectFriendShip);
         MessageCommunicator.unscribe(FriendshipManager.REQUESTFRIENDSHIP,this.onRequestFriendShip);
         MessageCommunicator.unscribe(FriendshipManager.ACCEPTBOYFRIEND,this.onRefreshFriendshipEvent);
         MessageCommunicator.unscribe(FriendshipManager.REJECTBOYFRIEND,this.onRefreshFriendshipEvent);
         MessageCommunicator.unscribe(FriendshipManager.ACCEPTBESTFRIEND,this.onRefreshFriendshipEvent);
         MessageCommunicator.unscribe(FriendshipManager.REJECTBESTFRIEND,this.onRefreshFriendshipEvent);
         MessageCommunicator.unscribe(FriendshipManager.STOPFRIENDSHIP,this.onStopFriendShip);
         MessageCommunicator.unscribe(MSPEvent.MY_CLOTHES_CHANGED,this.onClothesChanged);
         MessageCommunicator.unscribe(FriendActivityEvent.RELOAD_APPEARENCE,this.onReloadSkin);
         MessageCommunicator.unscribe(FriendActivityEvent.RELOAD_CLOTHES,this.onReloadClothes);
         MessageCommunicator.unscribe(FriendActivityEvent.TWIT,this.onTwit);
      }
      
      private function onRejectBestFriend(param1:MsgEvent) : void
      {
         ActorSession.loggedInActor.SetBestFriendStatus(this.actorId,ConstantsFriendshipStatus.NONE);
         this.askToBeFriendButton.clickDisabled = false;
         this.removeBoyfriendButton.clickDisabled = false;
         this.removeFriendButton.clickDisabled = false;
         this.updateBestFriend();
         this.updateRelationshipText();
         this.setSpecialRelationshipButtonsEnabled();
      }
      
      private function onAcceptBoyfriend(param1:MsgEvent) : void
      {
         this.cancelBestfriendRequest.visible = false;
         this.cancelBoyfriendRequest.visible = false;
         this.cancelFriendRequest.visible = false;
         this.askToBeFriendButton.clickDisabled = false;
         this.removeBestFriendButton.clickDisabled = false;
         this.removeFriendButton.clickDisabled = false;
         this.updateBoyfriend();
         this.updateRelationshipText();
         this.setSpecialRelationshipButtonsEnabled();
      }
      
      private function onRejectBoyfriend(param1:MsgEvent) : void
      {
         ActorSession.loggedInActor.DeleteBoyfriendRelationship(this._actorId);
         this.askToBeFriendButton.clickDisabled = false;
         this.removeBestFriendButton.clickDisabled = false;
         this.removeFriendButton.clickDisabled = false;
         this.updateBoyfriend();
         this.updateRelationshipText();
         this.setSpecialRelationshipButtonsEnabled();
      }
      
      private function onIncomingFriendRequest(param1:MsgEvent) : void
      {
         var _loc2_:Number = Number(Number(param1.data));
         if(_loc2_ == this.actor.ActorId)
         {
            this.friendShipStatus = FriendshipsService.WANTS_TO_BE_FRIENDS;
         }
         this.update();
      }
      
      private function onIncomingFriendAccept(param1:MsgEvent) : void
      {
         var _loc2_:Number = Number(Number(param1.data));
         if(_loc2_ == this.actor.ActorId)
         {
            this.friendShipStatus = FriendshipsService.FRIENDS;
         }
         this.removeBestFriendButton.clickDisabled = false;
         this.removeBoyfriendButton.clickDisabled = false;
         this.update();
      }
      
      private function onIncomingFriendReject(param1:MsgEvent) : void
      {
         var _loc2_:Number = Number(Number(param1.data));
         if(_loc2_ == this.actor.ActorId)
         {
            this.friendShipStatus = FriendshipsService.NOT_FRIENDS;
         }
         this.removeBestFriendButton.clickDisabled = false;
         this.removeBoyfriendButton.clickDisabled = false;
         this.update();
      }
      
      private function onAcceptFriendShip(param1:MsgEvent) : void
      {
         var _loc2_:Number = Number(Number(param1.data));
         if(_loc2_ == this.actor.ActorId)
         {
            this.friendShipStatus = FriendshipsService.FRIENDS;
         }
         this.update();
      }
      
      private function onRejectFriendShip(param1:MsgEvent) : void
      {
         var _loc2_:Number = Number(Number(param1.data));
         if(_loc2_ == this.actor.ActorId)
         {
            this.friendShipStatus = FriendshipsService.NOT_FRIENDS;
         }
         this.removeBestFriendButton.clickDisabled = false;
         this.removeBoyfriendButton.clickDisabled = false;
         this.update();
      }
      
      private function onRequestFriendShip(param1:MsgEvent) : void
      {
         var _loc2_:Number = Number(Number(param1.data));
         if(_loc2_ == this.actor.ActorId)
         {
            this.friendShipStatus = FriendshipsService.WAITING_FOR_ANSWER;
         }
      }
      
      private function onStopFriendShip(param1:MsgEvent) : void
      {
         var _loc2_:Number = Number(Number(param1.data));
         if(_loc2_ != this.actor.ActorId)
         {
            return;
         }
         ActorSession.loggedInActor.DeleteBoyfriendRelationship(this._actorId);
         ActorSession.loggedInActor.DeleteRelationship(this._actorId,ActorRelationshipType.BestFriend);
         this.removeBestFriendButton.clickDisabled = false;
         this.removeBoyfriendButton.clickDisabled = false;
         this.friendShipStatus = FriendshipsService.NOT_FRIENDS;
         this.update();
      }
      
      private function onRefreshFriendshipEvent(param1:MsgEvent) : void
      {
         this.update();
      }
      
      private function onActorConnectedChanged(param1:MSP_Event) : void
      {
         var _loc2_:int = int(int(param1.data));
         if(this.actor != null && this.actor.ActorId == _loc2_)
         {
            this._hasActorChanged = true;
            if(this.isShown)
            {
               this.update();
               this._hasActorChanged = false;
            }
         }
      }
      
      private function onClothesChanged(param1:MsgEvent) : void
      {
         if(this.actor != null && param1.data != null && this.actor.ActorId == param1.data.actorId)
         {
            this._hasActorChanged = true;
            if(this.isShown)
            {
               this._hasActorChanged = false;
            }
         }
      }
      
      private function onReloadSkin(param1:FriendActivityEvent) : void
      {
         var _loc2_:Number = Number(Number(param1.data));
         if(this.actor != null && this._movieStar != null && _loc2_ == this.actor.ActorId)
         {
            this._hasActorChanged = true;
            if(this.isShown)
            {
               this._movieStar.synchronizeAppearance();
               this._hasActorChanged = false;
            }
         }
      }
      
      private function onReloadClothes(param1:FriendActivityEvent) : void
      {
         var _loc2_:Number = Number(Number(param1.data));
         if(this.actor != null && this._movieStar != null && _loc2_ == this.actor.ActorId)
         {
            this._hasActorChanged = true;
            if(this.isShown)
            {
               this._movieStar.synchronizeClothing();
               this._hasActorChanged = false;
            }
         }
      }
      
      private function onTwit(param1:FriendActivityEvent) : void
      {
         var _loc2_:Number = Number(Number(param1.data));
         if(_loc2_ == this.actor.ActorId)
         {
         }
      }
      
      protected function onFriendClickedClosure(param1:int) : Function
      {
         var onFriendClicked:Function = null;
         var friendId:int = param1;
         onFriendClicked = function(param1:MouseEvent):void
         {
            CharacterContainer.showMyPopUpPreviousCoords(friendId);
            parentContainer.close();
         };
         return onFriendClicked;
      }
      
      private function nullCheckDisable(param1:BaseButton) : void
      {
         if(param1 != null)
         {
            param1.clickDisabled = true;
         }
      }
      
      private function disableAllButtons() : void
      {
         this.askToBeFriendButton.clickDisabled = true;
         this.askToBeBestFriendButton.clickDisabled = true;
         this.askToBeBoyfriendButton.clickDisabled = true;
         this.removeFriendButton.clickDisabled = true;
         this.removeBestFriendButton.clickDisabled = true;
         this.removeBoyfriendButton.clickDisabled = true;
         this.cancelBestfriendRequest.clickDisabled = true;
         this.cancelBoyfriendRequest.clickDisabled = true;
         this.cancelFriendRequest.clickDisabled = true;
         this.sendMessageButton.clickDisabled = true;
         this.tradeButton.clickDisabled = true;
         this.giveGiftButton.clickDisabled = true;
         this.giveAutographButton.clickDisabled = true;
         this.myProfileButton.clickDisabled = true;
         this.myRoomButton.clickDisabled = true;
         this.nullCheckDisable(this.vipButton);
         this.nullCheckDisable(this.judgeButton);
         this.nullCheckDisable(this.juryButton);
         this.nullCheckDisable(this.celebButton);
         this.nullCheckDisable(this.changeClothesButton);
      }
      
      protected function truncateText(param1:MSP_EmoticonTextFlowArea, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:String = "...";
         if(param1.numLines > param2)
         {
            _loc4_ = param1.getLineOffset(param2) - 1;
            _loc4_ = _loc4_ - _loc3_.length;
            _loc4_ = int(param1.emoticonText.substring(0,_loc4_ + 1).search(/\S\s*$/));
            param1.emoticonText = param1.emoticonText.substring(0,_loc4_) + _loc3_;
         }
      }
      
      private function haveBlockedUser() : Boolean
      {
         var _loc1_:int = 0;
         for each(_loc1_ in ActorSession.blockedActors)
         {
            if(_loc1_ == this.actorId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function hasBlockedMe() : Boolean
      {
         var _loc1_:int = 0;
         for each(_loc1_ in ActorSession.blockingActors)
         {
            if(_loc1_ == this.actorId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isActorBlocked() : Boolean
      {
         return this.haveBlockedUser() || this.hasBlockedMe();
      }
      
      public function set actorDetails(param1:ActorDetails) : void
      {
         var _loc2_:Object = this.actorDetails;
         if(_loc2_ !== param1)
         {
            this._2081141389actorDetails = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actorDetails",_loc2_,param1));
            }
         }
      }
   }
}

