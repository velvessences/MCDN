package com.moviestarplanet.globalsharedutils.messaging
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class MessageStyleUtility
   {
      
      private static const CODE_CHAR:String = String.fromCharCode(30);
      
      public static const FONT_COLOR_BLACK:uint = 0;
      
      public static const FONT_COLOR_RED:uint = 13369344;
      
      public static const FONT_COLOR_PURPLE:uint = 6684774;
      
      public static const FONT_COLOR_PURPLE_STRONG:uint = 13369446;
      
      public static const FONT_COLOR_GREEN:uint = 3368448;
      
      public static const FONT_COLOR_ORANGE:uint = 16737792;
      
      public static const FONT_COLOR_PURPLE_LIGHT:uint = 6710988;
      
      public static const FONT_COLOR_BLUE:uint = 39372;
      
      public static const CODE_TYPE_FONTCOLOR:String = "fontcolor";
      
      public static const FONT_COLOR_SYSTEM:uint = 6710886;
      
      public static const FONT_COLOR_CENSORED:uint = 16711680;
      
      public static const ALL_COLORS:Vector.<uint> = Vector.<uint>([FONT_COLOR_BLUE,FONT_COLOR_PURPLE_LIGHT,FONT_COLOR_ORANGE,FONT_COLOR_GREEN,FONT_COLOR_PURPLE_STRONG,FONT_COLOR_PURPLE,FONT_COLOR_RED,FONT_COLOR_BLACK]);
      
      private static var ALL_COLORS_DICTIONARY:Dictionary = new Dictionary();
      
      ALL_COLORS_DICTIONARY[FONT_COLOR_BLACK] = CODE_CHAR + "STYLE(fontcolor={" + FONT_COLOR_BLACK + "})" + CODE_CHAR;
      ALL_COLORS_DICTIONARY[FONT_COLOR_RED] = CODE_CHAR + "STYLE(fontcolor={" + FONT_COLOR_RED + "})" + CODE_CHAR;
      ALL_COLORS_DICTIONARY[FONT_COLOR_PURPLE] = CODE_CHAR + "STYLE(fontcolor={" + FONT_COLOR_PURPLE + "})" + CODE_CHAR;
      ALL_COLORS_DICTIONARY[FONT_COLOR_PURPLE_STRONG] = CODE_CHAR + "STYLE(fontcolor={" + FONT_COLOR_PURPLE_STRONG + "})" + CODE_CHAR;
      ALL_COLORS_DICTIONARY[FONT_COLOR_GREEN] = CODE_CHAR + "STYLE(fontcolor={" + FONT_COLOR_GREEN + "})" + CODE_CHAR;
      ALL_COLORS_DICTIONARY[FONT_COLOR_ORANGE] = CODE_CHAR + "STYLE(fontcolor={" + FONT_COLOR_ORANGE + "})" + CODE_CHAR;
      ALL_COLORS_DICTIONARY[FONT_COLOR_PURPLE_LIGHT] = CODE_CHAR + "STYLE(fontcolor={" + FONT_COLOR_PURPLE_LIGHT + "})" + CODE_CHAR;
      ALL_COLORS_DICTIONARY[FONT_COLOR_BLUE] = CODE_CHAR + "STYLE(fontcolor={" + FONT_COLOR_BLUE + "})" + CODE_CHAR;
      
      public function MessageStyleUtility()
      {
         super();
      }
      
      public static function containsFontCode(param1:String) : Boolean
      {
         return CodeCharUtilities.containsCodeChar(param1,CODE_CHAR);
      }
      
      public static function removeFontCode(param1:String) : String
      {
         if(containsFontCode(param1) == true)
         {
            param1 = param1.split(extractEntireCode(param1)).join("");
         }
         return param1;
      }
      
      public static function removeAndAddFontCode(param1:String, param2:uint) : String
      {
         if(containsFontCode(param1) == true)
         {
            param1 = param1.split(extractEntireCode(param1)).join("");
         }
         return param1 + addFontCode(param2);
      }
      
      public static function extractEntireCode(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(containsFontCode(param1) == true)
         {
            _loc2_ = int(param1.indexOf(CODE_CHAR));
            _loc3_ = param1.lastIndexOf(CODE_CHAR) + 1;
            return param1.substring(_loc2_,_loc3_);
         }
         throw new Error("String " + param1 + " does not contain any system codes.");
      }
      
      public static function extractCodeType(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(containsFontCode(param1) == true)
         {
            _loc2_ = param1.lastIndexOf("(") + 1;
            _loc3_ = int(param1.lastIndexOf("="));
            return param1.substring(_loc2_,_loc3_);
         }
         throw new Error("String " + param1 + " does not contain any system codes.");
      }
      
      public static function extractFontCodeParameters(param1:String) : uint
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         if(containsFontCode(param1) == true)
         {
            _loc2_ = param1.lastIndexOf("{") + 1;
            _loc3_ = int(param1.lastIndexOf("}"));
            return uint(uint(param1.substring(_loc2_,_loc3_)));
         }
         throw new Error("String " + param1 + " does not contain any system codes.");
      }
      
      public static function addFontCode(param1:uint) : String
      {
         if(param1 == FONT_COLOR_SYSTEM || param1 == FONT_COLOR_CENSORED)
         {
            return CODE_CHAR + "STYLE(fontcolor={" + param1 + "})" + CODE_CHAR;
         }
         if(!ALL_COLORS_DICTIONARY[param1])
         {
            throw new Error("String " + param1 + " is not a valid color code.");
         }
         return ALL_COLORS_DICTIONARY[param1];
      }
      
      public static function addFormatedText(param1:TextField, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:TextFormat = null;
         var _loc5_:uint = 0;
         if(containsFontCode(param2))
         {
            _loc4_ = param1.defaultTextFormat;
            _loc5_ = extractFontCodeParameters(param2);
            param2 = removeFontCode(param2);
            _loc4_.color = _loc5_;
            if(_loc5_ == FONT_COLOR_SYSTEM)
            {
               _loc4_.italic = true;
            }
            param1.defaultTextFormat = _loc4_;
         }
         if(param3)
         {
            _loc4_ = param1.defaultTextFormat;
            _loc4_.italic = true;
            _loc4_.color = FONT_COLOR_SYSTEM;
            param1.defaultTextFormat = _loc4_;
         }
         param1.text = param2;
      }
      
      public static function getRawTextFromFormattedText(param1:TextField) : String
      {
         return param1.text + addFontCode(param1.defaultTextFormat.color as uint);
      }
      
      public static function getRawTextFromFormattedTextNoCheck(param1:TextField) : String
      {
         return Object(param1).textNoCheck + addFontCode(param1.defaultTextFormat.color as uint);
      }
      
      public static function formatTextField(param1:*) : void
      {
         var _loc2_:String = param1.text;
         var _loc3_:uint = FONT_COLOR_BLACK;
         if(containsFontCode(_loc2_))
         {
            switch(extractCodeType(_loc2_))
            {
               case MessageStyleUtility.CODE_TYPE_FONTCOLOR:
                  param1.textColor = extractFontCodeParameters(_loc2_);
                  param1.text = removeFontCode(_loc2_);
            }
         }
      }
   }
}

