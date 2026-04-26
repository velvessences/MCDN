package com.moviestarplanet.core.controller.listeners
{
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.Components.postcard.PostcardPusher;
   import com.moviestarplanet.Components.pushcontent.frienddisplayer.FriendDisplayer;
   import com.moviestarplanet.Components.pushcontent.frienddisplayer.FriendDisplayerForSocialShopping;
   import com.moviestarplanet.Components.pushcontent.frienddisplayer.FriendDisplayerPhotoUpload;
   import com.moviestarplanet.Components.searchshop.SearchClothesShopPopup;
   import com.moviestarplanet.Forms.EditOrDeleteClipArt;
   import com.moviestarplanet.admin.module.AdminModuleManager;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.clothesutils.ClothIdentifier;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.scrapitems.IClipArtInfo;
   import com.moviestarplanet.scrapitems.valueobjects.ClipArt;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.ReportUtils;
   import com.moviestarplanet.utils.input.InputAreaInterface;
   import com.moviestarplanet.utils.input.InputUtils;
   import com.moviestarplanet.window.stack.WindowStack;
   
   public class UtilsOperator
   {
      
      public function UtilsOperator()
      {
         super();
      }
      
      public static function wireup() : void
      {
         MessageCommunicator.subscribe(MSPEvent.VIOLATED_RULES,OnGiveAutoWarning);
         MessageCommunicator.subscribe(MSPEvent.REPORT_ENTITY,OnReportEntity);
         MessageCommunicator.subscribe(MSPEvent.CLIPART_EDIT,OnClipArtEdit);
         MessageCommunicator.subscribe(MSPEvent.CLOTHESSHOP_SEARCH_POPUP,OnClothesShopSearchPopup);
         MessageCommunicator.subscribe(MSPEvent.CLOTHESSHOP_EDIT_CLOTHES,OnClothesShopEditPopup);
         MessageCommunicator.subscribe(MSPEvent.SEND_ACTIVITY_TO_FRIEND,OnSendActivityToFriends);
         MessageCommunicator.subscribe(MSPEvent.SHOW_CONTENT_EMAIL_FORM,OnShowContentEmailForm);
         MessageCommunicator.subscribe(MSPEvent.SHOW_FRIEND_DISPLAY,OnShowFriendDisplay);
         MessageCommunicator.subscribe(MSPEvent.INIT_COMMENT_BUTTONS,onInitCommentButtons);
      }
      
      private static function onInitCommentButtons(param1:MsgEvent) : void
      {
         var _loc2_:InputAreaInterface = new InputAreaInterfaceWrapper(param1.data.data);
         InputUtils.mapFontFunctions(_loc2_,param1.data.colorCallback,2);
         InputUtils.mapEmoticonFunctions(_loc2_,null,3);
      }
      
      private static function OnGiveAutoWarning(param1:MsgEvent) : void
      {
         var _loc2_:Object = param1.data;
         AdminModuleManager.getInstance().giveAutoWarning(_loc2_.actorId,_loc2_.message,_loc2_.inputLocation);
      }
      
      private static function OnReportEntity(param1:MsgEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(AnchorCharacters.isSpecialCharacter(_loc2_.actorId) == false)
         {
            ReportUtils.reportEntity(_loc2_.actorId,_loc2_.inputLocation,_loc2_.entityId,_loc2_.name);
         }
      }
      
      private static function OnClipArtEdit(param1:MsgEvent) : void
      {
         var _loc2_:IClipArtInfo = param1.data as IClipArtInfo;
         var _loc3_:EditOrDeleteClipArt = new EditOrDeleteClipArt();
         _loc3_.clipArtToEditOrDelete = ClipArt(_loc2_);
         OldPopupHandler.getInstance().showFakePopup(_loc3_,310,140);
      }
      
      private static function OnClothesShopSearchPopup(param1:MsgEvent) : void
      {
         var _loc2_:Function = param1.data as Function;
         var _loc3_:SearchClothesShopPopup = new SearchClothesShopPopup();
         _loc3_.result = _loc2_;
         OldPopupHandler.getInstance().showFakePopup(_loc3_,500,200);
      }
      
      private static function OnClothesShopEditPopup(param1:MsgEvent) : void
      {
         var _loc2_:Cloth = param1.data;
         if(ClothIdentifier.IsClothes(_loc2_.ClothesCategoryId))
         {
            AdminModuleManager.getInstance().editClothes(_loc2_);
         }
         else
         {
            AdminModuleManager.getInstance().editClothes(_loc2_,true);
         }
      }
      
      private static function OnSendActivityToFriends(param1:MsgEvent) : void
      {
         var _loc2_:Object = param1.data;
         var _loc3_:Object = _loc2_.activity;
         var _loc4_:int = int(_loc2_.actorId);
         if(_loc3_.hasOwnProperty("entityId"))
         {
            FriendshipManager.getInstance().convertLegacyEntityObjectAndSendToFriend(_loc3_,_loc4_);
         }
         else
         {
            FriendshipManager.getInstance().sendLegacyObjectEventToFriend(_loc3_,_loc4_);
         }
      }
      
      private static function OnShowContentEmailForm(param1:MsgEvent) : void
      {
         var _loc2_:Object = param1.data;
         PostcardPusher.showContentEmailForm(_loc2_.entityId,_loc2_.entityType,_loc2_.name);
      }
      
      private static function OnShowFriendDisplay(param1:MsgEvent) : void
      {
         var _loc3_:FriendDisplayer = null;
         var _loc2_:Object = param1.data;
         var _loc4_:int = 320;
         var _loc5_:int = 200;
         if(Boolean(_loc2_.entityType) && _loc2_.entityType == EntityTypeType.SOCIALSHOPPING)
         {
            _loc3_ = new FriendDisplayerForSocialShopping(_loc2_.entityId,_loc2_.entityType,_loc2_.entityId);
         }
         else if(Boolean(_loc2_.entityType) && _loc2_.entityType == EntityTypeType.IMAGE_UPLOAD)
         {
            _loc3_ = new FriendDisplayerPhotoUpload(_loc2_.entityId,_loc2_.entityType,_loc2_.entityId,_loc2_.photoToShare);
         }
         else
         {
            _loc3_ = new FriendDisplayer(_loc2_.entityId,_loc2_.entityType,_loc2_.entityId);
         }
         WindowStack.showViewStackable(_loc3_,_loc2_.x,_loc2_.y,WindowStack.Z_INFO);
      }
   }
}

