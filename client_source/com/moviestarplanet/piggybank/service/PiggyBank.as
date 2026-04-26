package com.moviestarplanet.piggybank.service
{
   public class PiggyBank
   {
      
      public static const STATE_UNBREKABLE:int = 0;
      
      public static const STATE_NORMAL_BREAK:int = 1;
      
      public static const STATE_VIP_BREAK:int = 2;
      
      public var StarCoins:int;
      
      public var Fame:int;
      
      public var Diamonds:int;
      
      public var PiggyBankState:int;
      
      public function PiggyBank()
      {
         super();
      }
   }
}

