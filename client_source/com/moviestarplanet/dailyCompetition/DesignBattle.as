package com.moviestarplanet.dailyCompetition
{
   import com.moviestarplanet.analytics.IAnalytics;
   import com.moviestarplanet.analytics.IFeatureUsage;
   import com.moviestarplanet.assetManager.AssetBundle;
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.loaders.SWFs.SWFAssetLoader;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.constants.analytics.FeatureUsage;
   import com.moviestarplanet.constants.analytics.TimeSpentConstants;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.dailyCompetition.constants.DailyCompetitionContentTypes;
   import com.moviestarplanet.dailyCompetition.graphics.GraphicProvider;
   import com.moviestarplanet.dailyCompetition.service.DailyCompetitionAmfService;
   import com.moviestarplanet.dailyCompetition.service.valueObjects.DailyRateItem;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.icons.NavigationIcons;
   import com.moviestarplanet.flash.icons.ScreenIcons;
   import com.moviestarplanet.gamescaleutils.MeasurementConstants;
   import com.moviestarplanet.gamescaleutils.MeasurementUtils;
   import com.moviestarplanet.gamescaleutils.ScreenSize;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.managers.SoundManager;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.msg.events.ShopOffersEvent;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.displayobject.DisplayObjectAddUtilities;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtil;
   import com.moviestarplanet.utils.displayobject.FlattenUtilities;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.sound.Sounds;
   import com.moviestarplanet.utils.ui.FlashInstanceUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class DesignBattle extends Sprite implements IAnalytics, IFeatureUsage
   {
      
      private var _frameinstance:DisplayObjectContainer;
      
      private var _actorId:int;
      
      private var _nextCompetitionCallBack:Function;
      
      private var _localeManager:ILocaleManager;
      
      private var _closeCallBack:Function;
      
      private var _openCallBack:Function;
      
      private var _loveDesign1Button:MovieClip;
      
      private var _loveDesign2Button:MovieClip;
      
      private var _loveLook1Button:MovieClip;
      
      private var _loveLook2Button:MovieClip;
      
      private var _designName1:TextField;
      
      private var _designName2:TextField;
      
      private var _lookName1:TextField;
      
      private var _lookName2:TextField;
      
      private var _designContainer1:MovieClip;
      
      private var _designContainer2:MovieClip;
      
      private var _buyLook1:MovieClip;
      
      private var _buyLook2:MovieClip;
      
      private var _buyButtonsShow:Boolean = false;
      
      private var _loveBars1:MovieClip;
      
      private var _loveBars2:MovieClip;
      
      private var _lookContainer1:MovieClip;
      
      private var _lookContainer2:MovieClip;
      
      private var _ratingBar1:MovieClip;
      
      private var _ratingBar2:MovieClip;
      
      private var _ratingText1:TextField;
      
      private var _ratingText2:TextField;
      
      private var _levelBarMC:MovieClip;
      
      private var _levelBar:LevelBar;
      
      private var _levelNum:TextField;
      
      private var _fameStarAnim:MovieClip;
      
      private var _skipButton:MovieClip;
      
      private var _skipButtonText:TextField;
      
      private var _skipButtonShow:Boolean = false;
      
      private var _nextBattleTimer:Timer = new Timer(1500,1);
      
      private var _contentReady:int = 0;
      
      private var _dailyCompetition:DailyCompetition;
      
      private var _dailyRateItem:DailyRateItem;
      
      private var _designLocalPos:Point;
      
      private var _lookLocalPos:Point;
      
      private var _contentRotator:ContentRotator;
      
      private var _ratingBarsAnimation:RatingBarsAnimation;
      
      private var _chosenContentScaler:ChosenContentScaler;
      
      private var _closeButton:MovieClip;
      
      private var _closeButtonPlaceholder:MovieClip;
      
      private var _old_dual_type:int;
      
      private var _graphicsProvider:GraphicProvider;
      
      private var background:Sprite;
      
      private var _themeName:String;
      
      private var hintField:MovieClip;
      
      private var blockVoting:Boolean;
      
      [Inject]
      public var localeManager:ILocaleManager;
      
      private var hintFieldText:TextField;
      
      private var hintFieldTextCorrect:TextField;
      
      private const HINTFIELD_POSITION_X:Number = 317;
      
      private const HINTFIELD_POSITION_Y:Number = 380;
      
      private const HINTFIELD_POSITION_Y_MOBILE:Number = 335;
      
      private const HINT_INITIAL:int = 0;
      
      private const HINT_CORRECT:int = 1;
      
      private const HINT_WRONG:int = 2;
      
      private var textLocaleHintLook:String;
      
      private var textLocaleHintDesign:String;
      
      private var textLocaleHintInitial:String;
      
      private var textLocaleHintCorrect:String;
      
      private var textLocaleHintWrong:String;
      
      private var bundleLoader:AssetBundle;
      
      private var votedForPlayer1:Boolean;
      
      private var idVotedFor:int;
      
      private var idNotVotedFor:int;
      
      private var isCorrect:Boolean;
      
      private var framesWaited:int;
      
      private var _isRotating:Boolean = false;
      
      public function DesignBattle(param1:Function, param2:Function, param3:DailyCompetition, param4:DailyRateItem)
      {
         super();
         InjectionManager.manager().injectMe(this);
         this.setLocales();
         this._dailyRateItem = param4;
         this._dailyCompetition = param3;
         this._closeCallBack = param2;
         this._openCallBack = param1;
         this._chosenContentScaler = new ChosenContentScaler(this.onChosenContentScalingDone);
         var _loc5_:String = "dailycompetition/HintfField.swf";
         var _loc6_:String = "dailycompetition/DesignBattleScreen_02.swf";
         this.bundleLoader = new AssetBundle(this.doneBundle);
         this.bundleLoader.addLoader(AssetManager.createLoaderForSWF(new AssetUrl(_loc6_,AssetUrl.SWF),this.loadDone));
         this.bundleLoader.addLoader(AssetManager.createLoaderForSWF(new AssetUrl(_loc5_,AssetUrl.SWF),this.hintLoadDone));
         this.bundleLoader.load();
      }
      
      private function loadDone(param1:SWFAssetLoader) : void
      {
         this._frameinstance = param1.getSWF();
      }
      
      private function hintLoadDone(param1:SWFAssetLoader) : void
      {
         this.hintField = MovieClip(param1.getSWF());
      }
      
      private function doneBundle(param1:AssetBundle) : void
      {
         this.grayBackground();
         addChild(this._frameinstance);
         if(DailyCompetition.SHOW_DAILY_THEME_NAME)
         {
            this._themeName = this._localeManager.getString(this._dailyRateItem.ThemeName);
         }
         else
         {
            this._themeName = null;
         }
         this.mapInstances();
         if(ConstantsPlatform.isMobile)
         {
            this._loveBars1.y -= 10;
            this._loveBars2.y -= 10;
         }
         this._designLocalPos = this._designContainer1.globalToLocal(this._designContainer1.parent.localToGlobal(new Point(0,0)));
         this._lookLocalPos = this._lookContainer1.globalToLocal(this._lookContainer1.parent.localToGlobal(new Point(0,0)));
         this._contentRotator = new ContentRotator(this._designContainer1,this._designContainer2,this._lookContainer1,this._lookContainer2,this._loveDesign1Button,this._loveDesign2Button,this._loveLook1Button,this._loveLook2Button,this.contentContainersDoneRotating,this.contentContainerRotatedHalfway);
         this._ratingBarsAnimation = new RatingBarsAnimation(this.nextBattle,this._ratingBar1,this._ratingBar2,this._ratingText1,this._ratingText2);
         this.startBattle();
         DailyCompetition.hide();
         if(this._openCallBack != null)
         {
            this._openCallBack();
         }
         FlattenUtilities.flattenSprite(this._lookContainer1.parent.getChildByName("backgroundGraphics") as Sprite);
         FlattenUtilities.flattenSprite(this._lookContainer2.parent.getChildByName("backgroundGraphics") as Sprite);
         FlattenUtilities.flattenSprite(this._designContainer1.parent.getChildByName("backgroundGraphics") as Sprite);
         FlattenUtilities.flattenSprite(this._designContainer2.parent.getChildByName("backgroundGraphics") as Sprite);
         this.addScrollRectsToContentContainers();
         this.hintField.HintField.gotoAndStop("Green");
         addChild(this.hintField);
         this.hintField.x = this.HINTFIELD_POSITION_X;
         this.hintField.y = ConstantsPlatform.isWeb ? this.HINTFIELD_POSITION_Y : this.HINTFIELD_POSITION_Y_MOBILE;
         this.hintFieldText = this.hintField["HintField"]["textfield"];
         this.hintFieldTextCorrect = this.hintField["HintField"]["TxtCorrect"];
         FontManager.remapFonts(this.hintFieldText);
         FontManager.remapFonts(this.hintFieldTextCorrect);
         this.hintFieldTextCorrect.text = this.textLocaleHintCorrect;
         this.setHintFieldText(this.HINT_INITIAL);
      }
      
      private function addScrollRectsToContentContainers() : void
      {
         this._lookContainer1.parent.parent.scrollRect = new Rectangle(0,-this._lookContainer1.parent.height * 0.1,this._lookContainer1.parent.width * 1.2,this._lookContainer1.parent.height * 1.2);
         this._lookContainer1.parent.parent.y -= this._lookContainer1.parent.height * 0.1;
         this._lookContainer2.parent.parent.scrollRect = new Rectangle(-this._lookContainer2.parent.width * 0.1,-this._lookContainer2.parent.height * 0.1,this._lookContainer2.parent.width * 1.2,this._lookContainer2.parent.height * 1.2);
         this._lookContainer2.parent.parent.y -= this._lookContainer2.parent.height * 0.1;
         this._lookContainer2.parent.parent.x -= this._lookContainer2.parent.width * 0.1;
         this._designContainer1.parent.parent.scrollRect = new Rectangle(-this._designContainer2.parent.width * 0.1,-this._designContainer1.parent.height * 0.1,this._designContainer1.parent.width * 1.2,this._designContainer1.parent.height * 1.2);
         this._designContainer1.parent.parent.y -= this._designContainer1.parent.height * 0.1;
         this._designContainer1.parent.parent.x -= this._designContainer1.parent.width * 0.1;
         this._designContainer2.parent.parent.scrollRect = new Rectangle(0,-this._designContainer2.parent.height * 0.1,this._designContainer2.parent.width * 1.2,this._designContainer2.parent.height * 1.2);
         this._designContainer2.parent.parent.y -= this._designContainer2.parent.height * 0.1;
      }
      
      private function setLocales() : void
      {
         this.textLocaleHintLook = this.localeManager.getString("CREATE_RATE_HOMEPAGE_HINT_LOOKS");
         this.textLocaleHintDesign = this.localeManager.getString("CREATE_RATE_HOMEPAGE_HINT_DESIGNS");
         this.textLocaleHintInitial = this.localeManager.getString("CREATE_RATE_WHICHONE");
         this.textLocaleHintCorrect = this.localeManager.getString("CREATE_RATE_CORRECT");
         this.textLocaleHintWrong = this.localeManager.getString("CREATE_RATE_BETTERLUCK");
      }
      
      public function set actorId(param1:int) : void
      {
         this._actorId = param1;
      }
      
      public function set locale(param1:ILocaleManager) : void
      {
         this._localeManager = param1;
      }
      
      private function grayBackground() : void
      {
         this.background = new Sprite();
         this.background.graphics.lineStyle(0,0,0);
         this.background.graphics.beginFill(0,0.7);
         this.background.graphics.drawRect(0,0,980,500);
         this.background.graphics.endFill();
         this.background.x = 0;
         this.background.y = 0;
         addChild(this.background);
      }
      
      private function setHintFieldText(param1:int) : void
      {
         if(this.hintFieldText != null && this.hintFieldTextCorrect != null)
         {
            switch(param1)
            {
               case this.HINT_INITIAL:
                  this.hintFieldText.text = this.textLocaleHintInitial;
                  this.hintFieldTextCorrect.visible = false;
                  this.hintFieldText.visible = true;
                  break;
               case this.HINT_CORRECT:
                  this.hintFieldTextCorrect.text = this.textLocaleHintCorrect;
                  this.hintFieldTextCorrect.visible = true;
                  this.hintFieldText.visible = false;
                  break;
               case this.HINT_WRONG:
                  this.hintFieldText.text = this.textLocaleHintWrong;
            }
         }
      }
      
      private function initLoadSnapshot1(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObject = null;
         _loc2_ = param1["content"];
         if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.LOOK)
         {
            _loc2_.scaleX = 0.5;
            _loc2_.scaleY = 0.5;
            _loc2_.x = this._lookLocalPos.x - _loc2_.width / 2;
            _loc2_.y = this._lookLocalPos.y - _loc2_.height / 2;
            this._lookContainer1.addChild(_loc2_);
         }
         else if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.DESIGN)
         {
            _loc2_.scaleX = 0.5;
            _loc2_.scaleY = 0.5;
            _loc2_.x = this._designLocalPos.x - _loc2_.width / 2;
            _loc2_.y = this._designLocalPos.y - _loc2_.height / 2;
            this._designContainer1.addChild(_loc2_);
         }
      }
      
      private function initLoadSnapshot2(param1:DisplayObject) : void
      {
         if(this._dailyCompetition == null)
         {
            return;
         }
         var _loc2_:DisplayObject = param1["content"];
         if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.LOOK)
         {
            _loc2_.scaleX = -0.5;
            _loc2_.scaleY = 0.5;
            _loc2_.x = this._lookLocalPos.x + _loc2_.width / 2;
            _loc2_.y = this._lookLocalPos.y - _loc2_.height / 2;
            this._lookContainer2.addChild(_loc2_);
         }
         else if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.DESIGN)
         {
            _loc2_.scaleX = 0.5;
            _loc2_.scaleY = 0.5;
            _loc2_.x = this._designLocalPos.x - _loc2_.width / 2;
            _loc2_.y = this._designLocalPos.y - _loc2_.height / 2;
            this._designContainer2.addChild(_loc2_);
         }
      }
      
      private function loadSnapshot1(param1:DisplayObject) : void
      {
         if(this._dailyCompetition == null)
         {
            return;
         }
         var _loc2_:DisplayObject = param1["content"];
         if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.LOOK)
         {
            this._lookContainer1.addChild(_loc2_);
            _loc2_.scaleX = 0.5;
            _loc2_.scaleY = 0.5;
            _loc2_.x = this._lookLocalPos.x - _loc2_.width / 2;
            _loc2_.y = this._lookLocalPos.y - _loc2_.height / 2;
         }
         else if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.DESIGN)
         {
            this._designContainer1.addChild(_loc2_);
            _loc2_.scaleX = 0.5;
            _loc2_.scaleY = 0.5;
            _loc2_.x = this._designLocalPos.x - _loc2_.width / 2;
            _loc2_.y = this._designLocalPos.y - _loc2_.height / 2;
         }
         _loc2_.visible = false;
         ++this._contentReady;
         if(this._contentReady == 2)
         {
            this._contentRotator.startRotating(this._dailyRateItem.ContentType,this._old_dual_type);
            this._isRotating = true;
         }
      }
      
      private function loadSnapshot2(param1:DisplayObject) : void
      {
         if(this._dailyRateItem == null)
         {
            return;
         }
         var _loc2_:DisplayObject = param1["content"];
         if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.LOOK)
         {
            this._lookContainer2.addChild(_loc2_);
            _loc2_.scaleX = -0.5;
            _loc2_.scaleY = 0.5;
            _loc2_.x = this._lookLocalPos.x + _loc2_.width / 2;
            _loc2_.y = this._lookLocalPos.y - _loc2_.height / 2;
         }
         else if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.DESIGN)
         {
            this._designContainer2.addChild(_loc2_);
            _loc2_.scaleX = 0.5;
            _loc2_.scaleY = 0.5;
            _loc2_.x = this._designLocalPos.x - _loc2_.width / 2;
            _loc2_.y = this._designLocalPos.y - _loc2_.height / 2;
         }
         _loc2_.visible = false;
         ++this._contentReady;
         if(this._contentReady == 2)
         {
            this._contentRotator.startRotating(this._dailyRateItem.ContentType,this._old_dual_type);
            this._isRotating = true;
         }
      }
      
      private function waitForNextCompetition(param1:TimerEvent) : void
      {
         this._old_dual_type = this._dailyRateItem.ContentType;
         this._dailyCompetition.openNextCompetition();
      }
      
      public function startNextBattle(param1:DailyRateItem) : void
      {
         this._dailyRateItem = param1;
         DailyCompetition.hide();
         this.setHintFieldText(this.HINT_INITIAL);
         addEventListener(Event.ENTER_FRAME,this.hideRatingBars);
      }
      
      private function hideRatingBars(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.hideRatingBars);
         this._ratingBarsAnimation.hideRatingBars();
      }
      
      private function nextBattle() : void
      {
         this._ratingText1.text = "";
         this._ratingText2.text = "";
         this.pickNewDesigns();
         if(this._buyButtonsShow)
         {
            this._buyLook1.visible = false;
            this._buyLook2.visible = false;
         }
      }
      
      private function pickNewDesigns() : void
      {
         this._contentReady = 0;
         if(this._dailyRateItem.ContentType == 1)
         {
            MSP_FlashLoader.RequestLoad(new SnapshotUrl(this._dailyRateItem.IdA,SnapshotUrl.LOOK,"fullSizeLook"),this.loadSnapshot1,MSP_LoaderManager.PRIORITY_UI,true,true,this.loadFailed);
            MSP_FlashLoader.RequestLoad(new SnapshotUrl(this._dailyRateItem.IdB,SnapshotUrl.LOOK,"fullSizeLook"),this.loadSnapshot2,MSP_LoaderManager.PRIORITY_UI,true,true,this.loadFailed);
         }
         else
         {
            MSP_FlashLoader.RequestLoad(new SnapshotUrl(this._dailyRateItem.IdA,SnapshotUrl.DESIGN,"design"),this.loadSnapshot1,MSP_LoaderManager.PRIORITY_UI,true,true,this.loadFailed);
            MSP_FlashLoader.RequestLoad(new SnapshotUrl(this._dailyRateItem.IdB,SnapshotUrl.DESIGN,"design"),this.loadSnapshot2,MSP_LoaderManager.PRIORITY_UI,true,true,this.loadFailed);
         }
      }
      
      private function loadFailed(param1:MSP_FlashLoader) : void
      {
         ++this._contentReady;
         if(this._contentReady == 2 && this._contentRotator != null)
         {
            this._contentRotator.startRotating(this._dailyRateItem.ContentType,this._old_dual_type);
            this._isRotating = true;
         }
      }
      
      private function contentContainersDoneRotating() : void
      {
         this._isRotating = false;
         this.addButtonListeners();
         this.blockVoting = false;
      }
      
      private function startBattle() : void
      {
         this._ratingText1.text = "";
         this._ratingText2.text = "";
         FontManager.remapFonts(this._ratingText1);
         FontManager.remapFonts(this._ratingText2);
         FontManager.remapFonts(this._lookName1);
         FontManager.remapFonts(this._lookName2);
         FontManager.remapFonts(this._designName1);
         FontManager.remapFonts(this._designName2);
         this._lookContainer1.removeChildren();
         this._lookContainer2.removeChildren();
         this._designContainer1.removeChildren();
         this._designContainer2.removeChildren();
         if(this._dailyRateItem.ContentType == 1)
         {
            this._designContainer1.parent.visible = false;
            this._designContainer2.parent.visible = false;
         }
         else
         {
            this._lookContainer1.parent.visible = false;
            this._lookContainer2.parent.visible = false;
         }
         if(this._dailyRateItem.ContentType == 1)
         {
            FlashInstanceUtils.loadFlashInstanceNew(new SnapshotUrl(this._dailyRateItem.IdA,SnapshotUrl.LOOK,"fullSizeLook"),this.initLoadSnapshot1);
            FlashInstanceUtils.loadFlashInstanceNew(new SnapshotUrl(this._dailyRateItem.IdB,SnapshotUrl.LOOK,"fullSizeLook"),this.initLoadSnapshot2);
         }
         else
         {
            FlashInstanceUtils.loadFlashInstanceNew(new SnapshotUrl(this._dailyRateItem.IdA,SnapshotUrl.DESIGN,"design"),this.initLoadSnapshot1);
            FlashInstanceUtils.loadFlashInstanceNew(new SnapshotUrl(this._dailyRateItem.IdB,SnapshotUrl.DESIGN,"design"),this.initLoadSnapshot2);
         }
         this.applyDesignNames();
         this.addButtonListeners();
      }
      
      private function applyDesignNames() : void
      {
         if(this._dailyRateItem.ContentType == 1)
         {
            this._lookName1.text = UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this._dailyRateItem.nameA);
            this._lookName2.text = UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this._dailyRateItem.nameB);
         }
         else
         {
            this._designName1.text = UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this._dailyRateItem.nameA);
            this._designName2.text = UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this._dailyRateItem.nameB);
         }
      }
      
      public function contentContainerRotatedHalfway() : void
      {
         this.applyDesignNames();
      }
      
      private function pressSkip(param1:Event) : void
      {
         if(this._skipButtonShow)
         {
            this._old_dual_type = this._dailyRateItem.ContentType;
            this.removeButtonListeners();
            this._skipButton.visible = false;
            this._dailyCompetition.openNextCompetition();
         }
      }
      
      private function pressVoteForPlayer1(param1:Event) : void
      {
         if(!this.blockVoting)
         {
            this.pressVote(true);
         }
      }
      
      private function pressVoteForPlayer2(param1:Event) : void
      {
         if(!this.blockVoting)
         {
            this.pressVote(false);
         }
      }
      
      private function pressVote(param1:Boolean) : void
      {
         this.votedForPlayer1 = param1;
         this.blockVoting = true;
         this.idVotedFor = this.getVotedForId(this.votedForPlayer1);
         this.idNotVotedFor = this.getVotedForId(!this.votedForPlayer1);
         if(this.votedForPlayer1)
         {
            this.isCorrect = this._dailyRateItem.ScoreA + 1 >= this._dailyRateItem.ScoreB;
         }
         else
         {
            this.isCorrect = this._dailyRateItem.ScoreB + 1 >= this._dailyRateItem.ScoreA;
         }
         if(this.isCorrect == false)
         {
            this._levelBar.answeredWrong();
            SoundManager.Instance().playSoundEffect(Sounds.CHAT_SEND);
         }
         else
         {
            SoundManager.Instance().playSoundEffect(Sounds.WHEEL);
         }
         this.scaleChosenContent();
         if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.LOOK)
         {
            MessageCommunicator.send(new MsgEvent(CareerQuestEvent.OBJECTIVE_PROGRESS,{
               "progress":1,
               "name":CareerQuestsGoToDestinations.VOTE_ON_FRIENDS_LOOK
            }));
         }
         this.removeButtonListeners();
         if(this._skipButtonShow)
         {
            this._skipButton.visible = false;
         }
         if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.LOOK)
         {
            if(param1)
            {
               this.changeToLoved(this._loveLook1Button);
            }
            else
            {
               this.changeToLoved(this._loveLook2Button);
            }
         }
         else if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.DESIGN)
         {
            if(param1)
            {
               this.changeToLoved(this._loveDesign1Button);
            }
            else
            {
               this.changeToLoved(this._loveDesign2Button);
            }
         }
      }
      
      private function scaleChosenContent() : void
      {
         var _loc1_:MovieClip = null;
         if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.LOOK)
         {
            if(this.votedForPlayer1)
            {
               _loc1_ = this._lookContainer1;
            }
            else
            {
               _loc1_ = this._lookContainer2;
            }
         }
         else if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.DESIGN)
         {
            if(this.votedForPlayer1)
            {
               _loc1_ = this._designContainer1;
            }
            else
            {
               _loc1_ = this._designContainer2;
            }
         }
         this._chosenContentScaler.onContentChosen(_loc1_,this.isCorrect);
      }
      
      private function onChosenContentScalingDone() : void
      {
         this._nextBattleTimer.addEventListener(TimerEvent.TIMER,this.waitForNextCompetition);
         this._nextBattleTimer.start();
         this.framesWaited = 0;
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameAfterVote);
      }
      
      private function onEnterFrameAfterVote(param1:Event) : void
      {
         if(this.framesWaited == 1)
         {
            if(this.isCorrect)
            {
               this.setHintFieldText(this.HINT_CORRECT);
            }
            else
            {
               this.setHintFieldText(this.HINT_WRONG);
            }
         }
         else if(this.framesWaited == 2)
         {
            this._levelBar.updateLevelBar(this.isCorrect);
         }
         else if(this.framesWaited == 3)
         {
            if(this.votedForPlayer1)
            {
               if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.LOOK)
               {
                  this._ratingBarsAnimation.showRatingBars(this._dailyRateItem.ScoreB,this._dailyRateItem.ScoreA + 1);
               }
               else if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.DESIGN)
               {
                  this._ratingBarsAnimation.showRatingBars(this._dailyRateItem.ScoreA + 1,this._dailyRateItem.ScoreB);
               }
               DailyCompetitionAmfService.voteFor(this.voteCallBack,this._actorId,this._dailyRateItem.ContentType,this._dailyRateItem.ThemeId,this.idVotedFor,this.idNotVotedFor);
            }
            else
            {
               if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.LOOK)
               {
                  this._ratingBarsAnimation.showRatingBars(this._dailyRateItem.ScoreB + 1,this._dailyRateItem.ScoreA);
               }
               else if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.DESIGN)
               {
                  this._ratingBarsAnimation.showRatingBars(this._dailyRateItem.ScoreA,this._dailyRateItem.ScoreB + 1);
               }
               DailyCompetitionAmfService.voteFor(this.voteCallBack,this._actorId,this._dailyRateItem.ContentType,this._dailyRateItem.ThemeId,this.idVotedFor,this.idNotVotedFor);
            }
         }
         else if(this.framesWaited == 4)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameAfterVote);
         }
         ++this.framesWaited;
      }
      
      private function getVotedForId(param1:Boolean) : int
      {
         if(param1)
         {
            return this._dailyRateItem.IdA;
         }
         return this._dailyRateItem.IdB;
      }
      
      private function changeToLoved(param1:MovieClip) : void
      {
         param1.gotoAndStop(4);
      }
      
      private function buyLook1Clicked(param1:MouseEvent) : void
      {
         MessageCommunicator.send(new MsgEvent(ShopOffersEvent.OPEN_SHOPPING_MODULE_WITH_LOOK,this._dailyRateItem.IdA));
      }
      
      private function buyLook2Clicked(param1:MouseEvent) : void
      {
         MessageCommunicator.send(new MsgEvent(ShopOffersEvent.OPEN_SHOPPING_MODULE_WITH_LOOK,this._dailyRateItem.IdB));
      }
      
      private function clickClose(param1:MouseEvent = null) : void
      {
         this._closeCallBack();
      }
      
      public function close() : void
      {
         this.removeButtonListeners();
         Buttonizer.unbuttonizeFrames(this._closeButton,this.clickClose);
         if(this._buyButtonsShow)
         {
            Buttonizer.unbuttonizeFrames(this._buyLook1,this.buyLook1Clicked);
            Buttonizer.unbuttonizeFrames(this._buyLook2,this.buyLook2Clicked);
         }
         this._nextBattleTimer.stop();
         removeEventListener(Event.ENTER_FRAME,this.hideRatingBars);
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameAfterVote);
         this._nextBattleTimer.removeEventListener(TimerEvent.TIMER,this.waitForNextCompetition);
         this._nextBattleTimer = null;
         this._contentRotator.removeListeners();
         this._contentRotator.destroy();
         this._contentRotator = null;
         this._ratingBarsAnimation.removeListeners();
         this._ratingBarsAnimation.destroy();
         this._ratingBarsAnimation = null;
         this._levelBar.removeListeners();
         this._levelBar.destroy();
         this._levelBar = null;
         this._dailyRateItem = null;
         this._chosenContentScaler.destroy();
         this._chosenContentScaler = null;
         this.bundleLoader.dispose();
         this.bundleLoader = null;
         this._designContainer1.parent.parent.removeChildren();
         this._designContainer2.parent.parent.removeChildren();
         this._lookContainer1.parent.parent.removeChildren();
         this._lookContainer2.parent.parent.removeChildren();
         this._nextCompetitionCallBack = null;
         this._closeCallBack = null;
         this._openCallBack = null;
         this._dailyCompetition = null;
      }
      
      private function voteCallBack(param1:Object = null) : void
      {
      }
      
      private function removeButtonListeners() : void
      {
         this._designContainer1.parent.removeEventListener(MouseEvent.CLICK,this.pressVoteForPlayer1);
         this._designContainer2.parent.removeEventListener(MouseEvent.CLICK,this.pressVoteForPlayer2);
         this._lookContainer1.parent.removeEventListener(MouseEvent.CLICK,this.pressVoteForPlayer1);
         this._lookContainer2.parent.removeEventListener(MouseEvent.CLICK,this.pressVoteForPlayer2);
         MovieClip(this._lookContainer1.parent).buttonMode = false;
         MovieClip(this._lookContainer2.parent).buttonMode = false;
         MovieClip(this._designContainer1.parent).buttonMode = false;
         MovieClip(this._designContainer2.parent).buttonMode = false;
         if(this._skipButtonShow)
         {
            Buttonizer.unbuttonizeFrames(this._skipButton,this.pressSkip);
         }
         if(this._buyButtonsShow)
         {
            Buttonizer.unbuttonizeFrames(this._buyLook1,this.buyLook1Clicked);
            Buttonizer.unbuttonizeFrames(this._buyLook2,this.buyLook2Clicked);
         }
      }
      
      private function addButtonListeners() : void
      {
         if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.LOOK)
         {
            this._lookContainer1.parent.addEventListener(MouseEvent.CLICK,this.pressVoteForPlayer1);
            this._lookContainer2.parent.addEventListener(MouseEvent.CLICK,this.pressVoteForPlayer2);
            if(this._buyButtonsShow)
            {
               Buttonizer.buttonizeFrames(this._buyLook1,this.buyLook1Clicked);
               Buttonizer.buttonizeFrames(this._buyLook2,this.buyLook2Clicked);
               this._buyLook1.visible = true;
               this._buyLook2.visible = true;
            }
            MovieClip(this._lookContainer1.parent).buttonMode = true;
            MovieClip(this._lookContainer2.parent).buttonMode = true;
         }
         else if(this._dailyRateItem.ContentType == DailyCompetitionContentTypes.DESIGN)
         {
            this._designContainer1.parent.addEventListener(MouseEvent.CLICK,this.pressVoteForPlayer1);
            this._designContainer2.parent.addEventListener(MouseEvent.CLICK,this.pressVoteForPlayer2);
            MovieClip(this._designContainer1.parent).buttonMode = true;
            MovieClip(this._designContainer2.parent).buttonMode = true;
         }
         if(this._skipButtonShow)
         {
            Buttonizer.buttonizeFrames(this._skipButton,this.pressSkip);
            this._skipButton.visible = true;
         }
      }
      
      private function mapInstances() : void
      {
         var _loc3_:Rectangle = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:Sprite = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:Sprite = null;
         var _loc9_:DisplayObject = null;
         var _loc10_:Sprite = null;
         var _loc11_:DisplayObject = null;
         var _loc12_:Sprite = null;
         this.checkChildrenForTextFields(this._frameinstance);
         var _loc1_:Boolean = true;
         var _loc2_:Boolean = true;
         var _loc4_:* = int(this._frameinstance.numChildren - 1);
         for(; _loc4_ >= 0; _loc4_--)
         {
            if(!(this._frameinstance.getChildAt(_loc4_) is MovieClip))
            {
               continue;
            }
            switch(this._frameinstance.getChildAt(_loc4_).name)
            {
               case "LookViewer":
                  if(_loc2_)
                  {
                     this._loveLook1Button = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("LoveItButton") as MovieClip;
                     this._lookContainer1 = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("LookContainer") as MovieClip;
                     this._lookName1 = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("Username") as TextField;
                     _loc2_ = false;
                     _loc5_ = this._frameinstance.getChildAt(_loc4_);
                     _loc3_ = DisplayObjectUtil.getVisibleBounds(_loc5_);
                     _loc6_ = new Sprite();
                     this._frameinstance.addChild(_loc6_);
                     _loc6_.x = _loc5_.x - _loc3_.width * 0.6;
                     _loc6_.y = _loc5_.y - _loc3_.height * 0.5;
                     _loc5_.x = _loc3_.width * 0.6;
                     _loc5_.y = _loc3_.height * 0.5;
                     _loc6_.addChild(_loc5_);
                  }
                  else
                  {
                     this._loveLook2Button = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("LoveItButton") as MovieClip;
                     this._lookContainer2 = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("LookContainer") as MovieClip;
                     this._lookName2 = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("Username") as TextField;
                     _loc7_ = this._frameinstance.getChildAt(_loc4_);
                     _loc3_ = DisplayObjectUtil.getVisibleBounds(_loc7_);
                     _loc8_ = new Sprite();
                     this._frameinstance.addChild(_loc8_);
                     _loc8_.x = _loc7_.x - _loc3_.width * 0.5;
                     _loc8_.y = _loc7_.y - _loc3_.height * 0.5;
                     _loc7_.x = _loc3_.width * 0.5;
                     _loc7_.y = _loc3_.height * 0.5;
                     _loc8_.addChild(_loc7_);
                  }
                  break;
               case "FramingBar":
                  this._frameinstance.removeChildAt(_loc4_);
                  break;
               case "NextButton":
                  this._frameinstance.getChildAt(_loc4_).visible = false;
                  break;
               case "SkipButton":
                  if(this._skipButtonShow)
                  {
                     this._skipButton = this._frameinstance.getChildAt(_loc4_) as MovieClip;
                     this._skipButtonText = this._skipButton.getChildByName("LOCALE_CREATE_RATE_RATINGS_BUTTON_SKIP") as TextField;
                     this._skipButtonText.text = this._localeManager.getString("CREATE_RATE_RATINGS_BUTTON_SKIP");
                     FontManager.remapFonts(this._skipButtonText);
                  }
                  else
                  {
                     this._skipButton = this._frameinstance.getChildAt(_loc4_) as MovieClip;
                     this._skipButton.visible = false;
                  }
                  break;
               case "DesignViewer":
                  if(_loc1_)
                  {
                     this._loveDesign1Button = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("LoveItButton") as MovieClip;
                     this._designName1 = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("designName") as TextField;
                     this._designContainer1 = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("DesignContainer") as MovieClip;
                     _loc1_ = false;
                     _loc9_ = this._frameinstance.getChildAt(_loc4_);
                     _loc3_ = DisplayObjectUtil.getVisibleBounds(_loc9_);
                     _loc10_ = new Sprite();
                     this._frameinstance.addChild(_loc10_);
                     _loc10_.x = _loc9_.x - _loc3_.width * 0.5;
                     _loc10_.y = _loc9_.y - _loc3_.height * 0.5;
                     _loc9_.x = _loc3_.width * 0.5;
                     _loc9_.y = _loc3_.height * 0.5;
                     _loc10_.addChild(_loc9_);
                     _loc10_.scrollRect = new Rectangle(0,0,_loc3_.width * 1.2,_loc3_.height * 1.5);
                  }
                  else
                  {
                     this._loveDesign2Button = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("LoveItButton") as MovieClip;
                     this._designName2 = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("designName") as TextField;
                     this._designContainer2 = (this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("DesignContainer") as MovieClip;
                     _loc11_ = this._frameinstance.getChildAt(_loc4_);
                     _loc3_ = DisplayObjectUtil.getVisibleBounds(_loc11_);
                     _loc12_ = new Sprite();
                     this._frameinstance.addChild(_loc12_);
                     _loc12_.x = _loc11_.x - _loc3_.width * 0.6;
                     _loc12_.y = _loc11_.y - _loc3_.height * 0.5;
                     _loc11_.x = _loc3_.width * 0.6;
                     _loc11_.y = _loc3_.height * 0.5;
                     _loc12_.addChild(_loc11_);
                     _loc12_.scrollRect = new Rectangle(0,0,_loc3_.width * 1.2,_loc3_.height * 1.5);
                  }
                  break;
               case "LevelBar":
                  this._levelBarMC = ((this._frameinstance.getChildAt(_loc4_) as MovieClip).getChildByName("InsideTube") as MovieClip).getChildByName("PurpleBar") as MovieClip;
                  this._fameStarAnim = (this._frameinstance.getChildAt(_loc4_) as DisplayObjectContainer).getChildByName("FameStarAnim") as MovieClip;
                  break;
               case "CloseArea":
                  this._closeButtonPlaceholder = this._frameinstance.getChildAt(_loc4_) as MovieClip;
                  this.buttonizeCloseButton();
                  break;
               case "Buy1":
                  this._buyLook1 = this._frameinstance.getChildAt(_loc4_) as MovieClip;
                  this._buyLook1.visible = false;
                  break;
               case "Buy2":
                  this._buyLook2 = this._frameinstance.getChildAt(_loc4_) as MovieClip;
                  this._buyLook2.visible = false;
                  break;
               case "loveBars1":
                  this._loveBars1 = this._frameinstance.getChildAt(_loc4_) as MovieClip;
                  break;
               case "loveBars2":
                  this._loveBars2 = this._frameinstance.getChildAt(_loc4_) as MovieClip;
            }
         }
      }
      
      private function checkChildrenForTextFields(param1:DisplayObjectContainer) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         for(; _loc2_ < param1.numChildren; _loc2_++)
         {
            if(param1.getChildAt(_loc2_) is MovieClip)
            {
               (param1.getChildAt(_loc2_) as MovieClip).stop();
               switch(param1.getChildAt(_loc2_).name)
               {
                  case "heart":
                     if(this._ratingBar1 == null)
                     {
                        this._ratingBar1 = param1.parent.parent as MovieClip;
                        this._ratingBar1.stop();
                        break;
                     }
                     this._ratingBar2 = param1.parent.parent as MovieClip;
                     this._ratingBar2.stop();
               }
               this.checkChildrenForTextFields(param1.getChildAt(_loc2_) as DisplayObjectContainer);
               continue;
            }
            if(!(param1.getChildAt(_loc2_) is TextField))
            {
               continue;
            }
            switch(param1.getChildAt(_loc2_).name)
            {
               case "Likes_Num":
                  if(this._ratingText1 == null)
                  {
                     this._ratingText1 = param1.getChildAt(_loc2_) as TextField;
                  }
                  else
                  {
                     this._ratingText2 = param1.getChildAt(_loc2_) as TextField;
                  }
                  FontManager.remapFonts(this._ratingText1);
                  FontManager.remapFonts(this._ratingText2);
                  break;
               case "LOCALE_CREATE_RATE_HOMEPAGE_SUBHEADER":
                  if(this._themeName != null)
                  {
                     _loc3_ = "\"" + this._themeName + "\"";
                     if(_loc3_ != null)
                     {
                        (param1.getChildAt(_loc2_) as TextField).text = _loc3_;
                     }
                     FontManager.remapFonts(param1.getChildAt(_loc2_) as TextField);
                  }
                  else
                  {
                     (param1.getChildAt(_loc2_) as TextField).visible = false;
                  }
            }
         }
      }
      
      private function buttonizeCloseButton() : void
      {
         if(ConstantsPlatform.isWeb)
         {
            this._closeButton = new ScreenIcons.CloseIcon() as MovieClip;
         }
         else
         {
            this._closeButton = new NavigationIcons.Close() as MovieClip;
            if(ScreenSize.isPhone)
            {
               this._closeButton.height = MeasurementUtils.convertMilimetersToPixels(MeasurementConstants.BUTTON_SIZE_MM);
               this._closeButton.scaleX = this._closeButton.scaleY;
            }
            this._closeButtonPlaceholder.x -= this._closeButton.width - this._closeButtonPlaceholder.width;
         }
         DisplayObjectAddUtilities.addAtPlaceholder(this._closeButton,this._closeButtonPlaceholder,this);
         Buttonizer.buttonizeFrames(this._closeButton,this.clickClose);
      }
      
      public function setLevelBar() : void
      {
         this._levelBar = new LevelBar(this._levelBarMC,this._fameStarAnim,this._frameinstance,this._actorId,this._dailyCompetition,this);
      }
      
      public function getAnalyticsNames() : Array
      {
         return [TimeSpentConstants.FEATURE_ACTIVITIES_CREATEANDRATE];
      }
      
      public function getFeatureNames() : Array
      {
         return [FeatureUsage.FEATURE_GAME,FeatureUsage.FEATURE_SUB1_CREATE_AND_RATE];
      }
      
      public function isRotating() : Boolean
      {
         return this._isRotating;
      }
   }
}

