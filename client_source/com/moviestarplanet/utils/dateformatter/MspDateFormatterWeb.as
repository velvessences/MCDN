package com.moviestarplanet.utils.dateformatter
{
   import mx.formatters.DateFormatter;
   
   public class MspDateFormatterWeb extends AbstractMspDateFormatter
   {
      
      private var formatter:DateFormatter;
      
      public function MspDateFormatterWeb()
      {
         super();
         this.formatter = new DateFormatter();
      }
      
      override protected function doFormat(param1:Date) : String
      {
         return this.formatter.format(param1);
      }
      
      override protected function setFormatTo(param1:String) : void
      {
         this.formatter.formatString = param1;
      }
   }
}

