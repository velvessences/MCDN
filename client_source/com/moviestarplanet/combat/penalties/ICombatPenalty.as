package com.moviestarplanet.combat.penalties
{
   import com.moviestarplanet.combat.valueobject.CombatCategorisation;
   
   public interface ICombatPenalty
   {
      
      function execute(param1:CombatCategorisation) : void;
   }
}

