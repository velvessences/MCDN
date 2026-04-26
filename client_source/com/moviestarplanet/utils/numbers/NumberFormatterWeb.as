package com.moviestarplanet.utils.numbers
{
   import mx.formatters.CurrencyFormatter;
   import mx.formatters.NumberBaseRoundType;
   
   public class NumberFormatterWeb
   {
      
      private static var _currencyFormatter:CurrencyFormatter;
      
      private static var defaultFormat:Object;
      
      public function NumberFormatterWeb()
      {
         super();
      }
      
      public static function formatNumberInner(param1:Number, param2:String, param3:String = null, param4:String = null, param5:Boolean = false) : String
      {
         var _loc6_:String = null;
         if(param3)
         {
            currencyFormatter.currencySymbol = param3;
         }
         else
         {
            currencyFormatter.currencySymbol = defaultFormat.currencySymbol;
         }
         if(param4)
         {
            currencyFormatter.alignSymbol = param4;
         }
         else
         {
            currencyFormatter.alignSymbol = defaultFormat.align;
         }
         switch(param2)
         {
            case NumberFormatType.CURRENCY:
               currencyFormatter.precision = -1;
               break;
            case NumberFormatType.FAME:
            case NumberFormatType.STARCOINS:
            case NumberFormatType.DIAMONDS:
            case NumberFormatType.WATCHEDCOUNT:
            case NumberFormatType.LIKES:
            case NumberFormatType.PURCHASEDCOUNT:
            default:
               currencyFormatter.precision = 0;
         }
         if(param5)
         {
            currencyFormatter.precision = 2;
         }
         return formatCurrency(param1);
      }
      
      private static function formatCurrency(param1:Number) : String
      {
         return currencyFormatter.format(param1);
      }
      
      public static function reset(param1:String) : void
      {
         NumberFormatter.country = param1;
         defaultFormat = null;
         _currencyFormatter = null;
      }
      
      private static function get currencyFormatter() : CurrencyFormatter
      {
         if(_currencyFormatter == null)
         {
            switch(NumberFormatter.country)
            {
               case "dk":
               case "se":
               case "de":
               case "nl":
               case "tr":
                  defaultFormat = {
                     "align":"left",
                     "thousand":".",
                     "decimal":","
                  };
                  break;
               case "us":
               case "uk":
               case "ie":
               case "ca":
               case "au":
               case "nz":
                  defaultFormat = {
                     "align":"left",
                     "thousand":",",
                     "decimal":"."
                  };
                  break;
               case "fr":
               case "no":
               case "fi":
               case "pl":
                  defaultFormat = {
                     "align":"right",
                     "thousand":" ",
                     "decimal":","
                  };
                  break;
               default:
                  defaultFormat = {
                     "align":"left",
                     "thousand":",",
                     "decimal":"."
                  };
            }
            defaultFormat.currencySymbol = "";
            _currencyFormatter = new CurrencyFormatter();
            _currencyFormatter.alignSymbol = defaultFormat.align;
            _currencyFormatter.currencySymbol = defaultFormat.currencySymbol;
            _currencyFormatter.decimalSeparatorFrom = defaultFormat.decimal;
            _currencyFormatter.decimalSeparatorTo = defaultFormat.decimal;
            _currencyFormatter.thousandsSeparatorFrom = defaultFormat.thousand;
            _currencyFormatter.thousandsSeparatorTo = defaultFormat.thousand;
            _currencyFormatter.rounding = NumberBaseRoundType.NONE;
            _currencyFormatter.useThousandsSeparator = true;
            _currencyFormatter.useNegativeSign = true;
            _currencyFormatter.precision = 0;
         }
         return _currencyFormatter;
      }
   }
}

