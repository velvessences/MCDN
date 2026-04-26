package com.moviestarplanet.pet.utils
{
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.utils.DateUtils;
   
   public class ClickItemUtil
   {
      
      public function ClickItemUtil()
      {
         super();
      }
      
      public static function getClickItemInfo(param1:int) : ClickItemInformation
      {
         var _loc2_:ClickItemInformation = null;
         _loc2_ = new ClickItemInformation();
         if(isPlant(param1))
         {
            _loc2_.foodPrice = PlantConstants.FOODPRICE;
            _loc2_.medicinePrice = PlantConstants.MEDICINPRICE;
            _loc2_.medicinePrice2 = PlantConstants.MEDICINPRICE2;
            _loc2_.foodPoint = PlantConstants.FOODPOINT;
            _loc2_.vipFoodPoints = PlantConstants.VIPFOODPOINTS;
            _loc2_.minFeedingIntervalMs = PlantConstants.MIN_FEEDING_INTERVAL_MS;
            _loc2_.maxFeedingIntervalMs = PlantConstants.MAX_FEEDING_INTERVAL_MS;
            _loc2_.foodPointsPerStage = PlantConstants.FOODPOINTS_PER_STAGE;
            _loc2_.foodPointsSickLevel = PlantConstants.FOODPOINT_SICK_LEVEL;
         }
         else
         {
            _loc2_.foodPrice = MonsterConstants.FOODPRICE;
            _loc2_.medicinePrice = MonsterConstants.MEDICINPRICE;
            _loc2_.medicinePrice2 = MonsterConstants.MEDICINPRICE2;
            _loc2_.foodPoint = MonsterConstants.FOODPOINT;
            _loc2_.vipFoodPoints = MonsterConstants.VIPFOODPOINTS;
            _loc2_.minFeedingIntervalMs = MonsterConstants.MIN_FEEDING_INTERVAL_MS;
            _loc2_.maxFeedingIntervalMs = MonsterConstants.MAX_FEEDING_INTERVAL_MS;
            _loc2_.foodPointsPerStage = MonsterConstants.FOODPOINTS_PER_STAGE;
            _loc2_.foodPointsSickLevel = MonsterConstants.FOODPOINT_SICK_LEVEL;
         }
         return _loc2_;
      }
      
      public static function isPlant(param1:int) : Boolean
      {
         switch(param1)
         {
            case 6:
            case 8:
               return true;
            default:
               return false;
         }
      }
      
      public static function calculateDirtPoints(param1:Date, param2:int, param3:int) : Number
      {
         if(isPlant(param2) || param3 == 0)
         {
            return 0;
         }
         var _loc4_:Number = DateUtils.nowUTC.getTime() - param1.getTime();
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         var _loc5_:int = _loc4_ / MonsterConstants.MAX_BATHING_INTERVAL_MS;
         if(_loc5_ > MonsterConstants.MAX_DIRT_POINTS)
         {
            _loc5_ = MonsterConstants.MAX_DIRT_POINTS;
         }
         return _loc5_;
      }
      
      public static function startHatching(param1:ActorClickItemRel, param2:Object) : void
      {
         param1.Stage = 1;
         param1.FoodPoints = 0;
         var _loc3_:Date = DateUtils.nowUTC;
         _loc3_.setHours(_loc3_.getHours() - 10);
         param1.LastFeedTime = _loc3_;
         param1.Data = SerializeUtils.serialize(param2);
      }
      
      public static function calcActualFoodPoints(param1:int, param2:Date) : int
      {
         var _loc3_:Number = Number(DateUtils.nowUTC.getTime());
         var _loc4_:Number = _loc3_ - param2.getTime();
         var _loc5_:int = _loc4_ / MonsterConstants.MAX_FEEDING_INTERVAL_MS;
         return int(param1 - _loc5_);
      }
      
      public static function clipItemToData(param1:ActorClickItemRel) : Object
      {
         var _loc2_:Object = new Object();
         _loc2_.ActorClickItemRelId = param1.ActorClickItemRelId;
         _loc2_.Data = param1.Data;
         _loc2_.ActorId = param1.ActorId;
         _loc2_.ClickItemId = param1.ClickItemId;
         _loc2_.Stage = param1.Stage;
         _loc2_.timeSinceFeed = DateUtils.nowUTC.getTime() - param1.LastFeedTime.getTime();
         _loc2_.timeSinceWash = DateUtils.nowUTC.getTime() - param1.LastWashTime.getTime();
         return _loc2_;
      }
      
      public static function dataToClipItem(param1:Object) : ActorClickItemRel
      {
         var _loc2_:ActorClickItemRel = new ActorClickItemRel();
         _loc2_.ActorClickItemRelId = param1.ActorClickItemRelId;
         _loc2_.Data = param1.Data;
         _loc2_.ActorId = param1.ActorId;
         _loc2_.ClickItemId = param1.ClickItemId;
         _loc2_.Stage = param1.Stage;
         _loc2_.FoodPoints = 9;
         _loc2_.LastFeedTime = new Date(DateUtils.nowUTC.getTime() - param1.timeSinceFeed);
         _loc2_.LastWashTime = new Date(DateUtils.nowUTC.getTime() - param1.timeSinceWash);
         _loc2_.PlayPoints = 0;
         _loc2_.Name = "";
         return _loc2_;
      }
   }
}

