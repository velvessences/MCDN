package com.moviestarplanet.dailyCompetition
{
   import com.moviestarplanet.award.visualization.IAwardSpawner;
   import com.moviestarplanet.award.visualization.IMobileAwardSpawner;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.dailyCompetition.graphics.GraphicProvider;
   import com.moviestarplanet.dailyCompetition.service.DailyCompetitionAmfService;
   import com.moviestarplanet.dailyCompetition.service.valueObjects.DailyThemeItem;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.icons.NavigationIcons;
   import com.moviestarplanet.flash.icons.ScreenIcons;
   import com.moviestarplanet.gamescaleutils.ScreenSize;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.mangroveanalytics.MangroveAnalytics;
   import com.moviestarplanet.mangroveanalytics.constants.EntityActionEventConst;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.utils.ClickBlocker;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.displayobject.DisplayObjectAddUtilities;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtil;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import com.moviestarplanet.window.stack.WindowFloatingInterface;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import starling.core.Starling;
   import starling.display.Quad;
   
   public class SubmitToCompetitionPopup extends Sprite implements WindowFloatingInterface
   {
      
      private var _actorId:Number;
      
      private var _localeManager:ILocaleManager;
      
      private var _graphicsProvider:GraphicProvider;
      
      private var _type:int;
      
      private var _contentID:int;
      
      private var _closeCallBack:Function;
      
      private var _closeButton:MovieClip;
      
      private var _yesButton:MovieClip;
      
      private var _noButton:MovieClip;
      
      private var _clickBlocker:Quad;
      
      private const DESIGN:int = 22;
      
      private const LOOK:int = 1;
      
      private const ARTBOOK:int = 7;
      
      private const MOVIE:int = 3;
      
      [Inject]
      public var award:IAwardSpawner;
      
      [Inject]
      public var _mobileAwardSpawner:IMobileAwardSpawner;
      
      public function SubmitToCompetitionPopup(param1:Function, param2:int, param3:int, param4:int, param5:ILocaleManager)
      {
         super();
         this._closeCallBack = param1;
         this._type = param2;
         this._actorId = param3;
         this._localeManager = param5;
         this._contentID = param4;
         InjectionManager.manager().injectMe(this);
         this.setBundle(new GraphicProvider());
      }
      
      public function setBundle(param1:GraphicProvider) : void
      {
         param1.sourceLoad(this.bundleReady);
      }
      
      private function bundleReady(param1:GraphicProvider) : void
      {
         var loaded:Function = null;
         var rect:Rectangle = null;
         var graphicsprovider:GraphicProvider = param1;
         loaded = function(param1:MSP_FlashLoader):void
         {
            FlashInstanceUtils.addItemToInstance(param1.content,_graphicsProvider.submitParser.designContainer,true,true,true,true);
         };
         this.GrayBackground();
         this._graphicsProvider = graphicsprovider;
         this._graphicsProvider.submitWindow().visible = true;
         this._graphicsProvider.rateWindow().visible = false;
         addChild(this._graphicsProvider.container());
         if(ConstantsPlatform.isMobile)
         {
            this._graphicsProvider.container().height = ScreenSize.fullScreenHeight * 0.8;
            this._graphicsProvider.container().scaleX = this._graphicsProvider.container().scaleY;
            rect = DisplayObjectUtil.getVisibleBounds(this._graphicsProvider.container());
            this._graphicsProvider.container().x = (ScreenSize.fullScreenWidth - rect.width * this._graphicsProvider.container().scaleX) / 2;
            this._graphicsProvider.container().y = (ScreenSize.fullScreenHeight - rect.height * this._graphicsProvider.container().scaleY) / 2;
            this._graphicsProvider.container().x = this._graphicsProvider.container().x - rect.left * this._graphicsProvider.container().scaleX;
            this._clickBlocker = ClickBlocker.createClickBlockerStarling(ScreenSize.fullScreenWidth,ScreenSize.fullScreenHeight);
            Starling.current.stage.addChild(this._clickBlocker);
         }
         this.buttonize();
         this.translate();
         this._graphicsProvider.timerLeftPopup().visible = false;
         this._graphicsProvider.timerLeft().visible = false;
         this._graphicsProvider.timerText().visible = false;
         switch(this._type)
         {
            case this.DESIGN:
               FlashInstanceUtils.loadFlashInstanceNew(new SnapshotUrl(this._contentID,SnapshotUrl.DESIGN,"design"),loaded);
               break;
            case this.ARTBOOK:
               FlashInstanceUtils.loadFlashInstanceNew(new SnapshotUrl(this._contentID,SnapshotUrl.SCRAPBLOG,"scrapblog"),loaded);
               break;
            case this.LOOK:
               FlashInstanceUtils.loadFlashInstanceNew(new SnapshotUrl(this._contentID,SnapshotUrl.LOOK,"look"),loaded);
               break;
            case this.MOVIE:
               FlashInstanceUtils.loadFlashInstanceNew(new SnapshotUrl(this._contentID,SnapshotUrl.MOVIE,"movie"),loaded);
         }
      }
      
      private function buttonize() : void
      {
         if(ConstantsPlatform.isWeb)
         {
            this._closeButton = new ScreenIcons.CloseIcon() as MovieClip;
         }
         else
         {
            this._closeButton = new NavigationIcons.Close() as MovieClip;
         }
         if(ConstantsPlatform.isMobile)
         {
            this._yesButton = this._graphicsProvider.submitParser.yesButtonMobile;
            this._noButton = this._graphicsProvider.submitParser.noButtonMobile;
            this._graphicsProvider.submitParser.yesButton.visible = false;
            this._graphicsProvider.submitParser.noButton.visible = false;
         }
         else
         {
            this._yesButton = this._graphicsProvider.submitParser.yesButton;
            this._noButton = this._graphicsProvider.submitParser.noButton;
            this._graphicsProvider.submitParser.yesButtonMobile.visible = false;
            this._graphicsProvider.submitParser.noButtonMobile.visible = false;
         }
         DisplayObjectAddUtilities.addAtPlaceholder(this._closeButton,this._graphicsProvider.closeButton(),this._graphicsProvider.container());
         Buttonizer.buttonizeFrames(this._closeButton,this.clickClose);
         Buttonizer.buttonizeFrames(this._yesButton,this.clickYes);
         Buttonizer.buttonizeFrames(this._noButton,this.clickClose);
      }
      
      private function GrayBackground() : void
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.lineStyle(0,0,0);
         _loc1_.graphics.beginFill(0,0.35);
         if(ConstantsPlatform.isWeb)
         {
            _loc1_.graphics.drawRect(-1000,-750,1980,1500);
         }
         else
         {
            _loc1_.graphics.drawRect(0,0,ScreenSize.fullScreenWidth,ScreenSize.fullScreenHeight);
         }
         _loc1_.graphics.endFill();
         _loc1_.x = 0;
         _loc1_.y = 0;
         addChild(_loc1_);
      }
      
      private function clickClose(param1:MouseEvent = null) : void
      {
         if(ConstantsPlatform.isMobile)
         {
            Starling.current.stage.removeChild(this._clickBlocker);
            this._clickBlocker = null;
         }
         Buttonizer.unbuttonizeFrames(this._closeButton,this.clickClose);
         Buttonizer.unbuttonizeFrames(this._yesButton,this.clickYes);
         Buttonizer.unbuttonizeFrames(this._noButton,this.clickClose);
         this._graphicsProvider.countDown.clearCallback();
         this._graphicsProvider.submitParser.designContainer.removeChildren();
         this._graphicsProvider.destroy();
         this._graphicsProvider = null;
         this._closeButton = null;
         this._yesButton = null;
         this._noButton = null;
         this.award = null;
         this._mobileAwardSpawner = null;
         this._localeManager = null;
         removeChildren();
         this._closeCallBack();
         this._closeCallBack = null;
      }
      
      private function clickYes(param1:MouseEvent = null) : void
      {
         var submitted:Function = null;
         var event:MouseEvent = param1;
         submitted = function(param1:int):void
         {
            submitToMangrove(_type,_contentID,param1);
            DailyCompetitionVoteController.onNewContentSubmitted(_actorId);
            var _loc2_:Point = localToGlobal(new Point(_yesButton.x + _yesButton.width / 2,_yesButton.y + _yesButton.height / 2));
            if(ConstantsPlatform.isWeb)
            {
               award.spawnAwardsNonStatic(_loc2_.x,_loc2_.y,0,param1,0,false);
            }
            else
            {
               _mobileAwardSpawner.addAwards(0,param1,0);
            }
            clickClose();
         };
         Buttonizer.unbuttonizeFrames(this._yesButton,this.clickYes);
         if(this._type == this.LOOK)
         {
            MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.CREATE_AND_RATE_SUBMIT_RATINGS));
         }
         DailyCompetitionAmfService.addToComp(submitted,this._actorId,this._type,this._contentID);
      }
      
      private function submitToMangrove(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:String = null;
         if(param1 == this.LOOK)
         {
            _loc4_ = EntityActionEventConst.ENTITY_LOOK;
         }
         else if(param1 == this.DESIGN)
         {
            _loc4_ = EntityActionEventConst.ENTITY_DESIGN;
         }
         else if(param1 == this.ARTBOOK)
         {
            _loc4_ = EntityActionEventConst.ENTITY_ARTBOOK;
         }
         else if(param1 == this.MOVIE)
         {
            _loc4_ = EntityActionEventConst.ENTITY_MOVIE;
         }
         MangroveAnalytics.registerSubmitCreateAndRate(_loc4_,param2,param3);
      }
      
      private function translate() : void
      {
         var themeCallback:Function;
         var themeName:String = null;
         var setTexts:Function = function():void
         {
            var _loc1_:String = getContent();
            _graphicsProvider.mainParser.headline.selectable = false;
            _graphicsProvider.mainParser.headline.htmlText = themeName;
            var _loc2_:TextFormat = new TextFormat();
            _loc2_.bold = true;
            _loc2_.italic = true;
            _graphicsProvider.mainParser.headline.setTextFormat(_loc2_);
            _graphicsProvider.submitParser.headline.selectable = false;
            _graphicsProvider.submitParser.headline.text = _localeManager.getString("CREATE_RATE_SUBMIT_HEADER",[_loc1_.toUpperCase()]);
            _graphicsProvider.submitParser.description.selectable = false;
            if(DailyCompetition.SHOW_DAILY_THEME_NAME)
            {
               _graphicsProvider.submitParser.description.text = _localeManager.getString("CREATE_RATE_SUBMIT_DESC",[_loc1_,themeName]);
            }
            else
            {
               _graphicsProvider.submitParser.description.text = _localeManager.getString("CREATE_RATE_SUBMIT_DESC",[_loc1_]);
            }
            FontManager.remapFonts(_graphicsProvider.mainParser.headline);
            FontManager.remapAllFontsForDisplayObject(_graphicsProvider.submitWindow());
         };
         themeName = "";
         if(DailyCompetition.SHOW_DAILY_THEME_NAME)
         {
            themeCallback = function(param1:DailyThemeItem):void
            {
               themeName = _localeManager.getString(param1.Name);
               setTexts();
            };
            DailyCompetitionAmfService.getTodaysTheme(themeCallback);
         }
         else
         {
            setTexts();
         }
         this._graphicsProvider.timerText().selectable = false;
         this._graphicsProvider.timerText().text = this._localeManager.getString("CREATE_RATE_HOMEPAGE_BUTTON_VIEW_COMP_TIMER");
         FontManager.remapFonts(this._graphicsProvider.timerText());
         this._yesButton["buttenText"].text = this._localeManager.getString("CREATE_RATE_SUBMIT_BUTTON_YES");
         this._noButton["buttenText"].text = this._localeManager.getString("CREATE_RATE_SUBMIT_BUTTON_NO");
         FontManager.remapFonts(this._yesButton["buttenText"]);
         FontManager.remapFonts(this._noButton["buttenText"]);
      }
      
      private function getContent() : String
      {
         var _loc1_:String = "N/A";
         switch(this._type)
         {
            case this.LOOK:
               _loc1_ = this._localeManager.getString("LOOK");
               break;
            case this.MOVIE:
               _loc1_ = this._localeManager.getString("MOVIE");
               break;
            case this.ARTBOOK:
               _loc1_ = this._localeManager.getString("ARTBOOK");
               break;
            case this.DESIGN:
               _loc1_ = this._localeManager.getString("DESIGN");
         }
         return _loc1_;
      }
   }
}

