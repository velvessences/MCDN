package com.moviestarplanet.combat
{
   import com.moviestarplanet.combat.enums.CombatActions;
   import com.moviestarplanet.combat.enums.CombatCategories;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.locale.ILocaleManager;
   import com.moviestarplanet.logging.Log;
   
   public class CombatHelper
   {
      
      private static var instance:CombatHelper;
      
      [Inject]
      public var localeManager:ILocaleManager;
      
      public function CombatHelper(param1:SingletonBlocker)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Use getInstance().");
         }
         InjectionManager.manager().injectMe(this);
      }
      
      public static function getInstance() : CombatHelper
      {
         if(instance == null)
         {
            instance = new CombatHelper(new SingletonBlocker());
         }
         return instance;
      }
      
      private function getActionName(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case CombatActions.FIRST_WARNING:
               _loc2_ = "WARNING";
               break;
            case CombatActions.HELPLINE:
               _loc2_ = "VULNERABLE";
               break;
            case CombatActions.MUTE_FOR_MINUTES:
            case CombatActions.MUTE_FINAL:
               _loc2_ = "MUTE";
               break;
            case CombatActions.LOCK_FOR_MINUTES:
            case CombatActions.LOCK_PERMANENT:
               _loc2_ = "LOCK";
               break;
            default:
               _loc2_ = "";
         }
         return _loc2_;
      }
      
      public function getTitle(param1:int, param2:Array = null) : String
      {
         var _loc4_:int = 0;
         var _loc3_:String = "";
         switch(param1)
         {
            case CombatActions.FIRST_WARNING:
            case CombatActions.HELPLINE:
            case CombatActions.LOCK_FOR_MINUTES:
               _loc3_ = this.localeManager.getString("COMBAT_SANCTION_" + this.getActionName(param1),param2);
               break;
            case CombatActions.MUTE_FOR_MINUTES:
            case CombatActions.MUTE_FINAL:
               _loc4_ = int(int(param2[0]));
               if(_loc4_ >= 60)
               {
                  _loc3_ = this.localeManager.getString("COMBAT_SANCTION_MUTE_HOURS",[Math.floor(_loc4_ / 60)]);
                  break;
               }
               _loc3_ = this.localeManager.getString("COMBAT_SANCTION_MUTE_MINUTES",param2);
               break;
            case CombatActions.LOCK_PERMANENT:
               _loc3_ = this.localeManager.getString("COMBAT_SANCTION_PERMALOCK",param2);
               break;
            default:
               _loc3_ = "";
         }
         return _loc3_;
      }
      
      public function getMessage(param1:String, param2:int, param3:int, param4:Array = null) : String
      {
         var _loc5_:String = "";
         switch(param1)
         {
            case CombatCategories.PP:
               _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_PP_LVL" + param2,param4);
               break;
            case CombatCategories.TE:
               _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_TE_LVL" + param2,param4);
               break;
            case CombatCategories.CC:
               _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_CC_LVL" + param2,param4);
               break;
            case CombatCategories.OV:
               _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_OS_LVL" + param2,param4);
               break;
            case CombatCategories.CB:
               _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_CB_LVL" + param2,param4);
               break;
            case CombatCategories.CS:
               _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_CS_LVL" + param2,param4);
               break;
            case CombatCategories.VP:
               _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_VP",param4);
               break;
            case CombatCategories.TR:
               _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_TR_LVL" + param2,param4);
               break;
            case CombatCategories.SP:
               _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_SP_LVL" + param2,param4);
               break;
            case CombatCategories.AR:
               if(param3 == CombatActions.HELPLINE)
               {
                  _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_VP",param4);
                  break;
               }
               _loc5_ = this.localeManager.getString("COMBAT_BROKENRULES_AR_" + this.getActionName(param3),param4);
               break;
            default:
               _loc5_ = "";
         }
         return _loc5_;
      }
      
      public function logUserBehaviorFailure(param1:MsgEvent) : void
      {
         Log.getInstance().log(Log.ERROR,"UserBehaviorServiceFail");
      }
   }
}

class SingletonBlocker
{
   
   public function SingletonBlocker()
   {
      super();
   }
}
