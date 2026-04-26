package com.moviestarplanet.utils.dateformatter
{
   public interface IMspDateFormatter
   {
      
      function ToDateStringNoFlex(param1:Date) : String;
      
      function ToDateString(param1:Date) : String;
      
      function ToDateStringShort(param1:Date) : String;
      
      function ToDateStringShort2(param1:Date) : String;
      
      function ToDateTimeString(param1:Date) : String;
      
      function ToDateTimeString2(param1:Date) : String;
      
      function ToServerDateTimeString(param1:Date) : String;
      
      function ToDateTimeStringWithFormat(param1:Date, param2:String) : String;
      
      function ToTimeString(param1:Date) : String;
   }
}

