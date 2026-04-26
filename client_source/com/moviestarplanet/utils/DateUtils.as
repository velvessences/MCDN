package com.moviestarplanet.utils
{
   import com.moviestarplanet.commonvalueobjects.login.PostLoginData;
   import com.moviestarplanet.constants.events.EventsConstants;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.utils.dateformatter.MspDateFormatter;
   import flash.utils.getTimer;
   
   public class DateUtils
   {
      
      public static var actorModel:IActorModel;
      
      private static var _relativeTime:Number;
      
      private static var _serverTimepoint:Date;
      
      private static var isPostLoginDone:Boolean;
      
      private static var getNowAsStringFromBundleCallback:Function;
      
      private static var _relativeLoginTime:Number;
      
      public static const MS_PER_MIN:int = 1000 * 60;
      
      public static const MS_PER_HOUR:int = MS_PER_MIN * 60;
      
      public static const MS_PER_DAY:int = MS_PER_HOUR * 24;
      
      public function DateUtils()
      {
         super();
      }
      
      public static function getYearsSince(param1:Date) : int
      {
         var _loc2_:Date = new Date();
         var _loc3_:Date = new Date();
         _loc3_.setTime(_loc2_.getTime() - param1.getTime());
         return _loc3_.getFullYear() - 1970;
      }
      
      public static function daysInMonth(param1:int, param2:int) : int
      {
         var _loc4_:Boolean = false;
         var _loc3_:int = 31;
         switch(param1)
         {
            case 1:
               _loc4_ = param2 % 4 == 0 && param2 % 100 != 0 || param2 % 400 == 0;
               _loc3_ = _loc4_ ? 29 : 28;
               break;
            case 3:
            case 5:
            case 8:
            case 10:
               _loc3_ = 30;
         }
         return _loc3_;
      }
      
      public static function getNowAsStringFromBundle(param1:Function) : void
      {
         getNowAsStringFromBundleCallback = param1;
         MessageCommunicator.subscribe(EventsConstants.POST_LOGIN_BUNDLE_RECEIVED,onDataReceived);
      }
      
      private static function onDataReceived(param1:MsgEvent) : void
      {
         MessageCommunicator.unscribe(EventsConstants.POST_LOGIN_BUNDLE_RECEIVED,onDataReceived);
         var _loc2_:PostLoginData = param1.data as PostLoginData;
         getNowAsStringFromBundleCallback(_loc2_.Now);
         getNowAsStringFromBundleCallback = null;
         isPostLoginDone = true;
      }
      
      public static function UTCtoLocalTime(param1:Date) : Date
      {
         var _loc2_:Date = new Date(param1.time);
         var _loc3_:Number = -(_loc2_.getTimezoneOffset() / 60);
         _loc2_.hours += _loc3_;
         return _loc2_;
      }
      
      public static function createLocalTimeFromServerTime(param1:Date) : Date
      {
         return MspDateFormatter.createLocalTimeFromServerTime(param1);
      }
      
      public static function ToDateStringNoFlex(param1:Date) : String
      {
         return MspDateFormatter.ToDateStringNoFlex(param1);
      }
      
      public static function ToDateString(param1:Date) : String
      {
         return MspDateFormatter.ToDateString(param1);
      }
      
      public static function ToDateStringShort(param1:Date) : String
      {
         return MspDateFormatter.ToDateStringShort(param1);
      }
      
      public static function ToDateStringShort2(param1:Date) : String
      {
         return MspDateFormatter.ToDateStringShort2(param1);
      }
      
      public static function ToDateTimeString(param1:Date) : String
      {
         return MspDateFormatter.ToDateTimeString(param1);
      }
      
      public static function ToDateTimeString2(param1:Date) : String
      {
         return MspDateFormatter.ToDateTimeString2(param1);
      }
      
      public static function ToServerDateTimeString(param1:Date) : String
      {
         return MspDateFormatter.ToServerDateTimeString(param1);
      }
      
      public static function ToDateTimeStringWithFormat(param1:Date, param2:String) : String
      {
         return MspDateFormatter.ToDateTimeStringWithFormat(param1,param2);
      }
      
      public static function ToTimeString(param1:Date) : String
      {
         return MspDateFormatter.ToTimeString(param1);
      }
      
      public static function InitTime() : void
      {
         MspDateFormatter.ensureInitialized();
         _relativeLoginTime = getTimer();
         InitTimeFromStrings(getNowAsStringFromBundle);
      }
      
      public static function get nowUTC() : Date
      {
         if(isPostLoginDone == false)
         {
            return new Date();
         }
         var _loc1_:Number = getTimer() - _relativeLoginTime;
         var _loc2_:Date = new Date();
         var _loc3_:Date = actorModel.lastLogin;
         _loc2_.setTime(_loc3_.getTime() + _loc1_);
         return _loc2_;
      }
      
      public static function InitTimeFromStrings(param1:Function) : void
      {
         var done:Function = null;
         var getTimeFunc:Function = param1;
         done = function(param1:String):void
         {
            _relativeTime = getTimer();
            _serverTimepoint = parseDateFromUTC(param1);
         };
         getTimeFunc(done);
      }
      
      public static function get serverNow() : Date
      {
         if(_serverTimepoint != null)
         {
            return new Date(_serverTimepoint.getTime() + getTimer() - _relativeTime);
         }
         return new Date();
      }
      
      public static function parseDateFromW3CDTF(param1:String) : Date
      {
         var _loc2_:RegExp = /(\d{4})-(\d{1,2})-(\d{1,2})T(\d{1,2}):(\d{1,2}):(\d{1,2})/;
         var _loc3_:Array = _loc2_.exec(param1);
         if(_loc3_ != null && _loc3_.length == 7)
         {
            return new Date(Date.UTC(_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6]));
         }
         return null;
      }
      
      public static function parseDateFromUTC(param1:String) : Date
      {
         var _loc4_:Number = NaN;
         var _loc2_:RegExp = /(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})Z/;
         var _loc3_:Array = _loc2_.exec(param1);
         if(_loc3_ != null && _loc3_.length == 7)
         {
            _loc4_ = parseInt(_loc3_[2]) - 1;
            return new Date(Date.UTC(_loc3_[1],_loc4_,_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6]));
         }
         return null;
      }
      
      private static function addZeros(param1:Number, param2:int) : String
      {
         var _loc3_:String = param1.toString();
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
      
      public static function formatUTCDate(param1:Date) : String
      {
         return addZeros(param1.getUTCFullYear(),4) + "-" + addZeros(param1.getUTCMonth() + 1,2) + "-" + addZeros(param1.getUTCDate(),2) + " " + addZeros(param1.getUTCHours(),2) + ":" + addZeros(param1.getUTCMinutes(),2) + ":" + addZeros(param1.getUTCSeconds(),2) + "Z";
      }
      
      public static function addDateParamToUrl(param1:String) : String
      {
         var _loc2_:Date = new Date();
         return param1 + "?v=" + _loc2_.valueOf();
      }
      
      public static function isWithin(param1:Date, param2:Date, param3:Date) : Boolean
      {
         var _loc4_:Date = param2.time < param3.time ? param2 : param3;
         var _loc5_:Date = param2.time < param3.time ? param3 : param2;
         return param1.time >= _loc4_.time && param1.time <= _loc5_.time;
      }
      
      public static function dateToDays(param1:Date) : int
      {
         var _loc2_:int = int(param1.getDate());
         _loc2_ += param1.month * 30;
         return int(_loc2_ + param1.fullYear * 365);
      }
      
      public static function daysToMiliseconds(param1:Number) : Number
      {
         return param1 * hoursToMiliseconds(24);
      }
      
      public static function hoursToMiliseconds(param1:Number) : Number
      {
         return param1 * 3600000;
      }
      
      public static function msToHrsMinsSecsString(param1:int) : String
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc2_:int = int(int(param1 / 1000 % 60));
         var _loc3_:int = int(int(param1 / 1000 / 60 % 60));
         var _loc4_:int = int(int(param1 / 1000 / 60 / 60 % 24));
         if(_loc2_ < 10)
         {
            _loc5_ = "0" + _loc2_;
         }
         else
         {
            _loc5_ = "" + _loc2_;
         }
         if(_loc3_ < 10)
         {
            _loc6_ = "0" + _loc3_;
         }
         else
         {
            _loc6_ = "" + _loc3_;
         }
         if(_loc4_ < 10)
         {
            _loc7_ = "0" + _loc4_;
         }
         else
         {
            _loc7_ = "" + _loc4_;
         }
         if(_loc4_ == 0)
         {
            return _loc6_ + ":" + _loc5_;
         }
         return _loc7_ + ":" + _loc6_ + ":" + _loc5_;
      }
      
      public static function isDateXDaysOlderThanNow(param1:Date, param2:int) : Boolean
      {
         if(dateToDays(param1) + param2 < dateToDays(new Date()))
         {
            return true;
         }
         return false;
      }
   }
}

