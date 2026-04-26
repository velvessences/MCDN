package com.moviestarplanet.membership
{
   import com.moviestarplanet.utils.DateUtils;
   
   public class UserTypeDeterminator
   {
      
      public static const DAYS_LEFT_OF_MEMBERSHIP_FOR_DISPLAYING_VIP_OFFERS_AGAIN:int = 8;
      
      public static const IS_NOT_VIP:int = 0;
      
      public static const IS_VIP:int = 1;
      
      public static const IS_VIP_RUNNING_OUT:int = 2;
      
      public function UserTypeDeterminator()
      {
         super();
      }
      
      public static function determineUserTypeByDaysLimit(param1:Date) : int
      {
         var _loc2_:Date = param1;
         var _loc3_:Date = DateUtils.nowUTC;
         var _loc4_:Date = new Date(_loc2_.getTime());
         _loc4_.date = _loc2_.date - DAYS_LEFT_OF_MEMBERSHIP_FOR_DISPLAYING_VIP_OFFERS_AGAIN;
         if(_loc3_ > _loc4_ && _loc3_ < _loc2_)
         {
            return IS_VIP_RUNNING_OUT;
         }
         if(_loc3_ < _loc2_)
         {
            return IS_VIP;
         }
         return IS_NOT_VIP;
      }
   }
}

