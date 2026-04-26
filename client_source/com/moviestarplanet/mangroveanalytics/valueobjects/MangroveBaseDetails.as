package com.moviestarplanet.mangroveanalytics.valueobjects
{
   import flash.utils.getTimer;
   
   public class MangroveBaseDetails
   {
      
      public var UserId:String;
      
      public var Country:String;
      
      public var Level:int;
      
      public var FriendCount:int;
      
      public var FriendCountVIP:int;
      
      public var TotalVipDays:int;
      
      public var IsVip:Boolean;
      
      public var Created:Date;
      
      public var MembershipTimeoutDate:Date;
      
      public var MembershipPurchasedDate:Date;
      
      public var LastLogin:Date;
      
      public var PushNotificationEnabled:Boolean;
      
      private var _TimeNow:Number;
      
      private var lastTimeLocal:Number;
      
      public function MangroveBaseDetails()
      {
         super();
         lastTimeLocal = getTimer();
      }
      
      public function get TimeNow() : Number
      {
         _TimeNow += getTimer() - lastTimeLocal;
         lastTimeLocal = getTimer();
         return _TimeNow;
      }
      
      public function set TimeNow(param1:Number) : void
      {
         _TimeNow = param1;
         lastTimeLocal = getTimer();
      }
      
      public function get SessionLength() : Number
      {
         if(LastLogin == null)
         {
            return 0;
         }
         var _loc1_:Number = TimeNow - LastLogin.time;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      public function get VipDaysRemaining() : Number
      {
         if(!IsVip || MembershipTimeoutDate == null)
         {
            return 0;
         }
         var _loc2_:Number = Number(MembershipTimeoutDate.time);
         var _loc1_:int = msToDays(_loc2_ - TimeNow);
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      private function msToDays(param1:Number) : Number
      {
         return param1 / 86400000;
      }
   }
}

