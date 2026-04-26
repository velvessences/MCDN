package com.moviestarplanet.combat
{
   import com.moviestarplanet.clientcensor.NannyBase;
   import com.moviestarplanet.combat.enums.CombatPromptButtons;
   import com.moviestarplanet.combat.penalties.CombatPenalty;
   import com.moviestarplanet.combat.valueobject.CombatCategorisation;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.utils.DateUtils;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import com.moviestarplanet.windowpopup.popup.PromptEvent;
   
   public class LockPenaltyWeb extends CombatPenalty
   {
      
      public static const USER_LOCK_POPUP_SHOWN:String = "LockPenaltyWeb.USER_LOCK_POPUP_SHOWN";
      
      public function LockPenaltyWeb(param1:CombatProfileUpdater)
      {
         super(param1);
      }
      
      override public function showPrompt(param1:String = "", param2:String = "", param3:uint = 4, param4:uint = 4, param5:Boolean = true) : void
      {
         if(combatUpdater.getCurrentPrompt() == null)
         {
            MessageCommunicator.sendMessage(USER_LOCK_POPUP_SHOWN,null);
            prompt = Prompt.showCombat(param1,param2,param3,null,this.closeHandlerButton,null,param4,this.onClickBlockerClicked,buttonClickCallback,param5);
            combatUpdater.setCurrentPrompt(prompt);
         }
      }
      
      protected function onClickBlockerClicked() : void
      {
      }
      
      override protected function closeHandlerButton(param1:PromptEvent) : void
      {
         if(_overrideCloseFunction == null)
         {
            combatUpdater.destroy();
            if(ActorSession.loggedInActor != null)
            {
               NannyBase.instance.doLogoutImmediately();
            }
         }
         else
         {
            _overrideCloseFunction();
         }
      }
      
      override public function execute(param1:CombatCategorisation) : void
      {
         var _loc2_:Number = param1.DurationMinutes;
         var _loc3_:Number = DateUtils.serverNow.time - param1.DateCreated.time;
         var _loc4_:int = int(Math.ceil(param1.DurationMinutes - _loc3_ / 60000) as int);
         var _loc5_:int = _loc4_ < 60 * 24 ? 1 : int(Math.ceil((_loc4_ as Number) / (60 * 24)));
         var _loc6_:String = CombatHelper.getInstance().getTitle(param1.CombatAction,[_loc5_]);
         var _loc7_:String = CombatHelper.getInstance().getMessage(param1.Category,param1.Level,param1.CombatAction);
         this.showPrompt(_loc7_,_loc6_,CombatPromptButtons.PROMPT_RULES_BUTTON | CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON | CombatPromptButtons.PROMPT_BLOCKING,CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON);
         combatUpdater.destroyUpdateTimer();
      }
   }
}

