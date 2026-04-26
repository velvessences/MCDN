package com.moviestarplanet.utils.chatfilter.nanny
{
   import com.moviestarplanet.clientcensor.NannyBase;
   import com.moviestarplanet.combat.CombatHelper;
   import com.moviestarplanet.combat.CombatProfileUpdaterWeb;
   import com.moviestarplanet.combat.enums.CombatActions;
   import com.moviestarplanet.combat.enums.CombatPromptButtons;
   import com.moviestarplanet.combat.penalties.CombatPenalty;
   import com.moviestarplanet.connections.LogoutHandler;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.usersession.service.UserSessionAMFService;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class WebNanny extends NannyBase
   {
      
      private static var instance:WebNanny;
      
      public static const EXTRA_MESSAGE_TIME:Number = 2 * 1000;
      
      private var pendingAction:String = null;
      
      private var pendingText:String = null;
      
      private var afterClosed:Function;
      
      private const SHOW_HELP_LINK:String = "SHOW_HELP_LINK";
      
      private const SHOW_WARNING:String = "SHOW_WARNING";
      
      private var lockConfirmTimer:Timer;
      
      public function WebNanny(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : WebNanny
      {
         if(instance == null)
         {
            instance = new WebNanny(new SingletonEnforcer());
         }
         return instance;
      }
      
      override protected function showWarning(param1:String) : void
      {
         this.pendingText = param1;
         this.pendingAction = this.SHOW_WARNING;
      }
      
      override public function showHelpLink() : void
      {
         this.pendingAction = this.SHOW_HELP_LINK;
      }
      
      public function executePendingActionIfAny(param1:Function) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:CombatPenalty = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:CombatPenalty = null;
         if(this.pendingAction == null)
         {
            if(param1 != null)
            {
               param1();
            }
         }
         else
         {
            this.afterClosed = param1;
            if(this.pendingAction == this.SHOW_HELP_LINK)
            {
               _loc2_ = MSPLocaleManagerWeb.getInstance().getString("COMBAT_SANCTION_VULNERABLE");
               _loc3_ = MSPLocaleManagerWeb.getInstance().getString("COMBAT_BROKENRULES_VP");
               CombatProfileUpdaterWeb.getInstance().initialize();
               _loc4_ = CombatProfileUpdaterWeb.getInstance().getCombatPenaltyOfAction(CombatActions.HELPLINE);
               _loc4_.afterCloseCallback = this.helpOrWarningPromptClosed;
               _loc4_.showPrompt(_loc3_,_loc2_,CombatPromptButtons.PROMPT_HELP_LINE_BUTTON | CombatPromptButtons.PROMPT_BLOCKING,CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON,false);
            }
            else if(this.pendingAction == this.SHOW_WARNING)
            {
               _loc5_ = (this.pendingText == null ? "" : this.pendingText) + "\r\n" + MSPLocaleManagerWeb.getInstance().getString("COMBAT_BROKENRULES_AR_WARNING");
               _loc6_ = MSPLocaleManagerWeb.getInstance().getString("WARNING");
               CombatProfileUpdaterWeb.getInstance().initialize();
               _loc7_ = CombatProfileUpdaterWeb.getInstance().getCombatPenaltyOfAction(CombatActions.FIRST_WARNING);
               _loc7_.afterCloseCallback = this.helpOrWarningPromptClosed;
               _loc7_.showPrompt(_loc5_,_loc6_,CombatPromptButtons.PROMPT_RULES_BUTTON | CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON | CombatPromptButtons.PROMPT_BLOCKING,CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON);
            }
            this.pendingAction = null;
            this.pendingText = null;
         }
      }
      
      override public function showUserLockedAndLogout(param1:String, param2:Date, param3:Function = null) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:CombatPenalty = null;
         if(this.lockConfirmTimer == null)
         {
            _loc4_ = int(Math.ceil((param2.time - new Date().time) / 60000));
            _loc5_ = _loc4_ < 60 * 24 ? 1 : int(Math.ceil((_loc4_ as Number) / (60 * 24)));
            if(_loc5_ > 200)
            {
               _loc6_ = CombatHelper.getInstance().getTitle(CombatActions.LOCK_PERMANENT);
            }
            else
            {
               _loc6_ = CombatHelper.getInstance().getTitle(CombatActions.LOCK_FOR_MINUTES,[_loc5_]);
            }
            _loc7_ = (param1 == null ? "" : param1) + "\r\n" + MSPLocaleManagerWeb.getInstance().getString("COMBAT_BROKENRULES_AR_LOCK");
            CombatProfileUpdaterWeb.getInstance().initialize();
            _loc8_ = CombatProfileUpdaterWeb.getInstance().getCombatPenaltyOfAction(CombatActions.LOCK_PERMANENT);
            _loc8_.afterCloseCallback = this.lockWindowClosedOrTimedOut;
            _loc8_.overrideCloseFunction = param3;
            _loc8_.showPrompt(_loc7_,_loc6_,CombatPromptButtons.PROMPT_RULES_BUTTON | CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON | CombatPromptButtons.PROMPT_BLOCKING,CombatPromptButtons.PROMPT_HELP_CENTER_BUTTON);
            this.lockConfirmTimer = new Timer(60 * 2000,1);
            this.lockConfirmTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.lockWindowClosedOrTimedOut);
            this.lockConfirmTimer.start();
         }
      }
      
      private function lockWindowClosedOrTimedOut(param1:Event = null) : void
      {
         this.clearTimer();
         this.doLogoutImmediately();
      }
      
      private function clearTimer() : void
      {
         if(this.lockConfirmTimer != null)
         {
            this.lockConfirmTimer.stop();
            this.lockConfirmTimer = null;
         }
      }
      
      private function helpOrWarningPromptClosed() : void
      {
         UserSessionAMFService.instance.UpdateBehaviourStatus(ActorSession.loggedInActor.ActorId,0,"",-1,-1,null);
         if(this.afterClosed != null)
         {
            this.afterClosed();
            this.afterClosed = null;
         }
      }
      
      override public function doLogoutImmediately() : void
      {
         LogoutHandler.getInstance().logout();
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
