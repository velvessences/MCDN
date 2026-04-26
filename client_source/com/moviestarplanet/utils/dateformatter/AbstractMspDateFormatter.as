package com.moviestarplanet.utils.dateformatter
{
   internal class AbstractMspDateFormatter implements IMspDateFormatter
   {
      
      private static const TYPE_ToDateTimeStringWithFormat:int = -1;
      
      private static const TYPE_ToDateString:int = 1;
      
      private static const TYPE_ToDateStringShort:int = 2;
      
      private static const TYPE_ToDateStringShort2:int = 3;
      
      private static const TYPE_ToDateTimeString:int = 4;
      
      private static const TYPE_ToDateTimeString2:int = 5;
      
      private static const TYPE_ToTimeString:int = 6;
      
      private var currentFormat:int;
      
      private var formats:Object;
      
      public function AbstractMspDateFormatter()
      {
         super();
         this.currentFormat = -1;
         this.formats = new Object();
         this.formats[TYPE_ToDateString] = "EEE MMM D YYYY";
         this.formats[TYPE_ToDateStringShort] = "DD/MM/YY";
         this.formats[TYPE_ToDateStringShort2] = "DD/MM-YYYY";
         this.formats[TYPE_ToDateTimeString] = "DD/MM/YYYY JJ:NN";
         this.formats[TYPE_ToDateTimeString2] = "EEE DD/MM-YYYY JJ:NN";
         this.formats[TYPE_ToTimeString] = "JJ:NN";
      }
      
      public function ToDateStringNoFlex(param1:Date) : String
      {
         return this.ToDateString(param1);
      }
      
      public function ToDateString(param1:Date) : String
      {
         this.updateformatter(TYPE_ToDateString);
         return this.doFormat(param1);
      }
      
      public function ToDateStringShort(param1:Date) : String
      {
         this.updateformatter(TYPE_ToDateStringShort);
         return this.doFormat(param1);
      }
      
      public function ToDateStringShort2(param1:Date) : String
      {
         this.updateformatter(TYPE_ToDateStringShort2);
         return this.doFormat(param1);
      }
      
      public function ToDateTimeString(param1:Date) : String
      {
         this.updateformatter(TYPE_ToDateTimeString);
         return this.doFormat(param1);
      }
      
      public function ToDateTimeString2(param1:Date) : String
      {
         this.updateformatter(TYPE_ToDateTimeString2);
         return this.doFormat(param1);
      }
      
      public function ToServerDateTimeString(param1:Date) : String
      {
         return this.ToDateTimeString2(param1);
      }
      
      public function ToTimeString(param1:Date) : String
      {
         this.updateformatter(TYPE_ToTimeString);
         return this.doFormat(param1);
      }
      
      public function ToDateTimeStringWithFormat(param1:Date, param2:String) : String
      {
         this.updateformatter(TYPE_ToDateTimeStringWithFormat,param2);
         return this.doFormat(param1);
      }
      
      private function updateformatter(param1:int, param2:String = null) : void
      {
         var _loc3_:String = null;
         if(this.currentFormat == TYPE_ToDateTimeStringWithFormat || this.currentFormat != param1 || param1 == TYPE_ToDateTimeStringWithFormat)
         {
            this.currentFormat = param1;
            _loc3_ = param2 == null ? this.formats[param1] : param2;
            this.setFormatTo(_loc3_);
         }
      }
      
      protected function doFormat(param1:Date) : String
      {
         throw new Error("Override me");
      }
      
      protected function setFormatTo(param1:String) : void
      {
         throw new Error("Override me");
      }
   }
}

