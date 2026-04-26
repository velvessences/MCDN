package com.moviestarplanet.dailyCompetition
{
   import com.moviestarplanet.award.visualization.IAwardSpawner;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.dailyCompetition.constants.DailyCompetitionContentTypes;
   import com.moviestarplanet.dailyCompetition.graphics.GraphicProvider;
   import com.moviestarplanet.dailyCompetition.service.DailyCompetitionAmfService;
   import com.moviestarplanet.dailyCompetition.service.valueObjects.DailyThemeItem;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.icons.ScreenIcons;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.displayobject.DisplayObjectAddUtilities;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   public class CreateAndRatePopup extends Sprite
   {
      
      private var _actorId:Number;
      
      private var _closeCallBack:Function;
      
      private var _openCallBack:Function;
      
      private var _localeManager:ILocaleManager;
      
      private var _localAwardSpawner:IAwardSpawner;
      
      private var _designButton:MovieClip;
      
      private var _movieButton:MovieClip;
      
      private var _lookButton:MovieClip;
      
      private var _artbookButton:MovieClip;
      
      private var _closeButton:MovieClip;
      
      private var _competitionButton:MovieClip;
      
      private var _graphicsProvider:GraphicProvider;
      
      private var graphicsReady:Boolean = false;
      
      private var themeStatusReady:Boolean = false;
      
      private var waitForTomorrow:Boolean = false;
      
      private var themeName:String;
      
      private var _noMoreContent:Boolean = true;
      
      public function CreateAndRatePopup(param1:Function, param2:Function, param3:int, param4:ILocaleManager, param5:IAwardSpawner, param6:Boolean)
      {
         super();
         this._closeCallBack = param2;
         this._openCallBack = param1;
         this._actorId = param3;
         this._localeManager = param4;
         this._localAwardSpawner = param5;
         this._noMoreContent = param6;
         this.setBundle(new GraphicProvider());
         DailyCompetitionAmfService.getTodaysTheme(this.themeCallback);
      }
      
      public function setBundle(param1:GraphicProvider) : void
      {
         param1.sourceLoad(this.bundleReady);
      }
      
      private function showTimerPopup(param1:Boolean) : void
      {
         if(this._graphicsProvider != null)
         {
            this._graphicsProvider.timerLeftPopup().visible = param1;
            this._graphicsProvider.timerLeft().visible = param1;
            this._graphicsProvider.timerText().visible = param1;
         }
      }
      
      private function bundleReady(param1:GraphicProvider) : void
      {
         this.graphicsReady = true;
         this._graphicsProvider = param1;
         this._graphicsProvider.submitWindow().visible = false;
         this._graphicsProvider.rateWindow().visible = true;
         this._graphicsProvider.countDown.setCallback = this.retranslate;
         this.showTimerPopup(false);
         if(ConstantsPlatform.isWeb)
         {
            this.grayBackground();
         }
         addChild(this._graphicsProvider.container());
         this.buttonize();
         if(this._noMoreContent)
         {
            this._competitionButton.gotoAndStop("disable");
         }
         if(this.themeStatusReady && this.graphicsReady)
         {
            this.translate();
         }
         if(this._openCallBack != null)
         {
            this._openCallBack();
         }
      }
      
      private function themeCallback(param1:DailyThemeItem) : void
      {
         this.themeStatusReady = true;
         if(DailyCompetition.SHOW_DAILY_THEME_NAME)
         {
            this.themeName = this._localeManager.getString(param1.Name);
         }
         else
         {
            this.themeName = null;
         }
         if(param1.Id == 0)
         {
            this.waitForTomorrow = true;
         }
         if(this.themeStatusReady && this.graphicsReady)
         {
            this.translate();
         }
      }
      
      private function retranslate() : void
      {
         DailyCompetitionAmfService.getTodaysTheme(this.themeCallback);
         this.unbuttonize();
         this.checkIfcanSubmit();
      }
      
      private function translate() : void
      {
         var _loc1_:String = null;
         var _loc2_:TextFormat = null;
         this.canVote(this.waitForTomorrow == false);
         this._graphicsProvider.mainParser.headline.selectable = false;
         if(Boolean(this.themeName) && this.themeName != null)
         {
            this._graphicsProvider.mainParser.headline.visible = true;
            this._graphicsProvider.mainParser.headline.text = this.themeName;
            _loc2_ = new TextFormat();
            _loc2_.bold = true;
            _loc2_.italic = true;
            this._graphicsProvider.mainParser.headline.setTextFormat(_loc2_);
            FontManager.remapFonts(this._graphicsProvider.mainParser.headline);
         }
         else
         {
            this._graphicsProvider.mainParser.headline.visible = false;
         }
         this._graphicsProvider.timerText().selectable = false;
         this._graphicsProvider.rateParser.headline.selectable = false;
         this._graphicsProvider.rateParser.headline.text = this._localeManager.getString("CREATE_RATE_HOMEPAGE_HEADER");
         this._graphicsProvider.rateParser.description.selectable = false;
         this._graphicsProvider.rateParser.description.text = this._localeManager.getString("CREATE_RATE_HOMEPAGE_DESC");
         this._graphicsProvider.rateParser.designButton["LOCALE_CREATE_RATE_HOMEPAGE_BUTTON_1"].text = this._localeManager.getString("CREATE_RATE_HOMEPAGE_BUTTON_1");
         this._graphicsProvider.rateParser.movieButton["LOCALE_CREATE_RATE_HOMEPAGE_BUTTON_2"].text = this._localeManager.getString("CREATE_RATE_HOMEPAGE_BUTTON_3");
         if(this.waitForTomorrow)
         {
            _loc1_ = this._localeManager.getString("CREATEANDRATE_RATINGS_START_TOMORROW");
         }
         else
         {
            _loc1_ = this._localeManager.getString("CREATE_RATE_HOMEPAGE_BUTTON_VIEW_COMP");
         }
         this._graphicsProvider.rateParser.viewCompetitionButton["LOCALE_CREATE_RATE_HOMEPAGE_BUTTON_VIEW_COMP"].text = _loc1_;
         this._graphicsProvider.timerText().selectable = false;
         this._graphicsProvider.timerText().text = this._localeManager.getString("CREATE_RATE_HOMEPAGE_BUTTON_VIEW_COMP_TIMER");
         FontManager.remapFonts(this._graphicsProvider.timerText());
         FontManager.remapAllFontsForDisplayObject(this._graphicsProvider.rateWindow());
      }
      
      private function buttonize() : void
      {
         this._closeButton = new ScreenIcons.CloseIcon() as MovieClip;
         this._movieButton = this._graphicsProvider.rateParser.movieButton;
         this._movieButton.stop();
         this._designButton = this._graphicsProvider.rateParser.designButton;
         this._designButton.stop();
         this._competitionButton = this._graphicsProvider.rateParser.viewCompetitionButton;
         this._competitionButton.stop();
         DisplayObjectAddUtilities.addAtPlaceholder(this._closeButton,this._graphicsProvider.closeButton(),this._graphicsProvider.container());
         Buttonizer.buttonizeFrames(this._closeButton,this.clickClose);
         this.checkIfcanSubmit();
      }
      
      private function checkIfcanSubmit() : void
      {
         DailyCompetitionVoteController.canActorSubmit(this._actorId,DailyCompetitionContentTypes.LOOK,this.canSubmitLook);
         DailyCompetitionVoteController.canActorSubmit(this._actorId,DailyCompetitionContentTypes.DESIGN,this.canSubmitDesign);
      }
      
      private function canVote(param1:Boolean) : void
      {
         if(param1 && this._noMoreContent == false)
         {
            Buttonizer.buttonizeFrames(this._competitionButton,this.openRatingWindow);
         }
         else
         {
            this._competitionButton.gotoAndStop("disable");
            Buttonizer.unbuttonizeFrames(this._competitionButton,this.openRatingWindow);
            this.showTimerPopup(true);
         }
      }
      
      private function canSubmitDesign(param1:Boolean) : void
      {
         if(param1)
         {
            Buttonizer.buttonizeFrames(this._designButton,this.openDesign);
         }
         else
         {
            this._designButton.gotoAndStop("disable");
         }
      }
      
      private function canSubmitLook(param1:Boolean) : void
      {
         if(param1)
         {
            Buttonizer.buttonizeFrames(this._movieButton,this.openLook);
         }
         else
         {
            this._movieButton.gotoAndStop("disable");
         }
      }
      
      private function grayBackground() : void
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.lineStyle(0,0,0);
         _loc1_.graphics.beginFill(0,0.7);
         _loc1_.graphics.drawRect(0,0,980,500);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
      }
      
      public function close(param1:Boolean = false) : void
      {
         this.unbuttonize();
         Buttonizer.unbuttonizeFrames(this._closeButton,this.clickClose);
         this._graphicsProvider.countDown.clearCallback();
         this._closeCallBack(param1);
      }
      
      private function unbuttonize() : void
      {
         Buttonizer.unbuttonizeFrames(this._movieButton,this.openMovie);
         Buttonizer.unbuttonizeFrames(this._designButton,this.openDesign);
         Buttonizer.unbuttonizeFrames(this._competitionButton,this.openRatingWindow);
      }
      
      private function clickClose(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function openRatingWindow(param1:MouseEvent) : void
      {
         this.close(true);
      }
      
      private function openDesign(param1:MouseEvent) : void
      {
         this.close();
         var _loc2_:MsgEvent = new MsgEvent(MSPEvent.OPEN_DESIGN_CREATION);
         MessageCommunicator.send(_loc2_);
      }
      
      private function openLook(param1:MouseEvent) : void
      {
         this.close();
         var _loc2_:MsgEvent = new MsgEvent(MSPEvent.OPEN_LOOK_CREATION);
         MessageCommunicator.send(_loc2_);
      }
      
      private function openMovie(param1:MouseEvent) : void
      {
         this.close();
         var _loc2_:MsgEvent = new MsgEvent(MSPEvent.OPEN_MOVIE_CREATION);
         MessageCommunicator.send(_loc2_);
      }
      
      private function openArtBook(param1:MouseEvent) : void
      {
         this.close();
         var _loc2_:MsgEvent = new MsgEvent(MSPEvent.OPEN_ARTBOOK_CREATION);
         MessageCommunicator.send(_loc2_);
      }
      
      private function removed(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removed);
         this.close();
      }
   }
}

