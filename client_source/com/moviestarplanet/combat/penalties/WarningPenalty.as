package com.moviestarplanet.combat.penalties
{
   import com.moviestarplanet.combat.CombatHelper;
   import com.moviestarplanet.combat.CombatProfileUpdater;
   import com.moviestarplanet.combat.enums.CombatPromptButtons;
   import com.moviestarplanet.combat.valueobject.CombatCategorisation;
   
   public class WarningPenalty extends CombatPenalty
   {
      
      public function WarningPenalty(param1:CombatProfileUpdater)
      {
         super(param1);
      }
      
      override public function execute(param1:CombatCategorisation) : void
      {
         var _loc2_:String = CombatHelper.getInstance().getTitle(param1.CombatAction);
         var _loc3_:String = CombatHelper.getInstance().getMessage(param1.Category,param1.Level,param1.CombatAction);
         showPrompt(_loc3_,_loc2_,CombatPromptButtons.PROMPT_RULES_BUTTON | CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON | CombatPromptButtons.PROMPT_BLOCKING,CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON);
      }
   }
}

