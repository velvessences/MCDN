package com.moviestarplanet.usersession.valueobjects
{
   import com.moviestarplanet.combat.valueobject.CombatCategorisation;
   
   public class ActorDetailsExtended
   {
      
      public var Details:ActorDetails;
      
      public var CombatCategorisationCheckEnabled:Boolean;
      
      public var ModerationStatus:ActorModerationStatus;
      
      public var CombatCategorisation:com.moviestarplanet.combat.valueobject.CombatCategorisation;
      
      public var Version:String;
      
      public function ActorDetailsExtended()
      {
         super();
      }
   }
}

