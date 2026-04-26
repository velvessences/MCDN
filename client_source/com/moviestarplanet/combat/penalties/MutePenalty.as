package com.moviestarplanet.combat.penalties
{
   import com.moviestarplanet.clientcensor.NannyBase;
   import com.moviestarplanet.clientcensor.NannyEvent;
   import com.moviestarplanet.combat.CombatHelper;
   import com.moviestarplanet.combat.CombatProfileUpdater;
   import com.moviestarplanet.combat.enums.CombatPromptButtons;
   import com.moviestarplanet.combat.valueobject.CombatCategorisation;
   import com.moviestarplanet.utils.DateUtils;
   
   public class MutePenalty extends CombatPenalty
   {
      
      private var combatCategorisation:CombatCategorisation;
      
      public function MutePenalty(param1:CombatProfileUpdater)
      {
         super(param1);
         NannyBase.instance.addEventListener(NannyEvent.NEED_SHOW_MUTE_POPUP,this.onShowPopup,false,0,true);
      }
      
      override public function execute(param1:CombatCategorisation) : void
      {
         this.combatCategorisation = param1;
         var _loc2_:Number = param1.DurationMinutes;
         var _loc3_:Number = DateUtils.serverNow.time - param1.DateCreated.time;
         var _loc4_:int = int(Math.ceil(param1.DurationMinutes - _loc3_ / 60000) as int);
         NannyBase.instance.setMuteFor(_loc4_);
         this.showMutePrompt();
      }
      
      public function setMuteCategorisation(param1:CombatCategorisation) : void
      {
         this.combatCategorisation = param1;
      }
      
      private function showMutePrompt() : void
      {
         if(this.combatCategorisation == null)
         {
            return;
         }
         var _loc1_:Number = this.combatCategorisation.DurationMinutes;
         var _loc2_:Number = DateUtils.serverNow.time - this.combatCategorisation.DateCreated.time;
         var _loc3_:int = int(Math.ceil(this.combatCategorisation.DurationMinutes - _loc2_ / 60000) as int);
         if(_loc3_ <= 0)
         {
            return;
         }
         var _loc4_:String = CombatHelper.getInstance().getTitle(this.combatCategorisation.CombatAction,[_loc3_]);
         var _loc5_:String = CombatHelper.getInstance().getMessage(this.combatCategorisation.Category,this.combatCategorisation.Level,this.combatCategorisation.CombatAction);
         showPrompt(_loc5_,_loc4_,CombatPromptButtons.PROMPT_RULES_BUTTON | CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON | CombatPromptButtons.PROMPT_BLOCKING,CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON);
      }
      
      private function onShowPopup(param1:NannyEvent) : void
      {
         this.showMutePrompt();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         NannyBase.instance.removeEventListener(NannyEvent.NEED_SHOW_MUTE_POPUP,this.onShowPopup);
      }
   }
}

