package com.moviestarplanet.dailyCompetition.service
{
   import com.moviestarplanet.amf.AmfCaller;
   import com.moviestarplanet.dailyCompetition.service.valueObjects.DailyRateItem;
   import com.moviestarplanet.dailyCompetition.service.valueObjects.DailyThemeItem;
   import flash.net.registerClassAlias;
   
   public class DailyCompetitionAmfService
   {
      
      private static var amfCaller:AmfCaller = new AmfCaller("MovieStarPlanet.WebService.DailyCompetition.AMFDailyCompetitionService");
      
      registerClassAlias("MovieStarPlanet.WebService.DailyCompetition.DailyRateValueObject",DailyRateItem);
      registerClassAlias("MovieStarPlanet.WebService.DailyCompetition.DailyThemeValueObject",DailyThemeItem);
      
      public function DailyCompetitionAmfService()
      {
         super();
      }
      
      public static function getRandomItems(param1:Function, param2:int) : void
      {
         amfCaller.callFunction("getRandomItem",[param2],true,param1);
      }
      
      public static function getTodaysTheme(param1:Function) : void
      {
         amfCaller.callFunction("getTodaysTheme",[],false,param1);
      }
      
      public static function getVoteScore(param1:Function, param2:int) : void
      {
         amfCaller.callFunction("getVoteScore",[param2],false,param1);
      }
      
      public static function addToComp(param1:Function, param2:int, param3:int, param4:int) : void
      {
         amfCaller.callFunction("addToComp",[param2,param3,param4],true,param1);
      }
      
      public static function canSubmit(param1:Function, param2:int, param3:int) : void
      {
         amfCaller.callFunction("canSubmit",[param2,param3],false,param1);
      }
      
      public static function voteFor(param1:Function, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         amfCaller.callFunction("voteFor",[param2,param3,param4,param5,param6],true,param1);
      }
      
      public static function incrementSubmissionResets(param1:int) : void
      {
         amfCaller.callFunction("IncrementSubmissionResets",[],true,null);
      }
   }
}