import com.moviestarplanet.clientcensor.textfield.TextFieldInputRestricted;
import com.moviestarplanet.utils.input.InputAreaInterface;
import flash.display.Sprite;
import flash.events.Event;

class InputAreaInterfaceWrapper implements InputAreaInterface
{
   
   private var color:Sprite;
   
   private var emot:Sprite;
   
   private var field:TextFieldInputRestricted;
   
   public function InputAreaInterfaceWrapper(param1:Object)
   {
      super();
      this.color = param1.color;
      this.emot = param1.emot;
      this.field = param1.field;
   }
   
   public function get fontColorButton() : Sprite
   {
      return this.color;
   }
   
   public function get emoticonBtn() : Sprite
   {
      return this.emot;
   }
   
   public function get textArea() : TextFieldInputRestricted
   {
      return this.field;
   }
   
   public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
   {
      this.textArea.addEventListener(param1,param2,param3,param4,param5);
   }
   
   public function dispatchEvent(param1:Event) : Boolean
   {
      return this.textArea.dispatchEvent(param1);
   }
   
   public function hasEventListener(param1:String) : Boolean
   {
      return this.textArea.hasEventListener(param1);
   }
   
   public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
   {
      this.textArea.removeEventListener(param1,param2,param3);
   }
   
   public function willTrigger(param1:String) : Boolean
   {
      return this.textArea.willTrigger(param1);
   }
}
