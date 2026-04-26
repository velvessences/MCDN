package com.moviestarplanet.level.configuration
{
   public interface ILevelConfiguration
   {
      
      function getLevelFame(param1:int) : Number;
      
      function getLevelByFame(param1:Number) : int;
      
      function getLevelPercentage(param1:int, param2:Number) : Number;
      
      function getLevelResourceId(param1:int) : String;
      
      function getMaximumLevel() : int;
      
      function get levelThresholds() : Array;
      
      function set levelThresholds(param1:Array) : void;
   }
}

