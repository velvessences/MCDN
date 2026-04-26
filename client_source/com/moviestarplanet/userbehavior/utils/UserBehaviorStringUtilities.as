package com.moviestarplanet.userbehavior.utils
{
   public class UserBehaviorStringUtilities
   {
      
      public function UserBehaviorStringUtilities()
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
      
      public static function cleanHTMLCode(param1:String) : String
      {
         var _loc2_:RegExp = /&#/;
         return param1.replace(_loc2_,"");
      }
      
      public static function convertBreaksToNewLines(param1:String) : String
      {
         param1 = param1.split(/<br\s*\/>/i).join("\n");
         return param1.split("<br>").join("\n");
      }
   }
}

