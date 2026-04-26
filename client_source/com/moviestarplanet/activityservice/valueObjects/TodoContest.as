package com.moviestarplanet.activityservice.valueObjects
{
   public class TodoContest
   {
      
      public var ContestId:int;
      
      public var Name:String;
      
      public var Description:String;
      
      public var Status:int;
      
      public var OpeningTime:Date;
      
      public var ClosingTime:Date;
      
      public var VotingDeadline:Date;
      
      public var VotingRound:int;
      
      public var MaxNumberOfVotingRounds:int;
      
      public var PrizeMoney:int;
      
      public var SWFLarge:String;
      
      public var SWFList:String;
      
      public function TodoContest()
      {
         super();
      }
   }
}

