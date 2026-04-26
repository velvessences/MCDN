package com.moviestarplanet.utils.dateformatter
{
   import com.moviestarplanet.injection.InjectionManager;
   
   public class MspDateFormatter
   {
      
      private static var formatter:IMspDateFormatter;
      
      public function MspDateFormatter()
      {
         super();
      }
      
      public static function ensureInitialized() : void
      {
         formatter = InjectionManager.manager().getInstance(IMspDateFormatter);
      }
      
      public static function createLocalTimeFromServerTime(param1:Date) : Date
      {
         var _loc2_:Date = new Date();
         _loc2_.setTime(getServerMillisecs(param1));
         return _loc2_;
      }
      
      private static function getServerMillisecs(param1:Date) : Number
      {
         return param1.getTime() - param1.timezoneOffset * 60000;
      }
      
      public static function ToDateStringNoFlex(param1:Date) : String
      {
         param1 = createLocalTimeFromServerTime(param1);
         return formatter.ToDateStringNoFlex(param1);
      }
      
      public static function ToDateString(param1:Date) : String
      {
         return formatter.ToDateString(param1);
      }
      
      public static function ToDateStringShort(param1:Date) : String
      {
         param1 = createLocalTimeFromServerTime(param1);
         return formatter.ToDateStringShort(param1);
      }
      
      public static function ToDateStringShort2(param1:Date) : String
      {
         param1 = createLocalTimeFromServerTime(param1);
         return formatter.ToDateStringShort2(param1);
      }
      
      public static function ToDateTimeString(param1:Date) : String
      {
         if(param1 == null)
         {
            return "null";
         }
         param1 = createLocalTimeFromServerTime(param1);
         return formatter.ToDateTimeString(param1);
      }
      
      public static function ToDateTimeString2(param1:Date) : String
      {
         if(param1 == null)
         {
            return "null";
         }
         param1 = createLocalTimeFromServerTime(param1);
         return formatter.ToDateTimeString2(param1);
      }
      
      public static function ToServerDateTimeString(param1:Date) : String
      {
         if(param1 == null)
         {
            return "null";
         }
         return formatter.ToServerDateTimeString(param1);
      }
      
      public static function ToDateTimeStringWithFormat(param1:Date, param2:String) : String
      {
         if(param1 == null)
         {
            return "null";
         }
         param1 = createLocalTimeFromServerTime(param1);
         return formatter.ToDateTimeStringWithFormat(param1,param2);
      }
      
      public static function ToTimeString(param1:Date) : String
      {
         param1 = createLocalTimeFromServerTime(param1);
         return formatter.ToTimeString(param1);
      }
   }
}

