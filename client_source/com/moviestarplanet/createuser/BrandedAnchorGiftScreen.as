package com.moviestarplanet.createuser
{
   import com.moviestarplanet.SpecialCharacters.SpCharGraphicsManager;
   import com.moviestarplanet.assetManager.externalHelpers.DisplayObjectExtractor;
   import com.moviestarplanet.awarding.valueobjects.AwardingInfo;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.flash.icons.ScreenIcons;
   import com.moviestarplanet.msg.EventController;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import com.moviestarplanet.window.stack.WindowStack;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   
   public class BrandedAnchorGiftScreen extends Sprite
   {
      
      private static var BRANDED_LOGO_READY:String = "BRANDED_LOGO_READY";
      
      private static var UI_READY:String = "UI_READY";
      
      private var gfx:Sprite;
      
      public var imagePlaceHolder:Sprite;
      
      public var GfxCountry:MovieClip;
      
      public var requestTitle:TextField;
      
      public var Close:Sprite;
      
      public var gift1:MovieClip;
      
      public var gift2:MovieClip;
      
      public var gift3:MovieClip;
      
      public var gift4:MovieClip;
      
      public var avatarPlaceHolder:Sprite;
      
      protected var eventController:EventController;
      
      protected var eventdispatcher:EventDispatcher;
      
      private var brandedLogo:DisplayObject;
      
      private var closeButton:MovieClip;
      
      protected var actorId:int;
      
      private var giftLogicMap:Object;
      
      private var gifts:Array;
      
      public function BrandedAnchorGiftScreen(param1:int, param2:Array)
      {
         super();
         this.gifts = param2;
         this.actorId = param1;
         this.giftLogicMap = new Object();
         this.eventdispatcher = new EventDispatcher();
         this.eventController = new EventController();
         this.eventController.listenForEvent(this.eventdispatcher,UI_READY);
         this.eventController.listenForEvent(this.eventdispatcher,BRANDED_LOGO_READY);
         this.eventController.notifyMe(this.onAllReady);
         visible = false;
      }
      
      public function show() : void
      {
         MSP_SWFLoader.RequestLoad(new AssetUrl("anchorCharacters/SponsoredCharacters_Gifts.swf",AssetUrl.SWF),this.uiLoaded,MSP_LoaderManager.PRIORITY_UI);
         SpCharGraphicsManager.loadSponsoredCharacterGraphic(this.actorId,SpCharGraphicsManager.LOGO_WEB_GIFTS,this.onLogoLoaded);
      }
      
      private function onLogoLoaded(param1:DisplayObject) : void
      {
         this.brandedLogo = param1;
         this.eventdispatcher.dispatchEvent(new Event(BRANDED_LOGO_READY));
      }
      
      private function uiLoaded(param1:MSP_SWFLoader) : void
      {
         this.gfx = param1.content as Sprite;
         DisplayObjectExtractor.extract(this.gfx,this);
         this.gift1.visible = this.gift2.visible = this.gift3.visible = this.gift4.visible = false;
         this.GfxCountry.gotoAndStop(Config.overrideLanguage);
         this.requestTitle.text = this.headlineText;
         FontManager.remapFonts(this.requestTitle);
         this.closeButton = new ScreenIcons.CloseIcon();
         FlashInstanceUtils.addItemToInstance(this.closeButton,this.Close,true,true,true,true);
         Buttonizer.buttonizeFrames(this.closeButton,this.onCloseClick);
         addChild(this.gfx);
         this.eventdispatcher.dispatchEvent(new Event(UI_READY));
      }
      
      protected function get headlineText() : String
      {
         return MSPLocaleManagerWeb.getInstance().getString("SPONSOR_GIFTS_HEADLINE");
      }
      
      private function onCloseClick(param1:MouseEvent) : void
      {
         var _loc2_:NewPlayerExperienceGift = null;
         var _loc3_:AwardingInfo = null;
         Buttonizer.setButtonizedEnabled(this.closeButton,false);
         Buttonizer.unbuttonizeFrames(this.gift1,this.giftClicked);
         Buttonizer.unbuttonizeFrames(this.gift2,this.giftClicked);
         Buttonizer.unbuttonizeFrames(this.gift3,this.giftClicked);
         Buttonizer.unbuttonizeFrames(this.gift4,this.giftClicked);
         for each(_loc2_ in this.giftLogicMap)
         {
            _loc3_ = new AwardingInfo(this.gifts.pop());
            _loc2_.open(_loc3_);
         }
         setTimeout(this.close,2500);
      }
      
      protected function close() : void
      {
         Buttonizer.unbuttonizeFrames(this.gift1,this.giftClicked);
         Buttonizer.unbuttonizeFrames(this.gift2,this.giftClicked);
         Buttonizer.unbuttonizeFrames(this.gift3,this.giftClicked);
         Buttonizer.unbuttonizeFrames(this.gift4,this.giftClicked);
         Buttonizer.unbuttonizeFrames(this.closeButton,this.onCloseClick);
         WindowStack.removeSpriteViewStackable(this);
         removeChildren();
         this.giftLogicMap = null;
         this.gifts = null;
         if(this.eventController != null)
         {
            this.eventController.destroy();
            this.eventController = null;
            this.eventdispatcher = null;
         }
      }
      
      protected function onAllReady() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:NewPlayerExperienceGift = null;
         if(this.gifts == null)
         {
            this.close();
            return;
         }
         var _loc1_:int = 1;
         while(_loc1_ < this.gifts.length + 1)
         {
            _loc2_ = this["gift" + _loc1_];
            _loc3_ = new NewPlayerExperienceGift(_loc2_);
            this.giftLogicMap[_loc2_.name] = _loc3_;
            _loc2_.visible = true;
            Buttonizer.buttonizeFrames(_loc2_,this.giftClicked);
            _loc1_++;
         }
         this.imagePlaceHolder.removeChildren();
         this.imagePlaceHolder.addChild(this.brandedLogo);
         visible = true;
         WindowStack.showSpriteAsViewStackable(this,500,100,WindowStack.Z_NOTICE);
      }
      
      private function giftClicked(param1:MouseEvent) : void
      {
         Buttonizer.unbuttonizeFrames(param1.target as MovieClip,this.giftClicked);
         var _loc2_:NewPlayerExperienceGift = this.giftLogicMap[param1.target.name];
         var _loc3_:AwardingInfo = new AwardingInfo(this.gifts.pop());
         _loc2_.open(_loc3_);
         delete this.giftLogicMap[param1.target.name];
         if(this.gifts.length == 0)
         {
            setTimeout(this.close,2500);
         }
      }
   }
}

