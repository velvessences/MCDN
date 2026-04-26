package com.moviestarplanet.utils
{
   import flash.text.Font;
   
   public class FontGroup
   {
      
      private var _fontName:String;
      
      private var _aliasFontNames:Vector.<String>;
      
      private var _regularClass:Class;
      
      private var _boldClass:Class;
      
      private var _italicClass:Class;
      
      private var _boldItalicClass:Class;
      
      private var _regularClassName:String;
      
      private var _boldClassName:String;
      
      private var _italicClassName:String;
      
      private var _boldItalicClassName:String;
      
      public function FontGroup(param1:String, param2:Vector.<String>, param3:Class = null, param4:Class = null, param5:Class = null, param6:Class = null)
      {
         super();
         this._fontName = param1;
         this._aliasFontNames = param2;
         this._regularClass = param3;
         this._boldClass = param4;
         this._italicClass = param5;
         this._boldItalicClass = param6;
         this._regularClassName = this.getFontNamePrivate(false,false);
         this._boldClassName = this.getFontNamePrivate(true,false);
         this._italicClassName = this.getFontNamePrivate(false,true);
         this._boldItalicClassName = this.getFontNamePrivate(true,true);
      }
      
      public function getFontClass(param1:Boolean, param2:Boolean) : Class
      {
         if(param1)
         {
            if(param2)
            {
               return this._boldItalicClass;
            }
            return this._boldClass;
         }
         if(param2)
         {
            return this._italicClass;
         }
         return this._regularClass;
      }
      
      public function getFontName(param1:Boolean, param2:Boolean) : String
      {
         var _loc3_:String = null;
         if(param1)
         {
            if(param2)
            {
               _loc3_ = this._boldItalicClassName;
            }
            else
            {
               _loc3_ = this._boldClassName;
            }
         }
         else if(param2)
         {
            _loc3_ = this._italicClassName;
         }
         else
         {
            _loc3_ = this._regularClassName;
         }
         return _loc3_;
      }
      
      private function getFontNamePrivate(param1:Boolean, param2:Boolean) : String
      {
         var _loc3_:Class = this.getFontClass(param1,param2);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:Font = new _loc3_();
         return _loc4_.fontName;
      }
      
      private function nameFromClass(param1:Class) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Font = new param1();
         return _loc2_.fontName;
      }
      
      public function get fontName() : String
      {
         return this._fontName;
      }
      
      public function get aliasFontNames() : Vector.<String>
      {
         return this._aliasFontNames;
      }
   }
}

