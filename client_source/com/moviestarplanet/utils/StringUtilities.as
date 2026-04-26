package com.moviestarplanet.utils
{
   import com.moviestarplanet.globalsharedutils.messaging.MessageStyleUtility;
   
   public class StringUtilities
   {
      
      public function StringUtilities()
      {
         super();
      }
      
      public static function isEmpty(param1:String) : Boolean
      {
         if(param1 != null && trim(param1).length > 0)
         {
            return false;
         }
         return true;
      }
      
      public static function trim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         param1 = MessageStyleUtility.removeFontCode(param1);
         var _loc2_:int = 0;
         while(isWhitespace(param1.charAt(_loc2_)))
         {
            _loc2_++;
         }
         var _loc3_:* = int(param1.length - 1);
         while(isWhitespace(param1.charAt(_loc3_)))
         {
            _loc3_--;
         }
         if(_loc3_ >= _loc2_)
         {
            return param1.slice(_loc2_,_loc3_ + 1);
         }
         return "";
      }
      
      public static function getRedifiedHTMLText(param1:String, param2:Array) : String
      {
         var _loc6_:int = 0;
         var _loc3_:String = "";
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param2.length)
         {
            _loc6_ = param2[_loc5_].length - 2;
            _loc3_ += "<font color=\"#000000\">" + param1.slice(_loc4_,param2[_loc5_][_loc6_]) + "</font>" + "<font color=\"#ff0000\">" + param1.slice(param2[_loc5_][_loc6_],param2[_loc5_][_loc6_ + 1]) + "</font>";
            if(_loc5_ == param2.length - 1)
            {
               _loc3_ += "<font color=\"#000000\">" + param1.slice(param2[_loc5_][_loc6_ + 1],param1.length) + "</font>";
            }
            _loc4_ = int(param2[_loc5_][_loc6_ + 1]);
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function isWhitespace(param1:String) : Boolean
      {
         switch(param1)
         {
            case " ":
            case "\t":
            case "\r":
            case "\n":
            case "\f":
               return true;
            default:
               return false;
         }
      }
      
      public static function convertBreaksToNewLines(param1:String) : String
      {
         param1 = param1.split(/<br\s*\/>/i).join("\n");
         return param1.split("<br>").join("\n");
      }
      
      public static function removeNewLinesAndTabs(param1:String) : String
      {
         var _loc2_:RegExp = /(\t|\n|\r)/gi;
         return param1.replace(_loc2_,"");
      }
      
      public static function commaSeperatedString(param1:Array) : String
      {
         return param1.join(", ");
      }
      
      public static function truncate(param1:String, param2:int, param3:String = "...") : String
      {
         if(param1.length > param2)
         {
            param1 = param1.substring(0,param2 - param3.length) + param3;
         }
         return param1;
      }
   }
}

