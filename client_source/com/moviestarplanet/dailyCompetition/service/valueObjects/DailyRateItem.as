package com.moviestarplanet.dailyCompetition.service.valueObjects
{
   import flash.events.EventDispatcher;
   
   public class DailyRateItem extends EventDispatcher
   {
      
      public var ThemeId:int;
      
      public var ThemeName:String;
      
      public var ContentType:int;
      
      public var IdA:int;
      
      public var IdB:int;
      
      public var ActorIdA:int;
      
      public var ActorIdB:int;
      
      public var ScoreA:Number;
      
      public var ScoreB:Number;
      
      public var nameA:String;
      
      public var nameB:String;
      
      public var data:Boolean;
      
      public function DailyRateItem()
      {
         super();
      }
   }
}

