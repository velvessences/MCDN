package com.moviestarplanet.dailyCompetition
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.dailyCompetition.service.DailyCompetitionAmfService;
   import com.moviestarplanet.dailyCompetition.service.valueObjects.DailyRateItem;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.utils.FontManager;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.window.stack.WindowFloatingInterface;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class VoteFrame extends Sprite implements WindowFloatingInterface
   {
      
      private var _frameinstance:DisplayObjectContainer;
      
      private var _actorId:Number;
      
      private var _nextCompetitionCallBack:Function;
      
      private var _localeManager:ILocaleManager;
      
      private var _dailyCompetition:DailyCompetition;
      
      private var frame:MovieClip;
      
      private var levelBarMC:MovieClip;
      
      private var levelBar:LevelBar;
      
      private var skipButton:MovieClip;
      
      private var nextButton:MovieClip;
      
      private var nextButtonTimer:Timer;
      
      private var isMovie:Boolean = false;
      
      private var votedFromArtbook:Boolean = false;
      
      private var isReady:Function;
      
      private var _themeName:String;
      
      private var _item:DailyRateItem;
      
      private var skippedPressed:Boolean = false;
      
      public function VoteFrame(param1:DailyCompetition, param2:Boolean, param3:Function, param4:DailyRateItem)
      {
         super();
         this._dailyCompetition = param1;
         this._item = param4;
         this.isMovie = param2;
         this.isReady = param3;
         var _loc5_:String = "dailycompetition/DesignBattleScreen.swf";
         MSP_FlashLoader.RequestLoad(new AssetUrl(_loc5_,AssetUrl.SWF),this.loadDone,MSP_LoaderManager.PRIORITY_NORMAL,true,false);
      }
      
      public function setNextButton() : void
      {
         if(this.isMovie == false)
         {
            this.votedFromArtbook = true;
         }
         this.changeToNextButton();
         if(this.levelBar)
         {
            this.levelBar.updateLevelBar(true);
         }
      }
      
      private function loadDone(param1:MSP_FlashLoader) : void
      {
         this._frameinstance = param1.content as DisplayObjectContainer;
         addChild(this._frameinstance);
         this._themeName = this._localeManager.getString(this._item.ThemeName);
         this.mapInstances();
         this.addButtonListeners();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removed);
         if(this.isMovie == false)
         {
            this.nextButtonTimer = new Timer(4000,0);
            this.nextButtonTimer.addEventListener(TimerEvent.TIMER,this.nextButtonTimeOut);
            this.nextButtonTimer.start();
            this.skipButton.visible = false;
         }
         this.isReady();
      }
      
      public function setLocale(param1:ILocaleManager) : void
      {
         this._localeManager = param1;
      }
      
      public function set actorId(param1:Number) : void
      {
         this._actorId = param1;
      }
      
      private function removed(param1:Event) : void
      {
         this.removeButtonListeners();
         if(this.nextButtonTimer)
         {
            this.nextButtonTimer.stop();
         }
         if(this.skippedPressed)
         {
            this._dailyCompetition.openNextCompetition();
         }
      }
      
      private function removeButtonListeners() : void
      {
         Buttonizer.unbuttonizeFrames(this.skipButton,this.pressSkip);
         Buttonizer.unbuttonizeFrames(this.nextButton,this.pressSkip);
      }
      
      private function addButtonListeners() : void
      {
         Buttonizer.buttonizeFrames(this.skipButton,this.pressSkip);
         Buttonizer.buttonizeFrames(this.nextButton,this.pressSkip);
         this.skipButton.visible = true;
      }
      
      private function changeToNextButton() : void
      {
         if(this.skipButton != null && this.nextButton != null)
         {
            this.skipButton.visible = false;
            this.nextButton.visible = true;
         }
      }
      
      private function nextButtonTimeOut(param1:TimerEvent) : void
      {
         this.changeToNextButton();
         if(this.nextButtonTimer)
         {
            this.nextButtonTimer.stop();
         }
      }
      
      private function pressSkip(param1:Event) : void
      {
         var doneVoteFor:Function;
         var event:MsgEvent = null;
         var isCorrect:Boolean = false;
         var e:Event = param1;
         this.skippedPressed = true;
         if(this.isMovie)
         {
            event = new MsgEvent(MSPEvent.CLOSE_MOVIE);
         }
         else
         {
            if(this.votedFromArtbook == false)
            {
               doneVoteFor = function():void
               {
               };
               this.votedFromArtbook = true;
               isCorrect = true;
               DailyCompetitionAmfService.voteFor(doneVoteFor,this._actorId,this._item.ContentType,this._item.ThemeId,this._item.IdA,this._item.IdA);
            }
            event = new MsgEvent(MSPEvent.CLOSE_SCRAPBLOG);
         }
         MessageCommunicator.send(event);
      }
      
      private function mapInstances() : void
      {
         var _loc2_:* = 0;
         var _loc3_:MovieClip = null;
         var _loc1_:Boolean = true;
         this.checkChildrenForTextFields(this._frameinstance);
         _loc2_ = int(this._frameinstance.numChildren - 1);
         for(; _loc2_ >= 0; _loc2_--)
         {
            if(!(this._frameinstance.getChildAt(_loc2_) is MovieClip))
            {
               continue;
            }
            switch(this._frameinstance.getChildAt(_loc2_).name)
            {
               case "NextButton":
                  this.nextButton = this._frameinstance.getChildAt(_loc2_) as MovieClip;
                  this.nextButton.visible = false;
                  break;
               case "SkipButton":
                  this.skipButton = this._frameinstance.getChildAt(_loc2_) as MovieClip;
                  break;
               case "LevelBar":
                  ((this._frameinstance.getChildAt(_loc2_) as MovieClip).getChildAt(8) as MovieClip).stop();
                  this.levelBarMC = ((this._frameinstance.getChildAt(_loc2_) as MovieClip).getChildByName("InsideTube") as MovieClip).getChildByName("PurpleBar") as MovieClip;
                  _loc3_ = (this._frameinstance.getChildAt(_loc2_) as DisplayObjectContainer).getChildByName("FameStarAnim") as MovieClip;
                  this.levelBar = new LevelBar(this.levelBarMC,_loc3_,this._frameinstance,this._actorId,this._dailyCompetition,null);
                  break;
               case "LookViewer":
               case "DesignViewer":
               case "RatingBars":
               case "loveBars1":
               case "loveBars2":
               case "FramingBar":
               case "CloseArea":
               case "FrameBackground":
                  this._frameinstance.removeChildAt(_loc2_);
            }
         }
      }
      
      private function checkChildrenForTextFields(param1:DisplayObjectContainer) : void
      {
         var _loc2_:int = 0;
         for(; _loc2_ < param1.numChildren; _loc2_++)
         {
            if(param1.getChildAt(_loc2_) is MovieClip)
            {
               this.checkChildrenForTextFields(param1.getChildAt(_loc2_) as DisplayObjectContainer);
               continue;
            }
            if(!(param1.getChildAt(_loc2_) is TextField))
            {
               continue;
            }
            switch(param1.getChildAt(_loc2_).name)
            {
               case "LOCALE_CREATE_RATE_HOMEPAGE_SUBHEADER":
                  (param1.getChildAt(_loc2_) as TextField).text = "\"" + this._themeName + "\"";
                  FontManager.remapFonts(param1.getChildAt(_loc2_) as TextField);
            }
         }
      }
   }
}

