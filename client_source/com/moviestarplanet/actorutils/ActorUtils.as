package com.moviestarplanet.actorutils
{
   import com.moviestarplanet.actor.IGenderSpecific;
   import com.moviestarplanet.utils.DateUtils;
   
   public class ActorUtils
   {
      
      public function ActorUtils()
      {
         super();
      }
      
      public static function isJudge(param1:Number) : Boolean
      {
         return param1 >= 180;
      }
      
      public static function isJury(param1:Number) : Boolean
      {
         return !isJudge(param1) && param1 >= 90;
      }
      
      public static function isCeleb(param1:Number) : Boolean
      {
         return param1 >= 100;
      }
      
      public static function isVip(param1:Date) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return DateUtils.nowUTC.getTime() < param1.getTime();
      }
      
      public static function isDeleted(param1:int) : Boolean
      {
         return param1 > 0;
      }
      
      public static function isFemale(param1:IGenderSpecific) : Boolean
      {
         return getSkinIdActor(param1) == 1;
      }
      
      public static function isFemaleSkinSwf(param1:String) : Boolean
      {
         return getSkinIdFromSkinSwf(param1) == 1;
      }
      
      private static function getSkinIdFromSkinSwf(param1:String) : int
      {
         return param1 == "femaleskin" ? 1 : 2;
      }
      
      public static function getSkinIdActor(param1:IGenderSpecific) : int
      {
         var _loc2_:int = 1;
         if(param1 != null && param1.SkinSWF != null)
         {
            _loc2_ = getSkinIdFromSkinSwf(param1.SkinSWF);
         }
         return _loc2_;
      }
   }
}

