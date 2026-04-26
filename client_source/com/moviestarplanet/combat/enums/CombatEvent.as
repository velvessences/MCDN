package com.moviestarplanet.combat.enums
{
   import com.moviestarplanet.events.MsgEvent;
   
   public class CombatEvent extends MsgEvent
   {
      
      public static const COMBAT_PROFILE_UPDATE_REQUESTED:String = "COMBAT_PROFILE_UPDATE_REQUESTED";
      
      public static const COMBAT_PROFILE_UPDATED:String = "COMBAT_PROFILE_UPDATED";
      
      public static const COMBAT_PROFILE_UPDATE_FAILED:String = "COMBAT_PROFILE_UPDATE_FAILED";
      
      public function CombatEvent(param1:String, param2:* = null, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

