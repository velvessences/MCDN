package com.moviestarplanet.combat
{
   import com.moviestarplanet.clientcensor.NannyBase;
   import com.moviestarplanet.combat.enums.CombatActions;
   import com.moviestarplanet.combat.enums.CombatEvent;
   import com.moviestarplanet.combat.penalties.CombatPenalty;
   import com.moviestarplanet.combat.penalties.HelplinePenalty;
   import com.moviestarplanet.combat.penalties.MutePenalty;
   import com.moviestarplanet.combat.penalties.WarningPenalty;
   import com.moviestarplanet.combat.valueobject.*;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   
   public class CombatProfileUpdater
   {
      
      public var blockerAllowed:Boolean = true;
      
      private var combatProfileChangeMonitor:WebServiceCombatProfilePuller;
      
      private var combatActionsDict:Dictionary;
      
      private var isInitialized:Boolean;
      
      private var so:SharedObject;
      
      protected var currentPrompt:Prompt;
      
      public function CombatProfileUpdater()
      {
         super();
      }
      
      public function getCombatPenaltyOfAction(param1:int) : CombatPenalty
      {
         return this.combatActionsDict[param1];
      }
      
      public function getCurrentPrompt() : Prompt
      {
         return this.currentPrompt;
      }
      
      public function setCurrentPrompt(param1:Prompt) : void
      {
         this.currentPrompt = param1;
      }
      
      public function initialize() : void
      {
         if(this.isInitialized == false)
         {
            this.isInitialized = true;
            this.combatProfileChangeMonitor = new WebServiceCombatProfilePuller();
            this.combatProfileChangeMonitor.addEventListener(CombatEvent.COMBAT_PROFILE_UPDATE_REQUESTED,this.onPenaltyDataRequest);
            this.combatProfileChangeMonitor.addEventListener(CombatEvent.COMBAT_PROFILE_UPDATED,this.onPenaltyDataRecievedSuccess);
            this.combatProfileChangeMonitor.addEventListener(CombatEvent.COMBAT_PROFILE_UPDATE_FAILED,this.onCombatProfileUpdateFailed);
            this.combatProfileChangeMonitor.start();
            this.setCurrentPrompt(null);
            if(this.combatActionsDict == null)
            {
               this.populatePenalties();
            }
            this.so = SharedObject.getLocal("msp_combat");
         }
      }
      
      public function updatePenaltyStatus() : void
      {
         this.combatProfileChangeMonitor.updatePenaltyStatus();
      }
      
      public function populatePenalties() : void
      {
         var _loc1_:CombatPenalty = this.getHelplinePenalty();
         var _loc2_:CombatPenalty = this.getWarningPenalty();
         var _loc3_:CombatPenalty = this.getLockPenalty();
         var _loc4_:CombatPenalty = this.getMutePenalty();
         this.combatActionsDict = new Dictionary();
         this.combatActionsDict[CombatActions.HELPLINE] = _loc1_;
         this.combatActionsDict[CombatActions.FIRST_WARNING] = _loc2_;
         this.combatActionsDict[CombatActions.LOCK_FOR_MINUTES] = _loc3_;
         this.combatActionsDict[CombatActions.LOCK_PERMANENT] = _loc3_;
         this.combatActionsDict[CombatActions.MUTE_FOR_MINUTES] = _loc4_;
         this.combatActionsDict[CombatActions.MUTE_FINAL] = _loc4_;
      }
      
      protected function getMutePenalty() : CombatPenalty
      {
         return new MutePenalty(this);
      }
      
      protected function getLockPenalty() : CombatPenalty
      {
         return null;
      }
      
      protected function getWarningPenalty() : CombatPenalty
      {
         return new WarningPenalty(this);
      }
      
      protected function getHelplinePenalty() : CombatPenalty
      {
         return new HelplinePenalty(this);
      }
      
      private function onPenaltyDataRecievedSuccess(param1:CombatEvent) : void
      {
         var _loc2_:CombatCategorisation = param1.data.Object.CombatCategorisation;
         if(_loc2_ == null || _loc2_.DateProcessed == null)
         {
            NannyBase.instance.updateModerationStatus(param1.data.Object.BehaviourStatus,param1.data.Object.LockedUntilDate,param1.data.Object.LockedText);
            this.penaltyExecuted();
            return;
         }
         this.handlePenaltyDataReceived(_loc2_);
      }
      
      private function handlePenaltyDataReceived(param1:CombatCategorisation) : void
      {
         var _loc2_:MutePenalty = null;
         if(param1.CombatAction != CombatActions.LOCK_FOR_MINUTES && param1.CombatAction != CombatActions.LOCK_PERMANENT && this.so.data.TimeCreated != undefined && this.so.data.TimeCreated != null)
         {
            if(this.so.data.TimeCreated == (param1.DateCreated as Date).time)
            {
               if(param1.CombatAction == CombatActions.MUTE_FINAL || param1.CombatAction == CombatActions.MUTE_FOR_MINUTES)
               {
                  _loc2_ = this.combatActionsDict[param1.CombatAction] as MutePenalty;
                  _loc2_.setMuteCategorisation(param1);
               }
               return;
            }
         }
         this.so.data.TimeCreated = (param1.DateCreated as Date).time;
         this.so.flush();
         this.triggerPenalty(param1);
      }
      
      public function triggerPenalty(param1:CombatCategorisation, param2:Function = null) : void
      {
         var _loc3_:CombatPenalty = this.combatActionsDict[param1.CombatAction];
         if(_loc3_ != null)
         {
            _loc3_.overrideCloseFunction = param2;
            _loc3_.execute(param1);
            this.penaltyExecuted();
         }
      }
      
      private function onCombatProfileUpdateFailed(param1:CombatEvent) : void
      {
         this.setCurrentPrompt(null);
         NannyBase.instance.doLogoutImmediately();
      }
      
      protected function onPenaltyDataRequest(param1:CombatEvent) : void
      {
      }
      
      protected function penaltyExecuted() : void
      {
      }
      
      public function destroyUpdateTimer() : void
      {
         this.combatProfileChangeMonitor.stopTimerOrListener();
      }
      
      public function destroy() : void
      {
         this.isInitialized = false;
         this.setCurrentPrompt(null);
         if(this.combatProfileChangeMonitor != null)
         {
            this.combatProfileChangeMonitor.removeEventListener(CombatEvent.COMBAT_PROFILE_UPDATED,this.onPenaltyDataRecievedSuccess);
            this.combatProfileChangeMonitor.removeEventListener(CombatEvent.COMBAT_PROFILE_UPDATE_FAILED,this.onCombatProfileUpdateFailed);
            this.combatProfileChangeMonitor.removeEventListener(CombatEvent.COMBAT_PROFILE_UPDATE_REQUESTED,this.onPenaltyDataRequest);
            this.combatProfileChangeMonitor.destroy();
            this.combatProfileChangeMonitor = null;
         }
      }
   }
}

