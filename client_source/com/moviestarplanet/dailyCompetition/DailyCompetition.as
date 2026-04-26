package com.moviestarplanet.dailyCompetition
{
   import com.moviestarplanet.award.visualization.IAwardSpawner;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.dailyCompetition.constants.DailyCompetitionContentTypes;
   import com.moviestarplanet.dailyCompetition.service.DailyCompetitionAmfService;
   import com.moviestarplanet.dailyCompetition.service.valueObjects.DailyRateItem;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.window.base.WindowLayers;
   import com.moviestarplanet.window.base.WindowOpener;
   import com.moviestarplanet.window.loading.ILoadingOverlay;
   import com.moviestarplanet.window.loading.LoadingBar;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.display.Sprite;
   
   public class DailyCompetition
   {
      
      private static var _votingFrame:VoteFrame;
      
      private static var _loading:ILoadingOverlay;
      
      private static var votingBarItem:DailyRateItem;
      
      private static var showVotingFrame:Boolean = false;
      
      private static var isMovie:Boolean = false;
      
      private static var noMoreContent:Boolean = false;
      
      public static const DAILY_COMPETITION_START_POS_X:int = 236;
      
      public static const DAILY_COMPETITION_START_POS_Y:int = 81;
      
      public static var localAwardSpawner:IAwardSpawner = null;
      
      public static const SHOW_DAILY_THEME_NAME:Boolean = false;
      
      private var _actorId:int;
      
      private var _createAndRatePopup:CreateAndRatePopup;
      
      private var _createAndRatePopupReady:Boolean;
      
      private var _submitPopup:SubmitToCompetitionPopup;
      
      private var _designBattle:DesignBattle;
      
      private var _designBattleReady:Boolean;
      
      private var _type:int;
      
      private var _contentId:int;
      
      private var oldCompetitionType:int = -1;
      
      private var _closeFunction:Function;
      
      private var _parentSprite:Sprite;
      
      [Inject]
      public var localeManager:ILocaleManager;
      
      public function DailyCompetition(param1:int)
      {
         super();
         InjectionManager.manager().injectMe(this);
         _loading = new LoadingBar();
         this._actorId = param1;
         DailyCompetitionVoteController.checkIfShouldListenForLoggedOut();
      }
      
      public static function hide() : void
      {
         if(_loading != null)
         {
            _loading.hide();
         }
      }
      
      private static function showLoading() : void
      {
         if(_loading != null)
         {
            _loading.show();
         }
      }
      
      public function get actorId() : Number
      {
         return this._actorId;
      }
      
      public function openCreateAndRatePopup() : void
      {
         var cb:Function;
         this.closeDesignBattle();
         MessageCommunicator.send(new MsgEvent(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.CREATE_AND_RATE_OPEN_LOOK));
         if(this._createAndRatePopup == null)
         {
            cb = function(param1:Boolean):void
            {
               noMoreContent = !param1;
               _createAndRatePopup = new CreateAndRatePopup(createAndRatePopupReady,closeCreateAndRatePopup,_actorId,localeManager,localAwardSpawner,noMoreContent);
               createAndRatePopupContinue();
            };
            DailyCompetitionVoteController.checkIfActorCanVote(this._actorId,cb);
         }
         else
         {
            this.closeCreateAndRatePopup();
         }
      }
      
      public function tryOpenSubmitWindow(param1:int, param2:int) : void
      {
         this._type = param1;
         this._contentId = param2;
         if(DailyCompetitionVoteController.needsToFetchData())
         {
            DailyCompetitionAmfService.getVoteScore(this.onSubmissionResetsFetched,this._actorId);
         }
         else
         {
            this.continueOpenSubmitWindow();
         }
      }
      
      private function onSubmissionResetsFetched(param1:Object) : void
      {
         DailyCompetitionVoteController.submissionResets = param1.submissionResets;
         this.continueOpenSubmitWindow();
      }
      
      private function continueOpenSubmitWindow() : void
      {
         var canSubmit:Function = null;
         canSubmit = function(param1:Boolean):void
         {
            if(param1)
            {
               openSubmitWindow(_type,_contentId);
            }
         };
         DailyCompetitionVoteController.canActorSubmit(this._actorId,this._type,canSubmit);
      }
      
      private function openSubmitWindow(param1:int, param2:int) : void
      {
         this._submitPopup = new SubmitToCompetitionPopup(this.closeSubmitPopup,param1,this._actorId,param2,this.localeManager);
         if(ConstantsPlatform.isWeb)
         {
            WindowOpener.openWindow(this._submitPopup,WindowLayers.PROMPT,{
               "x":280,
               "y":77
            });
         }
         else
         {
            WindowOpener.openWindow(this._submitPopup,WindowLayers.PROMPT);
         }
      }
      
      private function createAndRatePopupReady() : void
      {
         this._createAndRatePopupReady = true;
         this.createAndRatePopupContinue();
      }
      
      private function createAndRatePopupContinue() : void
      {
         var _loc1_:Object = null;
         if(this._createAndRatePopupReady && this._createAndRatePopup != null)
         {
            this._createAndRatePopupReady = false;
            if(ConstantsPlatform.isWeb)
            {
               WindowOpener.openWindow(this._createAndRatePopup,WindowLayers.ROOM,{
                  "x":DAILY_COMPETITION_START_POS_X,
                  "y":DAILY_COMPETITION_START_POS_Y
               });
            }
            else if(ConstantsPlatform.isMobile)
            {
               _loc1_ = new Object();
               _loc1_.maxWidthInMillimeters = 160;
               WindowOpener.openWindow(this._createAndRatePopup,WindowLayers.ROOM,_loc1_);
            }
            else
            {
               WindowOpener.openWindow(this._createAndRatePopup,WindowLayers.ROOM);
            }
         }
      }
      
      private function closeCreateAndRatePopup(param1:Boolean = false) : void
      {
         if(param1)
         {
            showLoading();
            this.openNextCompetition();
         }
         if(this._createAndRatePopup != null)
         {
            if(ConstantsPlatform.isWeb)
            {
               WindowOpener.closeWindow(this._createAndRatePopup);
            }
            else
            {
               WindowOpener.closeWindow(this._createAndRatePopup);
            }
            this._createAndRatePopup = null;
            if(_votingFrame)
            {
               _votingFrame = null;
            }
         }
      }
      
      private function closeSubmitPopup() : void
      {
         if(this._submitPopup != null)
         {
            if(ConstantsPlatform.isWeb)
            {
               WindowOpener.closeWindow(this._submitPopup);
            }
            else
            {
               WindowOpener.closeWindow(this._submitPopup);
            }
            this._submitPopup = null;
         }
      }
      
      public function setVotingFrameNextButton() : void
      {
         if(_votingFrame != null)
         {
            _votingFrame.setNextButton();
         }
      }
      
      public function openMovieVoting(param1:DailyRateItem) : void
      {
         DailyCompetition.hide();
         votingBarItem = param1;
         showVotingFrame = true;
         isMovie = true;
         var _loc2_:int = param1.IdA;
         var _loc3_:MsgEvent = new MsgEvent(MSPEvent.OPEN_MOVIE,_loc2_,true);
         MessageCommunicator.send(_loc3_);
      }
      
      public function openArtbookVoting(param1:DailyRateItem) : void
      {
         DailyCompetition.hide();
         votingBarItem = param1;
         showVotingFrame = true;
         isMovie = false;
         var _loc2_:int = param1.IdA;
         var _loc3_:MsgEvent = new MsgEvent(MSPEvent.OPEN_SCRAPBLOG,_loc2_,true);
         MessageCommunicator.send(_loc3_);
      }
      
      public function openDesignBattle(param1:DailyRateItem) : void
      {
         this._designBattle = new DesignBattle(this.openDesignBattleReady,this.closeDesignBattle,this,param1);
         this._designBattle.locale = this.localeManager;
         this._designBattle.actorId = this._actorId;
         this.openDesignBattleContinue();
      }
      
      private function openDesignBattleReady() : void
      {
         this._designBattleReady = true;
         this.openDesignBattleContinue();
      }
      
      private function openDesignBattleContinue() : void
      {
         if(this._designBattleReady && this._designBattle != null)
         {
            this._designBattleReady = false;
            if(ConstantsPlatform.isWeb)
            {
               WindowOpener.openWindow(this._designBattle,WindowLayers.ROOM,{
                  "x":DAILY_COMPETITION_START_POS_X,
                  "y":DAILY_COMPETITION_START_POS_Y
               });
            }
            else if(ConstantsPlatform.isWeb)
            {
               WindowOpener.openWindow(this._designBattle,WindowLayers.ROOM);
            }
            else if(this._parentSprite != null)
            {
               this._parentSprite.addChild(this._designBattle);
            }
            this._designBattle.setLevelBar();
         }
      }
      
      private function closeDesignBattle() : void
      {
         if(this._designBattle != null)
         {
            this._designBattle.close();
            if(ConstantsPlatform.isWeb)
            {
               WindowOpener.closeWindow(this._designBattle);
            }
            this._designBattle = null;
         }
         this.oldCompetitionType = -1;
         if(ConstantsPlatform.isMobile && this._closeFunction != null)
         {
            this._closeFunction();
            this._closeFunction = null;
            this._parentSprite.removeChildren();
            this._parentSprite = null;
         }
      }
      
      public function openRatingMobile(param1:Function, param2:Sprite) : void
      {
         this._closeFunction = param1;
         this._parentSprite = param2;
         this.openRating();
      }
      
      public function openRating() : void
      {
         var cb:Function = null;
         cb = function(param1:Boolean):void
         {
            if(param1)
            {
               openNextCompetition();
            }
            else
            {
               SetNoMoreContent(false);
            }
         };
         DailyCompetitionVoteController.checkIfActorCanVote(this._actorId,cb);
      }
      
      public function openNextCompetition() : void
      {
         showLoading();
         DailyCompetitionAmfService.getRandomItems(this.callBack,this._actorId);
      }
      
      private function callBack(param1:DailyRateItem) : void
      {
         if(param1.data == false)
         {
            hide();
            this.SetNoMoreContent(true);
            return;
         }
         if(param1.ContentType == DailyCompetitionContentTypes.DESIGN || param1.ContentType == DailyCompetitionContentTypes.LOOK)
         {
            if(this.oldCompetitionType == DailyCompetitionContentTypes.DESIGN || this.oldCompetitionType == DailyCompetitionContentTypes.LOOK)
            {
               this._designBattle.startNextBattle(param1);
            }
            else
            {
               this.oldCompetitionType = param1.ContentType;
               this.openDesignBattle(param1);
            }
            hide();
         }
      }
      
      public function SetNoMoreContent(param1:Boolean) : void
      {
         noMoreContent = param1;
         this.closeDesignBattle();
         this.closeCreateAndRatePopup();
         hide();
         if(DailyCompetitionVoteController.submissionResets >= DailyCompetitionVoteController.MAX_EXTRA_PLAYTHROUGHS_PER_DAY)
         {
            Prompt.show(this.localeManager.getString("CREATE_AND_RATE_NO_MORE_VOTES_TODAY"));
         }
         else
         {
            Prompt.showFriendly(this.localeManager.getString("CREATE_AND_RATE_SUBMIT_CONTENT_TO_CONTINUE_VOTING"));
         }
      }
   }
}

