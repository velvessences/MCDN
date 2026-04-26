package com.moviestarplanet.Clubs
{
   import com.moviestarplanet.club.valueobjects.Club;
   import com.moviestarplanet.club.valueobjects.ClubActor;
   import com.moviestarplanet.club.valueobjects.ClubActorRel;
   import com.moviestarplanet.club.valueobjects.ClubEntityListItem;
   import com.moviestarplanet.club.valueobjects.ClubMember;
   import com.moviestarplanet.club.valueobjects.PagedClubEntityContentList;
   import com.moviestarplanet.club.valueobjects.PagedClubList;
   import com.moviestarplanet.club.valueobjects.PagedClubMembersList;
   import com.moviestarplanet.commoninterfaces.IRegistrator;
   import flash.net.registerClassAlias;
   
   public class ClubRegistrator implements IRegistrator
   {
      
      private static var hasRegistered:Boolean = false;
      
      public function ClubRegistrator()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         if(!hasRegistered)
         {
            registerClassAlias("MovieStarPlanet.DBML.Club",Club);
            registerClassAlias("MovieStarPlanet.DBML.ClubActorRel",ClubActorRel);
            registerClassAlias("MovieStarPlanet.DBML.ClubMember",ClubMember);
            registerClassAlias("MovieStarPlanet.DBML.ClubEntityListItem",ClubEntityListItem);
            registerClassAlias("MovieStarPlanet.WebService.Clubs.ClubActor",ClubActor);
            registerClassAlias("MovieStarPlanet.WebService.Clubs.PagedClubList",PagedClubList);
            registerClassAlias("MovieStarPlanet.WebService.Clubs.PagedClubEntityContentList",PagedClubEntityContentList);
            registerClassAlias("MovieStarPlanet.WebService.Clubs.PagedClubMembersList",PagedClubMembersList);
            hasRegistered = true;
         }
      }
   }
}

