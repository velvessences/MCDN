package com.moviestarplanet.friendship.valueobjects
{
   public class ActorRelationship
   {
      
      public static const MAX_NUM_BESTFRIENDS:int = 3;
      
      public var ActorRelationshipId:int;
      
      public var ActorId:int;
      
      public var FriendId:int;
      
      public var RelationshipTypeId:int;
      
      public var Status:int;
      
      public var OrderBy:int;
      
      public function ActorRelationship()
      {
         super();
      }
   }
}

