package com.moviestarplanet.combat
{
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.combat.enums.CombatEvent;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.configurations.FeatureToggle;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class WebServiceCombatProfilePuller extends EventDispatcher
   {
      
      private var updateInterval:int = 240000;
      
      private const retryTimes:int = 3;
      
      private var failCounter:int = 0;
      
      private var updateTimer:Timer;
      
      private var useNudge:Boolean;
      
      public function WebServiceCombatProfilePuller()
      {
         super();
      }
      
      public function start() : void
      {
         this.useNudge = FeatureToggle.getFeatureActive(FeatureToggle.NUDGE_SERVICE);
         if(this.useNudge)
         {
            this.startNudgeListener();
         }
         this.startTimer();
      }
      
      public function updatePenaltyStatus() : void
      {
         this.updateActorPenaltyStatus();
      }
      
      public function startTimer() : void
      {
         this.updateTimer = new Timer(this.getUpdateInterval());
         this.updateTimer.addEventListener(TimerEvent.TIMER,this.updateActorPenaltyStatus);
         this.updateTimer.start();
      }
      
      public function startNudgeListener() : void
      {
         MessageCommunicator.subscribe(MSPEvent.NUDGE_EVENT_UPDATE_COMBAT,this.updateActorPenaltyStatus);
      }
      
      private function getUpdateInterval() : int
      {
         var _loc1_:String = AppSettings.getInstance().getSetting(AppSettings.MODERATION_CHECK_UPDATE_TIMER_SECONDS);
         var _loc2_:int = int(int(_loc1_));
         if(_loc2_ != 0)
         {
            this.updateInterval = _loc2_ * 1000;
         }
         return this.updateInterval;
      }
      
      public function stopTimerOrListener() : void
      {
         if(this.useNudge)
         {
            MessageCommunicator.unscribe(MSPEvent.NUDGE_EVENT_UPDATE_COMBAT,this.updateActorPenaltyStatus);
         }
         else if(this.updateTimer)
         {
            this.updateTimer.removeEventListener(TimerEvent.TIMER,this.updateActorPenaltyStatus);
            this.updateTimer.stop();
            this.updateTimer = null;
         }
      }
      
      private function updateActorPenaltyStatus(param1:Event = null) : void
      {
         var _loc2_:CombatRequestPenaltyInfoData = null;
         _loc2_ = new CombatRequestPenaltyInfoData(this.onPenaltyDataRecievedSuccess,this.onPenaltyDataRecievedFailure);
         dispatchEvent(new CombatEvent(CombatEvent.COMBAT_PROFILE_UPDATE_REQUESTED,_loc2_));
      }
      
      public function onPenaltyDataRecievedFailure(param1:Object) : void
      {
         ++this.failCounter;
         if(this.failCounter > this.retryTimes)
         {
            dispatchEvent(new CombatEvent(CombatEvent.COMBAT_PROFILE_UPDATE_FAILED,param1));
         }
         else
         {
            this.updateActorPenaltyStatus();
         }
      }
      
      private function onPenaltyDataRecievedSuccess(param1:Object) : void
      {
         if(param1.Object == null)
         {
            this.onPenaltyDataRecievedFailure(null);
         }
         else
         {
            dispatchEvent(new CombatEvent(CombatEvent.COMBAT_PROFILE_UPDATED,param1));
            this.failCounter = 0;
         }
      }
      
      private function checkHash(param1:Object, param2:String) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:String = "dfg@#%$FGDH";
         if(param1.BehaviourStatus != null)
         {
            _loc3_ += param1.BehaviourStatus.toString();
         }
         if(param1.LockedText != null)
         {
            _loc3_ += param1.LockedText.toString();
         }
         if(param1.LockedUntilText != null)
         {
            _loc4_ = param1.LockedUntilText;
            _loc5_ = _loc4_.split("/");
            _loc6_ = 0;
            _loc7_ = int(_loc5_.length);
            while(_loc6_ < _loc7_)
            {
               _loc3_ += _loc5_[_loc6_];
               _loc6_++;
            }
         }
         return SerializeUtils.checkHash(_loc3_,param2);
      }
      
      public function destroy() : void
      {
         this.failCounter = 0;
         this.stopTimerOrListener();
      }
   }
}

