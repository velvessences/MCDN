package com.moviestarplanet.utils
{
   import com.moviestarplanet.math.NumberUtils;
   import com.moviestarplanet.utils.color.IColorReader;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public class ColorMap implements IColorReader
   {
      
      private static var _instance:ColorMap;
      
      public function ColorMap()
      {
         super();
      }
      
      public static function getInstance() : ColorMap
      {
         if(_instance == null)
         {
            _instance = new ColorMap();
         }
         return _instance;
      }
      
      public static function CreateColorMapFromString(param1:MovieClip, param2:String) : void
      {
         param1.colorMap = GetColorMapFromString(param1,param2);
      }
      
      public static function GetColorMapFromString(param1:MovieClip, param2:String) : Array
      {
         return CreateColorMap(param1,parseColorSchemeString(param2));
      }
      
      public static function CreateColorMapOnMovieClip(param1:MovieClip, param2:Object = null, param3:Boolean = true) : void
      {
         param1.colorMap = CreateColorMap(param1,param2,param3);
      }
      
      public static function SetColorsOnMovieClip(param1:MovieClip, param2:int, param3:String = null, param4:Boolean = false) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Array = param1.colorMap as Array;
         if(_loc5_ == null)
         {
            _loc5_ = ColorMap.CreateColorMap(param1);
            param1.colorMap = _loc5_;
         }
         if(param4)
         {
            param3 = GetRandomColorString(_loc5_.length);
         }
         SetColorsOnColorMap(param3,_loc5_);
         ColorMap.ApplyColorMap(_loc5_,param2);
      }
      
      public static function parseColorSchemeString(param1:String) : Object
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Object = null;
         var _loc2_:Object = {};
         var _loc3_:Array = param1.split(";");
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = _loc4_.split("=");
            if(_loc5_.length == 2)
            {
               _loc2_[_loc5_[0]] = parseColorCodeString(_loc5_[1]);
            }
         }
         if(Boolean(_loc2_.defaultcolor) && _loc2_.defaultcolor.length > 0)
         {
            _loc2_.defaultcolor = _loc2_.defaultcolor[0];
         }
         if(Boolean(_loc2_.nocolor) && _loc2_.nocolor.length > 0)
         {
            _loc6_ = [];
            for each(_loc7_ in _loc2_.nocolor)
            {
               _loc6_.push(_loc7_.instances[0]);
            }
            _loc2_.nocolor = _loc6_;
         }
         return _loc2_;
      }
      
      private static function parseColorCodeString(param1:String) : Array
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc2_:Array = [];
         var _loc3_:Array = param1.split(":");
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = _loc4_.split(",");
            if(_loc5_.length >= 1)
            {
               _loc6_ = {"instances":[_loc5_[0]]};
               if(_loc5_[1])
               {
                  _loc6_.color = _loc5_[1];
               }
               if(_loc5_[2])
               {
                  _loc6_.label = _loc5_[2];
               }
               _loc2_.push(_loc6_);
            }
         }
         return _loc2_;
      }
      
      private static function GetRandomColorString(param1:int) : String
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1 <= 0)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc4_ = NumberUtils.random(51,255) << 16;
            _loc5_ = NumberUtils.random(51,255) << 8;
            _loc6_ = NumberUtils.random(51,255);
            _loc7_ = _loc4_ + _loc5_ + _loc6_;
            _loc2_.push(_loc7_.toString());
            _loc3_++;
         }
         return _loc2_.join(",");
      }
      
      public static function GetColorsOnMovieClip(param1:MovieClip) : String
      {
         if(param1.hasOwnProperty("colorMap") == false)
         {
            return null;
         }
         var _loc2_:Array = param1.colorMap as Array;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:Array = GetColorsFromColorMap(_loc2_);
         return _loc3_.join(",");
      }
      
      public static function GetColorsFromColorSchemeString(param1:String) : Array
      {
         var _loc4_:Object = null;
         var _loc2_:Object = parseColorSchemeString(param1);
         var _loc3_:Array = new Array();
         if(_loc2_.defaultcolor)
         {
            _loc3_.push(_loc2_.defaultcolor.color);
         }
         if(_loc2_.colors)
         {
            for each(_loc4_ in _loc2_.colors)
            {
               if(_loc4_.color)
               {
                  _loc3_.push(_loc4_.color);
               }
            }
         }
         return _loc3_;
      }
      
      public static function GetColorsFromColorMap(param1:Array) : Array
      {
         var _loc2_:Array = new Array(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_] = param1[_loc3_].color;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function SetColorsOnColorMap(param1:String, param2:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 != null)
         {
            _loc3_ = param1.split(",");
            _loc4_ = int(Math.min(_loc3_.length,param2.length));
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(param2[_loc5_].color != "skincolor")
               {
                  param2[_loc5_].color = _loc3_[_loc5_];
               }
               _loc5_++;
            }
         }
      }
      
      public static function createMobileColorScheme(param1:Array) : Object
      {
         var _loc4_:String = null;
         var _loc2_:Object = {};
         _loc2_.defaultcolor = {
            "color":param1.shift(),
            "label":"color"
         };
         _loc2_.colors = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = "color" + (_loc3_ + 2);
            _loc2_.colors.push({
               "color":param1[_loc3_],
               "instances":[_loc4_],
               "label":_loc4_
            });
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function createMobileColorMapStr(param1:Array) : String
      {
         var _loc5_:int = 0;
         var _loc2_:Object = createMobileColorScheme(param1);
         var _loc3_:String = "defaultcolor=defaultcolor," + _loc2_.defaultcolor.color + ",label;";
         if(_loc2_.colors.length > 0)
         {
            _loc3_ += "colors=";
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.colors.length)
         {
            _loc5_ = _loc4_ + 2;
            _loc3_ += _loc2_.colors[_loc4_].label + "," + _loc2_.colors[_loc4_].color + ",label";
            if(_loc4_ != _loc2_.colors.length - 1)
            {
               _loc3_ += ":";
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function ApplyColorMap(param1:Array, param2:uint) : void
      {
         var _loc3_:Object = null;
         if(param1 != null)
         {
            for each(_loc3_ in param1)
            {
               ApplyColorMapObject(_loc3_,param2);
            }
         }
      }
      
      public static function ApplyColorAtIndex(param1:String, param2:MovieClip, param3:int, param4:String) : void
      {
         var _loc6_:Object = null;
         var _loc7_:uint = 0;
         var _loc5_:Array = param2.colorMap as Array;
         if(_loc5_ == null)
         {
            _loc5_ = ColorMap.CreateColorMap(param2);
            param2.colorMap = _loc5_;
         }
         if(param3 < _loc5_.length)
         {
            _loc6_ = _loc5_[param3];
            if(_loc6_.color != "skincolor")
            {
               _loc6_.color = param1;
            }
            _loc7_ = uint(parseInt(param4));
            ApplyColorMapObject(_loc6_,_loc7_);
         }
      }
      
      public static function ApplyColorMapObject(param1:Object, param2:uint) : void
      {
         var _loc3_:String = param1["color"];
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return;
         }
         var _loc4_:uint = ParseColorString(_loc3_,param2);
         var _loc5_:Array = param1["instances"] as Array;
         ApplyColorToInstances(_loc4_,_loc5_);
      }
      
      public static function ApplyColorToInstances(param1:uint, param2:Array) : void
      {
         var _loc3_:DisplayObject = null;
         if(param2 != null)
         {
            for each(_loc3_ in param2)
            {
               FlashUtils.ApplyColorMultipliers(_loc3_,param1);
            }
         }
      }
      
      public static function ParseColorString(param1:String, param2:uint = 16777215) : uint
      {
         if(param1 == "skincolor")
         {
            return param2;
         }
         var _loc3_:uint = uint(parseInt(param1));
         if(isNaN(_loc3_))
         {
            throw new Error("Invalid colorstring: " + param1);
         }
         return _loc3_;
      }
      
      public static function GetContentColorMap(param1:DisplayObject) : Array
      {
         var _loc2_:MovieClip = param1 as MovieClip;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.colorMap as Array;
      }
      
      public static function CreateColorMap(param1:MovieClip, param2:Object = null, param3:Boolean = true) : Array
      {
         var _loc4_:Object = null;
         if(param2 != null)
         {
            _loc4_ = param2;
         }
         else if(param3)
         {
            _loc4_ = param1.colorscheme;
         }
         if(_loc4_ == null)
         {
            _loc4_ = {"defaultcolor":{
               "label":"Color:",
               "color":"0xffffff"
            }};
         }
         return CreateColorMapFromColorScheme(param1,_loc4_);
      }
      
      private static function CreateColorMapFromColorScheme(param1:MovieClip, param2:Object) : Array
      {
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:Object = null;
         var _loc15_:MovieClip = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:Object = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc21_:Object = null;
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         var _loc5_:Array = param2["colors"] as Array;
         if(_loc5_ == null)
         {
            _loc5_ = [];
         }
         var _loc6_:Array = param2["nocolor"] as Array;
         if(_loc6_ == null)
         {
            _loc6_ = [];
         }
         _loc4_ = new Array(_loc5_.length);
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc4_[_loc7_] = [];
            _loc7_++;
         }
         var _loc8_:Boolean = FindInstances(param1,param2,_loc3_,_loc4_);
         var _loc9_:Array = new Array();
         var _loc10_:Object = param2["defaultcolor"];
         if(_loc10_ != null)
         {
            _loc12_ = _loc10_["label"] as String;
            if(_loc12_ == null || _loc12_.length == 0)
            {
               throw new Error("Undefined label in the defaultcolor");
            }
            _loc13_ = _loc10_["color"] as String;
            if(_loc13_ == null || _loc13_.length == 0)
            {
               throw new Error("Undefined color in the defaultcolor");
            }
            _loc14_ = {
               "label":_loc12_,
               "color":_loc13_
            };
            if(_loc3_.length == 0)
            {
               _loc15_ = param1;
               _loc16_ = 0;
               while(_loc16_ < _loc15_.numChildren)
               {
                  _loc3_.push(_loc15_.getChildAt(_loc16_));
                  _loc16_++;
               }
            }
            _loc14_["instances"] = _loc3_;
            _loc9_.push(_loc14_);
         }
         var _loc11_:Array = param2["colors"] as Array;
         if(_loc11_ != null)
         {
            _loc17_ = 0;
            for each(_loc18_ in _loc11_)
            {
               _loc19_ = _loc18_["label"] as String;
               _loc20_ = _loc18_["color"] as String;
               if(_loc20_ == null || _loc20_.length == 0)
               {
                  throw new Error("Undefined color in color scheme, colors index = " + _loc17_.toString());
               }
               _loc21_ = {
                  "label":_loc19_,
                  "color":_loc20_,
                  "instances":_loc4_[_loc17_]
               };
               _loc9_.push(_loc21_);
               _loc17_++;
            }
         }
         return _loc9_;
      }
      
      public static function FindInstances(param1:DisplayObject, param2:Object, param3:Array, param4:Array, param5:int = 0) : Boolean
      {
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:DisplayObject = null;
         var _loc13_:Boolean = false;
         var _loc14_:Object = null;
         var _loc15_:int = 0;
         var _loc16_:Array = null;
         var _loc17_:Object = null;
         var _loc18_:Array = null;
         var _loc19_:Boolean = false;
         var _loc20_:Array = null;
         var _loc21_:Array = null;
         var _loc22_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:DisplayObjectContainer = param1 as DisplayObjectContainer;
         if(_loc7_ != null)
         {
            _loc9_ = new Array();
            _loc10_ = int(_loc7_.numChildren);
            _loc11_ = 0;
            while(_loc11_ < _loc10_)
            {
               _loc12_ = _loc7_.getChildAt(_loc11_);
               if(_loc12_)
               {
                  _loc13_ = FindInstances(_loc12_,param2,param3,param4,param5 + 1);
                  if(_loc13_ == false)
                  {
                     _loc9_.push(_loc12_);
                  }
               }
               _loc11_++;
            }
            if(_loc9_.length != _loc10_)
            {
               _loc6_ = true;
               for each(_loc14_ in _loc9_)
               {
                  param3.push(_loc14_);
               }
            }
         }
         var _loc8_:String = param1.name;
         if(IsValidUserDefinedInstanceName(_loc8_))
         {
            _loc15_ = 0;
            _loc16_ = param2["colors"] as Array;
            for each(_loc17_ in _loc16_)
            {
               _loc18_ = _loc17_["instances"];
               if(_loc18_ != null && _loc18_.length > 0)
               {
                  _loc19_ = _loc18_.indexOf(_loc8_) != -1;
                  if(_loc19_)
                  {
                     _loc20_ = param4[_loc15_] as Array;
                     _loc20_.push(param1);
                     _loc6_ = true;
                     break;
                  }
               }
               _loc15_++;
            }
            if(_loc6_ == false)
            {
               if(_loc8_ == "nocolor" || _loc8_.toUpperCase() == "S" || _loc8_.toUpperCase() == "H")
               {
                  _loc6_ = true;
               }
               else
               {
                  _loc21_ = param2["nocolor"] as Array;
                  if(_loc21_ != null)
                  {
                     _loc22_ = _loc21_.indexOf(_loc8_) != -1;
                     if(_loc22_)
                     {
                        _loc6_ = true;
                     }
                  }
               }
            }
         }
         if(!_loc6_ && param5 == 0)
         {
            param3.push(param1);
         }
         return _loc6_;
      }
      
      private static function IsValidUserDefinedInstanceName(param1:String) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.length == 0)
         {
            return false;
         }
         if(param1.length <= 7)
         {
            return true;
         }
         if(param1.substr(0,8) == "instance")
         {
            return false;
         }
         return true;
      }
      
      public static function setColorsOnColorScheme(param1:Object, param2:Array) : void
      {
         var _loc3_:int = 0;
         if(Boolean(param2) && param2.length > 0)
         {
            param1["defaultcolor"] = {
               "color":param2[0],
               "label":"Color"
            };
            _loc3_ = 1;
            while(_loc3_ < param2.length)
            {
               if(param1.color != null)
               {
                  param1.colors[_loc3_ - 1].color = param2[_loc3_];
               }
               _loc3_++;
            }
         }
      }
      
      public function applyColorScheme(param1:MovieClip, param2:String, param3:String) : void
      {
         if(param2 != null && param2.length > 0)
         {
            ColorMap.CreateColorMapFromString(param1,param2);
            ColorMap.SetColorsOnMovieClip(param1,0,param3,false);
         }
         else if(Boolean(param1.hasOwnProperty("colorscheme")) && param1.colorscheme != null)
         {
            ColorMap.SetColorsOnMovieClip(param1,0,param3,false);
         }
      }
      
      public function extractColorScheme(param1:MovieClip, param2:String) : Object
      {
         if(param2 != null)
         {
            return parseColorSchemeString(param2);
         }
         if(Boolean(param1.hasOwnProperty("colorscheme")) && param1.colorscheme != null)
         {
            return param1.colorscheme;
         }
         return {"defaultcolor":{
            "label":"Color:",
            "color":"0xffffff"
         }};
      }
   }
}

