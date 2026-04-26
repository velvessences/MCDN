package com.moviestarplanet.activityservice.valueObjects
{
   public class Todo
   {
      
      public var TodoId:int;
      
      public var ActorId:int;
      
      public var Deadline:Date;
      
      public var Type:int;
      
      public var FriendId:int;
      
      public var MovieId:int;
      
      public var ContestId:int;
      
      public var MovieCompetitionId:int;
      
      public var Priority:int;
      
      public var GiftId:int;
      
      public var EntityId:int;
      
      public var Actor:TodoActor;
      
      public var Friend:TodoActor;
      
      public var Movie:TodoMovie;
      
      public var Contest:TodoContest;
      
      public var MovieCompetition:TodoMovieCompetition;
      
      public function Todo()
      {
         super();
      }
   }
}

