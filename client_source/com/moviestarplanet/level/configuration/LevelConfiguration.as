package com.moviestarplanet.level.configuration
{
   import com.moviestarplanet.injection.InjectionManager;
   
   public class LevelConfiguration implements ILevelConfiguration
   {
      
      private var _levelThresholds:Array;
      
      public function LevelConfiguration()
      {
         super();
         InjectionManager.manager().injectMe(this);
      }
      
      public function getLevelFame(param1:int) : Number
      {
         if(param1 > this.levelThresholds.length)
         {
            return int.MAX_VALUE;
         }
         return this.levelThresholds[param1];
      }
      
      public function getLevelByFame(param1:Number) : int
      {
         var _loc4_:Number = NaN;
         var _loc2_:int = int(this.levelThresholds.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = Number(this.levelThresholds[_loc3_]);
            if(_loc4_ > param1)
            {
               return _loc3_ - 1;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function getLevelPercentage(param1:int, param2:Number) : Number
      {
         var _loc3_:Number = this.getLevelFame(param1);
         var _loc4_:Number = this.getLevelFame(param1 + 1);
         return int((param2 - _loc3_) / (_loc4_ - _loc3_) * 100);
      }
      
      public function getLevelResourceId(param1:int) : String
      {
         return "LEVEL" + param1;
      }
      
      public function getMaximumLevel() : int
      {
         return this.levelThresholds.length - 1;
      }
      
      public function set levelThresholds(param1:Array) : void
      {
         this._levelThresholds = param1;
      }
      
      public function get levelThresholds() : Array
      {
         return this._levelThresholds;
      }
   }
}

