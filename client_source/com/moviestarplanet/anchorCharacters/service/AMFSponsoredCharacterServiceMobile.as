package com.moviestarplanet.anchorCharacters.service
{
   import com.moviestarplanet.amf.AmfCaller;
   
   public class AMFSponsoredCharacterServiceMobile extends AMFSponsoredCharacterService
   {
      
      public function AMFSponsoredCharacterServiceMobile()
      {
         super();
         amfCaller = new AmfCaller("MovieStarPlanet.MobileServices.AnchorCharacter.AMFAnchorCharacterService");
      }
   }
}

