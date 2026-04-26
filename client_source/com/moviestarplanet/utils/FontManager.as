package com.moviestarplanet.utils
{
   import com.moviestarplanet.font.IFontManager;
   import fl.text.TLFTextField;
   import flash.display.DisplayObject;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.text.engine.FontLookup;
   import flashx.textLayout.formats.TextLayoutFormat;
   
   public class FontManager implements IFontManager
   {
      
      private static var _substFonts:Array;
      
      private static var _isInitialized:Boolean;
      
      private static var _isDebug:Boolean = false;
      
      public function FontManager()
      {
         super();
      }
      
      public static function initializeFonts() : void
      {
         _substFonts = [];
         _substFonts[MSPTextFieldType.REGULAR] = [];
         _substFonts[MSPTextFieldType.TLF] = [];
         setupFont(new FontGroup("Blue Highway",Vector.<String>(["B4ue Highwa4"]),BlueHighwa3,BlueHighwa3Bold),MSPTextFieldType.REGULAR);
         setupFont(new FontGroup("Arezzo-Rounded",null,ArezzoRounde3,null),MSPTextFieldType.REGULAR);
         setupFont(new FontGroup("Arezzo-Rounded-Bold",Vector.<String>(["Arezzo-Rounded-Bold-Regular"]),ArezzoRounde3Bold,ArezzoRounde3Bold),MSPTextFieldType.REGULAR);
         setupFont(new FontGroup("Arial",Vector.<String>(["Aria4","EmbedArial","Arial Bold"]),Aria3,Aria3Bold,Aria3Italic,Aria3BoldItalic),MSPTextFieldType.REGULAR);
         setupFont(new FontGroup("Arial",Vector.<String>(["Aria3"]),Aria4,Aria4Bold,Aria4Italic,Aria4BoldItalic),MSPTextFieldType.TLF);
         setupFont(new FontGroup("Arial Bold",null,Aria4Bold,Aria4Bold,Aria4BoldItalic,Aria4BoldItalic),MSPTextFieldType.TLF);
         setupFont(new FontGroup("Blue Highway",Vector.<String>(["Blue Highwa3"]),B4ueHighwa4,B4ueHighwa4Bold),MSPTextFieldType.TLF);
         setupFont(new FontGroup("Blue Highway Bold",null,B4ueHighwa4Bold,B4ueHighwa4Bold),MSPTextFieldType.REGULAR);
         setupFont(new FontGroup("BadaBoom Pro BB",Vector.<String>(["EmbedBADABB"]),BadaBoo3,null,BadaBoo3Italic,null),MSPTextFieldType.REGULAR);
         setupFont(new FontGroup("Foo",Vector.<String>(["Embed Foo"]),Fo3,null,null,null),MSPTextFieldType.REGULAR);
         setupFont(new FontGroup("Lobster 1.4",Vector.<String>(["Embed Lobster"]),Lobste31_4,null,null,null),MSPTextFieldType.REGULAR);
         setupFont(new FontGroup("Segoe Print",Vector.<String>(["Embed Segoe Print"]),Sego3Print,null,null,null),MSPTextFieldType.REGULAR);
         _isInitialized = true;
      }
      
      public static function remapFonts(param1:TextField) : Boolean
      {
         var _loc2_:TextFormat = null;
         if(param1)
         {
            if(Boolean(param1.text) && param1.text.length > 0)
            {
               _loc2_ = param1.getTextFormat(0,1);
            }
            else
            {
               _loc2_ = param1.defaultTextFormat;
            }
            if(param1.type != TextFieldType.INPUT)
            {
               if(fontSubstitutionExists(_loc2_.font,_loc2_.bold,_loc2_.italic,MSPTextFieldType.REGULAR))
               {
                  if(_isDebug)
                  {
                     _loc2_.color = 16711680;
                  }
                  _loc2_.font = getFontSubstitute(_loc2_.font,_loc2_.bold,_loc2_.italic,MSPTextFieldType.REGULAR);
                  param1.embedFonts = true;
                  param1.defaultTextFormat = _loc2_;
                  param1.setTextFormat(_loc2_);
                  return true;
               }
            }
            else if(inverseFontSubstitutionExists(_loc2_.font,MSPTextFieldType.REGULAR))
            {
               if(_isDebug)
               {
                  _loc2_.color = 16711680;
               }
               _loc2_.font = getInverseFontSubstitution(_loc2_.font,MSPTextFieldType.REGULAR);
               param1.embedFonts = false;
               param1.defaultTextFormat = _loc2_;
               param1.setTextFormat(_loc2_);
               return true;
            }
         }
         return false;
      }
      
      public static function remapTlfFonts(param1:TLFTextField) : Boolean
      {
         var _loc2_:TextFormat = null;
         var _loc3_:TextLayoutFormat = null;
         if(param1)
         {
            _loc2_ = param1.defaultTextFormat;
            if(fontSubstitutionExists(_loc2_.font,_loc2_.bold,_loc2_.italic,MSPTextFieldType.TLF))
            {
               _loc2_.font = getFontSubstitute(_loc2_.font,_loc2_.bold,_loc2_.italic,MSPTextFieldType.TLF);
               if(_isDebug)
               {
                  _loc2_.color = 16711680;
               }
               param1.embedFonts = true;
               param1.defaultTextFormat = _loc2_;
               _loc3_ = new TextLayoutFormat();
               _loc3_.fontFamily = _loc2_.font;
               param1.textFlow.hostFormat = _loc3_;
               param1.textFlow.fontLookup = FontLookup.EMBEDDED_CFF;
               param1.setTextFormat(_loc2_);
               return true;
            }
         }
         trace("FontManager::remapTlfFonts EEEEERRRROOOOORRR..... FONT MAPPING FAILED !!!!!!!!!");
         return false;
      }
      
      public static function canEmbed(param1:TextField, param2:String) : Boolean
      {
         var _loc3_:TextFormat = null;
         var _loc4_:FontGroup = null;
         var _loc5_:Class = null;
         var _loc6_:Font = null;
         if(param1.embedFonts == true)
         {
            _loc3_ = param1.defaultTextFormat;
            _loc4_ = getFontGroup(_loc3_.font,MSPTextFieldType.REGULAR);
            if(_loc4_)
            {
               _loc5_ = _loc4_.getFontClass(_loc3_.bold,_loc3_.italic);
               if(_loc5_)
               {
                  _loc6_ = new _loc5_();
                  if(_loc6_.hasGlyphs(param1.text))
                  {
                     return true;
                  }
               }
            }
            return false;
         }
         return true;
      }
      
      public static function remapAllFontsForDisplayObject(param1:DisplayObject) : int
      {
         var _loc3_:TextField = null;
         var _loc5_:Object = null;
         var _loc2_:Array = ComponentUtilities.findInstancesByClass(param1,TextField);
         var _loc4_:uint = 0;
         for each(_loc5_ in _loc2_)
         {
            if(_loc5_ is TextField)
            {
               if(remapFonts(_loc5_ as TextField))
               {
                  _loc4_++;
               }
            }
         }
         return _loc4_;
      }
      
      public static function resizeAllFontsForDisplayObjectRelatively(param1:DisplayObject, param2:int) : void
      {
         var _loc4_:Object = null;
         var _loc5_:TextField = null;
         var _loc6_:TextFormat = null;
         var _loc3_:Array = ComponentUtilities.findInstancesByClass(param1,TextField);
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_ is TextField)
            {
               _loc5_ = _loc4_ as TextField;
               _loc6_ = _loc5_.defaultTextFormat;
               _loc6_.size += param2;
               (_loc4_ as TextField).setTextFormat(_loc6_);
            }
         }
      }
      
      public static function set isDebug(param1:Boolean) : void
      {
         _isDebug = param1;
      }
      
      public static function get isDebug() : Boolean
      {
         return _isDebug;
      }
      
      private static function setupFont(param1:FontGroup, param2:uint) : void
      {
         var _loc3_:String = null;
         registerFontIfNotNull(param1.getFontClass(false,false));
         registerFontIfNotNull(param1.getFontClass(true,false));
         registerFontIfNotNull(param1.getFontClass(false,true));
         registerFontIfNotNull(param1.getFontClass(true,true));
         _substFonts[param2][param1.fontName] = param1;
         for each(_loc3_ in param1.aliasFontNames)
         {
            _substFonts[param2][_loc3_] = param1;
         }
      }
      
      private static function registerFontIfNotNull(param1:Class) : void
      {
         if(param1 != null)
         {
            Font.registerFont(param1);
         }
      }
      
      private static function getFontSubstitute(param1:String, param2:Boolean, param3:Boolean, param4:uint) : String
      {
         if(!_isInitialized)
         {
            initializeFonts();
         }
         var _loc5_:FontGroup = _substFonts[param4][param1];
         if((Boolean(_loc5_)) && Boolean(_loc5_.getFontName(param2,param3)))
         {
            return _loc5_.getFontName(param2,param3);
         }
         return param1;
      }
      
      private static function getInverseFontSubstitution(param1:String, param2:uint) : String
      {
         var _loc4_:FontGroup = null;
         var _loc5_:String = null;
         if(!_isInitialized)
         {
            initializeFonts();
         }
         var _loc3_:Array = _substFonts[param2];
         for(_loc5_ in _loc3_)
         {
            _loc4_ = _loc3_[_loc5_] as FontGroup;
            if(_loc4_.getFontName(false,false) == param1 || _loc4_.getFontName(false,true) == param1 || _loc4_.getFontName(true,false) == param1 || _loc4_.getFontName(true,true) == param1)
            {
               return _loc4_.fontName;
            }
         }
         return param1;
      }
      
      private static function fontSubstitutionExists(param1:String, param2:Boolean, param3:Boolean, param4:uint) : Boolean
      {
         var _loc5_:String = getFontSubstitute(param1,param2,param3,param4);
         return param1 != _loc5_;
      }
      
      private static function inverseFontSubstitutionExists(param1:String, param2:uint) : Boolean
      {
         var _loc3_:String = getInverseFontSubstitution(param1,param2);
         return param1 != _loc3_;
      }
      
      private static function getFontGroup(param1:String, param2:uint) : FontGroup
      {
         return _substFonts[param2][param1];
      }
      
      public function setupDisplayObject(param1:DisplayObject) : void
      {
         remapAllFontsForDisplayObject(param1);
      }
      
      public function setupTextField(param1:TextField) : void
      {
         remapFonts(param1);
      }
   }
}

