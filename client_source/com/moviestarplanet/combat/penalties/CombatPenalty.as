package com.moviestarplanet.combat.penalties
{
   import com.moviestarplanet.combat.CombatProfileUpdater;
   import com.moviestarplanet.combat.enums.CombatPromptButtons;
   import com.moviestarplanet.combat.valueobject.CombatCategorisation;
   import com.moviestarplanet.combat.valueobject.PendingCombatPromptData;
   import com.moviestarplanet.configurations.AppSettings;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import com.moviestarplanet.windowpopup.popup.PromptEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class CombatPenalty implements ICombatPenalty
   {
      
      [Inject]
      public var localeManager:ILocaleManager;
      
      protected var _overrideCloseFunction:Function;
      
      protected var prompt:Prompt;
      
      protected var combatUpdater:CombatProfileUpdater;
      
      protected var helpcenterURL:String;
      
      protected var helplineURL:String;
      
      protected var rulesURL:String;
      
      public var afterCloseCallback:Function;
      
      private var pendingCombatPrompts:Vector.<PendingCombatPromptData> = new Vector.<PendingCombatPromptData>();
      
      public function CombatPenalty(param1:CombatProfileUpdater)
      {
         super();
         InjectionManager.manager().injectMe(this);
         this.combatUpdater = param1;
         this.helpcenterURL = AppSettings.getInstance().getSetting(AppSettings.HELP_CENTER_LINK);
         this.helplineURL = AppSettings.getInstance().getSetting(AppSettings.SAFETY_HELPLINE_LINK);
         this.rulesURL = AppSettings.getInstance().getSetting(AppSettings.SAFETY_RULES_LINK);
      }
      
      public function set overrideCloseFunction(param1:Function) : void
      {
         this._overrideCloseFunction = param1;
      }
      
      public function showPrompt(param1:String = "", param2:String = "", param3:uint = 4, param4:uint = 2, param5:Boolean = true) : void
      {
         if(this.combatUpdater.getCurrentPrompt() == null)
         {
            this.prompt = Prompt.showCombat(param1,param2,param3,null,this.closeHandlerButton,null,param4,null,this.buttonClickCallback,param5);
            this.prompt.setBlockerVisibility(this.combatUpdater.blockerAllowed);
            this.combatUpdater.setCurrentPrompt(this.prompt);
         }
         else
         {
            this.pendingCombatPrompts.push(new PendingCombatPromptData(param1,param2,param3,param4,param5));
         }
      }
      
      protected function buttonClickCallback(param1:PromptEvent) : void
      {
         if(param1.detail == CombatPromptButtons.PROMPT_RULES_BUTTON)
         {
            navigateToURL(new URLRequest(this.rulesURL));
         }
         else if(param1.detail == CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON)
         {
            navigateToURL(new URLRequest(this.helpcenterURL));
         }
         else if(param1.detail == CombatPromptButtons.PROMPT_HELP_LINE_BUTTON)
         {
            navigateToURL(new URLRequest(this.helplineURL));
         }
      }
      
      protected function closeHandlerButton(param1:PromptEvent) : void
      {
         var _loc2_:PendingCombatPromptData = null;
         this.overrideCloseFunction = null;
         this.combatUpdater.setCurrentPrompt(null);
         this._overrideCloseFunction = null;
         if(this.afterCloseCallback != null)
         {
            this.afterCloseCallback();
            this.afterCloseCallback = null;
         }
         if(this.pendingCombatPrompts.length > 0)
         {
            _loc2_ = this.pendingCombatPrompts.shift();
            this.showPrompt(_loc2_.text,_loc2_.title,_loc2_.flags,_loc2_.defaultButtonFlag,_loc2_.showAnchorCharacter);
         }
      }
      
      public function execute(param1:CombatCategorisation) : void
      {
      }
      
      public function destroy() : void
      {
      }
   }
}

