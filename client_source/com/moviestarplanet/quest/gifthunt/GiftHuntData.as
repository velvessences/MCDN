package com.moviestarplanet.quest.gifthunt
{
   public class GiftHuntData
   {
      
      public static var TYPE_NEW_USER:int = 1;
      
      public static var TYPE_DAILY:int = 2;
      
      public static var TYPE_QUEST_DAILY_BLUE:int = 3;
      
      public static var SPECIAL_EVENT_QUEST:int = 4;
      
      public static var SPECIAL_EVENT_QUEST_1:int = 5;
      
      public static var SPECIAL_EVENT_QUEST_2:int = 6;
      
      public static var SPECIAL_EVENT_QUEST_3:int = 7;
      
      public var ActorId:int;
      
      public var GiftData:String;
      
      public var GiftHuntId:int;
      
      public var GiftType:int;
      
      public var QuestId:int;
      
      public function GiftHuntData()
      {
         super();
      }
   }
}

