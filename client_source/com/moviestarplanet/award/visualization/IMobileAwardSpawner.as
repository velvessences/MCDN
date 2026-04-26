package com.moviestarplanet.award.visualization
{
   import flash.geom.Point;
   
   public interface IMobileAwardSpawner
   {
      
      function addAwards(param1:int, param2:int, param3:int, param4:Boolean = false, param5:Number = 0.5, param6:Number = 0.5, param7:Point = null, param8:Point = null) : void;
      
      function registerAwardsCollected(param1:Function) : void;
      
      function unregisterAwardsCollected(param1:Function) : void;
   }
}

