package com.moviestarplanet.friendship
{
   import com.moviestarplanet.commoninterfaces.IRegistrator;
   import com.moviestarplanet.friendship.valueobjects.AcceptToBeMySpecialFriendArgs;
   import com.moviestarplanet.friendship.valueobjects.ActorBrowseItem;
   import com.moviestarplanet.friendship.valueobjects.ActorBrowseItemMySchool;
   import com.moviestarplanet.friendship.valueobjects.ActorRelationship;
   import com.moviestarplanet.friendship.valueobjects.ActorSpecialSummary;
   import com.moviestarplanet.friendship.valueobjects.AskToBeMySpecialFriendArgs;
   import com.moviestarplanet.friendship.valueobjects.BoyFriend;
   import com.moviestarplanet.friendship.valueobjects.FriendData;
   import com.moviestarplanet.friendship.valueobjects.PagedActorBrowseItemList;
   import com.moviestarplanet.friendship.valueobjects.RejectMySpecialFriendArgs;
   import flash.net.registerClassAlias;
   
   public class FriendshipRegistrator implements IRegistrator
   {
      
      private static var hasRegistered:Boolean = false;
      
      public function FriendshipRegistrator()
      {
         super();
      }
      
      public function registerClassAliases() : void
      {
         if(!hasRegistered)
         {
            registerClassAlias("MovieStarPlanet.WebService.Friendships.AcceptToBeMySpecialFriendArgs",AcceptToBeMySpecialFriendArgs);
            registerClassAlias("MovieStarPlanet.WebService.WebService+ActorBrowseItem",ActorBrowseItem);
            registerClassAlias("MovieStarPlanet.Model.Actor.ValueObjects.ActorSearchItem",ActorBrowseItem);
            registerClassAlias("MovieStarPlanet.Model.School.ValueObjects.ActorBrowseItemMySchool",ActorBrowseItemMySchool);
            registerClassAlias("MovieStarPlanet.DBML.ActorRelationship",ActorRelationship);
            registerClassAlias("MovieStarPlanet.WebService.WebService+PagedActorBrowseItemList",PagedActorBrowseItemList);
            registerClassAlias("MovieStarPlanet.DBML.BoyFriend",BoyFriend);
            registerClassAlias("MovieStarPlanet.WebService.Friendships.AskToBeMySpecialFriendArgs",AskToBeMySpecialFriendArgs);
            registerClassAlias("MovieStarPlanet.WebService.Friendships.RejectToBeMySpecialFriendArgs",RejectMySpecialFriendArgs);
            registerClassAlias("MovieStarPlanet.WebService.Friendships.FriendData",FriendData);
            registerClassAlias("MovieStarPlanet.WebService.Friendships.ActorSpecialSummary",ActorSpecialSummary);
            hasRegistered = true;
         }
      }
   }
}

