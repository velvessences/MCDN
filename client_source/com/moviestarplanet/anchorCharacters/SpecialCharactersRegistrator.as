package com.moviestarplanet.anchorCharacters
{
   import com.moviestarplanet.anchorCharacters.valueobjects.AnchorCharacterActivityVO;
   import com.moviestarplanet.anchorCharacters.valueobjects.AnchorCharacterInfoVO;
   import flash.net.registerClassAlias;
   
   public class SpecialCharactersRegistrator
   {
      
      private static var hasRegistered:Boolean = false;
      
      public function SpecialCharactersRegistrator()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         if(!hasRegistered)
         {
            registerClassAlias("MovieStarPlanet.Model.AnchorCharacter.ValueObjects.AnchorCharacterInfoVO",AnchorCharacterInfoVO);
            registerClassAlias("MovieStarPlanet.Model.AnchorCharacter.ValueObjects.AnchorCharacterActivityVO",AnchorCharacterActivityVO);
            hasRegistered = true;
         }
      }
   }
}

