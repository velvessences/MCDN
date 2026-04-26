package com.moviestarplanet.utils.translation
{
   import com.moviestarplanet.font.IFontManager;
   import com.moviestarplanet.utils.ComponentUtilities;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   import flash.utils.getQualifiedClassName;
   
   public class TranslationUtilities
   {
      
      public static var fontManager:IFontManager;
      
      private static var _substFonts:Array;
      
      public function TranslationUtilities()
      {
         super();
         throw new Error("Do not make new instance of " + getQualifiedClassName(this));
      }
      
      public static function translate(param1:String) : String
      {
         var _loc5_:String = null;
         if(!param1)
         {
            return "";
         }
         var _loc2_:String = param1;
         var _loc3_:int = -1;
         var _loc4_:int = -1;
         do
         {
            if(_loc3_ >= 0 && _loc4_ >= 0 && _loc4_ > _loc3_)
            {
               _loc5_ = _loc2_.substring(_loc3_ + 1,_loc4_);
               _loc2_ = _loc2_.replace(_loc2_.substring(_loc3_,_loc4_ + 1),LocaleHelper.getInstance().getString(_loc5_));
               if(_loc2_ == "null")
               {
                  trace("WARNING: Translation for " + _loc5_ + " failed");
               }
            }
            _loc3_ = int(_loc2_.indexOf("["));
            _loc4_ = int(_loc2_.indexOf("]"));
         }
         while(_loc3_ >= 0 && _loc4_ >= 0);
         return _loc2_;
      }
      
      public static function removeLocale(param1:String) : String
      {
         return param1.substr(7);
      }
      
      public static function translateByName(param1:TextField, param2:Boolean = false) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(param1.name.indexOf("LOCALE_") == 0)
         {
            _loc3_ = removeLocale(param1.name);
            _loc4_ = LocaleHelper.getInstance().getString(_loc3_) || "";
            if(param2)
            {
               _loc5_ = param1.htmlText;
               param1.htmlText = _loc4_;
               checkAlign(param1,_loc5_,param2);
            }
            else
            {
               _loc5_ = param1.text;
               param1.text = _loc4_;
               checkAlign(param1,_loc5_,param2);
            }
            return true;
         }
         return false;
      }
      
      private static function checkAlign(param1:TextField, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:String = param3 ? param1.htmlText : param1.text;
         if(_loc4_ != param2 && param1.type != TextFieldType.INPUT)
         {
            switch(param1.getTextFormat().align)
            {
               case TextFormatAlign.LEFT:
                  param1.autoSize = TextFieldAutoSize.LEFT;
                  break;
               case TextFormatAlign.RIGHT:
                  param1.autoSize = TextFieldAutoSize.RIGHT;
                  break;
               case TextFormatAlign.CENTER:
                  param1.autoSize = TextFieldAutoSize.CENTER;
            }
         }
      }
      
      public static function translateDisplayObject(param1:DisplayObject, param2:Boolean = false, param3:Boolean = false, param4:Boolean = true) : void
      {
         var _loc6_:Object = null;
         var _loc7_:TextField = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc5_:Array = new Array();
         if(param2 == true)
         {
            _loc5_ = ComponentUtilities.findInstancesByClass(param1,TextField);
         }
         else
         {
            _loc5_.push(param1);
         }
         for each(_loc6_ in _loc5_)
         {
            if(_loc6_ is TextField)
            {
               _loc7_ = _loc6_ as TextField;
               if(param4)
               {
                  fontManager.setupTextField(_loc7_);
               }
               if(!translateByName(_loc7_,param3))
               {
                  if(param3)
                  {
                     _loc8_ = _loc7_.htmlText;
                     _loc9_ = translate(_loc8_);
                     _loc7_.htmlText = _loc9_;
                     checkAlign(_loc7_,_loc8_,param3);
                  }
                  else
                  {
                     _loc8_ = _loc7_.text;
                     _loc10_ = translate(_loc8_);
                     _loc7_.text = _loc10_;
                     checkAlign(_loc7_,_loc8_,param3);
                  }
               }
            }
         }
      }
   }
}

