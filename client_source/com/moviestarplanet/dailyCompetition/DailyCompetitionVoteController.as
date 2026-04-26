package com.moviestarplanet.dailyCompetition
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.dailyCompetition.service.DailyCompetitionAmfService;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.utils.translation.LocaleHelper;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   
   public class DailyCompetitionVoteController
   {
      
      public static var levelVotes:int;
      
      public static const MAX_EXTRA_PLAYTHROUGHS_PER_DAY:int = 1;
      
      private static const MAX_VOTES_PER_PLAYTHROUGH:int = 25;
      
      private static const VOTES_PER_LEVEL:int = 5;
      
      public static var level:int = 0;
      
      public static var submissionResets:int = -1;
      
      private static var isInitialized:Boolean = false;
      
      public function DailyCompetitionVoteController()
      {
         super();
      }
      
      public static function checkIfShouldListenForLoggedOut() : void
      {
         if(isInitialized)
         {
            return;
         }
         isInitialized = true;
         MessageCommunicator.subscribe(MSPEvent.DO_LOGOUT,onLoggedOut);
      }
      
      public static function calculateVotes(param1:int) : void
      {
         param1 -= MAX_VOTES_PER_PLAYTHROUGH * submissionResets;
         level = int(param1 / VOTES_PER_LEVEL);
         levelVotes = param1 - level * VOTES_PER_LEVEL;
      }
      
      public static function checkIfActorCanVote(param1:int, param2:Function) : void
      {
         var getVotesCallBack:Function = null;
         var actorId:int = param1;
         var callback:Function = param2;
         getVotesCallBack = function(param1:Object):void
         {
            var _loc2_:int = int(param1.Progress);
            submissionResets = param1.SubmissionResets;
            callback(_loc2_ < MAX_VOTES_PER_PLAYTHROUGH * (submissionResets + 1));
         };
         DailyCompetitionAmfService.getVoteScore(getVotesCallBack,actorId);
      }
      
      public static function canActorSubmit(param1:int, param2:int, param3:Function) : void
      {
         var getVotesCallBack:Function = null;
         var actorId:int = param1;
         var contentType:int = param2;
         var callback:Function = param3;
         getVotesCallBack = function(param1:Object):void
         {
            var _loc2_:int = int(param1.Progress);
            if(DailyCompetitionVoteController.isFirstPlaythroughOfTheDay())
            {
               if(_loc2_ == MAX_VOTES_PER_PLAYTHROUGH)
               {
                  callback(true);
               }
               else
               {
                  DailyCompetitionAmfService.canSubmit(callback,actorId,contentType);
               }
            }
            else
            {
               DailyCompetitionAmfService.canSubmit(callback,actorId,contentType);
            }
         };
         DailyCompetitionAmfService.getVoteScore(getVotesCallBack,actorId);
      }
      
      public static function onNewContentSubmitted(param1:int) : void
      {
         var getVotesCallBack:Function = null;
         var actorId:int = param1;
         getVotesCallBack = function(param1:Object):void
         {
            var _loc2_:int = int(param1.Progress);
            submissionResets = param1.SubmissionResets;
            var _loc3_:int = MAX_VOTES_PER_PLAYTHROUGH * (submissionResets + 1);
            if(_loc2_ > _loc3_)
            {
               _loc2_ = _loc3_;
            }
            if(submissionResets < MAX_EXTRA_PLAYTHROUGHS_PER_DAY && _loc2_ == _loc3_)
            {
               ++submissionResets;
               DailyCompetitionAmfService.incrementSubmissionResets(actorId);
               Prompt.showFriendly(LocaleHelper.getInstance().getString("CREATE_AND_RATE_CAN_VOTE_AGAIN"));
            }
         };
         DailyCompetitionAmfService.getVoteScore(getVotesCallBack,actorId);
      }
      
      public static function needsToFetchData() : Boolean
      {
         return submissionResets == -1;
      }
      
      public static function isFirstPlaythroughOfTheDay() : Boolean
      {
         return submissionResets == 0;
      }
      
      public static function finishedAllPlaythroughsOfTheDay() : Boolean
      {
         return submissionResets > MAX_EXTRA_PLAYTHROUGHS_PER_DAY;
      }
      
      private static function onLoggedOut(param1:MsgEvent) : void
      {
         isInitialized = false;
         level = 0;
         levelVotes = 0;
         submissionResets = -1;
         MessageCommunicator.unscribe(MSPEvent.DO_LOGOUT,onLoggedOut);
      }
   }
}

