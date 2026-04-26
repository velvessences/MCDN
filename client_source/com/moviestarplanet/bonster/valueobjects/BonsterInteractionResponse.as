package com.moviestarplanet.bonster.valueobjects
{
   public class BonsterInteractionResponse
   {
      
      public static const RESULT_CODE_SUCCESS:int = 0;
      
      public static const RESULT_CODE_EXCEPTION:int = -1;
      
      public static const RESULT_CODE_NOT_VIP:int = -2;
      
      public static const RESULT_CODE_NOT_ENOUGH_SC:int = -3;
      
      public static const RESULT_CODE_NOT_ENOUGH_DIAMONDS:int = -4;
      
      public static const RESULT_CODE_PET_SICK:int = -5;
      
      public var resultCode:int;
      
      public var level:int;
      
      public var evolutionStage:int;
      
      public var experience:int;
      
      public var experienceToNextLevel:int;
      
      public var experienceToCurrentLevel:int;
      
      public var lastInteractionDate:Date;
      
      public var interactionPoints:int;
      
      public var fameEarned:int;
      
      public function BonsterInteractionResponse()
      {
         super();
      }
   }
}

