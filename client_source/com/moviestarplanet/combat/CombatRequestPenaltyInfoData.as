package com.moviestarplanet.combat
{
   public class CombatRequestPenaltyInfoData
   {
      
      public var onDataRecievedSuccess:Function;
      
      public var onDataRecievedFailure:Function;
      
      public function CombatRequestPenaltyInfoData(param1:Function, param2:Function)
      {
         super();
         this.onDataRecievedSuccess = param1;
         this.onDataRecievedFailure = param2;
      }
   }
}

