package com.moviestarplanet.Components
{
   import flash.display.Graphics;
   import flash.geom.Matrix;
   import mx.containers.Canvas;
   import mx.utils.ArrayUtil;
   
   public class GradientCanvas extends Canvas
   {
      
      public static const DEFAULT_GRADIENTTYPE:String = "linear";
      
      public static const DEFAULT_FILLCOLORS:String = "0xFFFFFF";
      
      public static const DEFAULT_COLORSCONFIGURATION:Number = 1;
      
      public static const DEFAULT_FILLALPHAS:Number = 1;
      
      public static const DEFAULT_GRADIENTRATIO:Number = 255;
      
      public static const DEFAULT_BORDERTHICKNESS:Number = 0;
      
      public static const DEFAULT_ANGLE:Number = 0;
      
      public static const DEFAULT_OFFSETX:Number = 0;
      
      public static const DEFAULT_OFFSETY:Number = 0;
      
      public static const DEFAULT_SPREADMETHOD:String = "pad";
      
      public static const DEFAULT_INTERPOLATIONMETHOD:String = "rgb";
      
      public static const DEFAULT_FOCALPOINTRATIO:Number = 0;
      
      public static const DEFAULT_CORNERRADIUS:Number = 0;
      
      public static const DEFAULT_TOPLEFTRADIUS:Number = 0;
      
      public static const DEFAULT_TOPRIGHTRADIUS:Number = 0;
      
      public static const DEFAULT_BOTTOMLEFTRADIUS:Number = 0;
      
      public static const DEFAULT_BOTTOMRIGHTRADIUS:Number = 0;
      
      private var _gradientType:String;
      
      private var _fillColors:Array;
      
      private var _fillAlphas:Array;
      
      private var _gradientRatio:Array;
      
      private var _angle:Array;
      
      private var _offsetx:Array;
      
      private var _offsety:Array;
      
      private var _spreadMethod:String;
      
      private var _interpolationMethod:String;
      
      private var _focalPointRatio:Array;
      
      private var _borderThickness:Number;
      
      private var _bgradientType:String;
      
      private var _bfillColors:Array;
      
      private var _bfillAlphas:Array;
      
      private var _bgradientRatio:Array;
      
      private var _bangle:Number;
      
      private var _boffsetx:Number;
      
      private var _boffsety:Number;
      
      private var _bspreadMethod:String;
      
      private var _binterpolationMethod:String;
      
      private var _bfocalPointRatio:Number;
      
      private var _topLeftRadius:Number;
      
      private var _topRightRadius:Number;
      
      private var _bottomLeftRadius:Number;
      
      private var _bottomRightRadius:Number;
      
      private var _colorsconfig:Array = new Array(1);
      
      private var _ngradients:Number = this._colorsconfig.length;
      
      private var bStylePropChanged:Boolean = true;
      
      public function GradientCanvas()
      {
         super();
      }
      
      public function get colorsConfiguration() : Array
      {
         return this._colorsconfig;
      }
      
      public function set colorsConfiguration(param1:Array) : void
      {
         this._colorsconfig = param1;
         invalidateDisplayList();
      }
      
      public function get numberGradients() : Number
      {
         return this._colorsconfig.length;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc3_:Graphics = null;
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Matrix = null;
         var _loc8_:Matrix = null;
         var _loc9_:Object = null;
         super.updateDisplayList(param1,param2);
         if(this.bStylePropChanged == true)
         {
            this.getAllStyles();
            _loc3_ = graphics;
            _loc3_.clear();
            _loc4_ = {
               "tl":this._topLeftRadius,
               "tr":this._topRightRadius,
               "bl":this._bottomLeftRadius,
               "br":this._bottomRightRadius
            };
            _loc6_ = int(this._colorsconfig.length);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = new Matrix();
               _loc7_.createGradientBox(param1,param2,Math.PI * this._angle[_loc5_] / 180,this._offsetx[_loc5_],this._offsety[_loc5_]);
               this.drawRect(0,0,param1,param2,_loc4_,this._fillColors[_loc5_],this._fillAlphas[_loc5_],_loc7_,this._gradientType.split(",")[_loc5_],this._gradientRatio[_loc5_],this._spreadMethod.split(",")[_loc5_],this._interpolationMethod.split(",")[_loc5_],this._focalPointRatio[_loc5_]);
               _loc5_++;
            }
            if(this._borderThickness > 0)
            {
               _loc8_ = new Matrix();
               _loc8_.createGradientBox(param1 + 2 * this._borderThickness,param2 + 2 * this._borderThickness,Math.PI * this._bangle / 180,this._boffsetx,this._boffsety);
               _loc9_ = new Object();
               _loc9_.x = 0;
               _loc9_.y = 0;
               _loc9_.w = param1;
               _loc9_.h = param2;
               this.drawRect(-this._borderThickness,-this._borderThickness,param1 + 2 * this._borderThickness,param2 + 2 * this._borderThickness,_loc4_,this._bfillColors,this._bfillAlphas,_loc8_,this._bgradientType,this._bgradientRatio,this._bspreadMethod,this._binterpolationMethod,this._bfocalPointRatio,_loc9_);
            }
         }
      }
      
      private function drawRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null, param6:Object = null, param7:Object = null, param8:Object = null, param9:String = null, param10:Array = null, param11:String = null, param12:String = null, param13:Number = 0, param14:Object = null) : void
      {
         if(!param3 || !param4)
         {
            return;
         }
         var _loc15_:Graphics = graphics;
         _loc15_.beginGradientFill(param9,param6 as Array,param7 as Array,param10,param8 as Matrix,param11,param12,param13);
         _loc15_.drawRoundRectComplex(param1,param2,param3,param4,param5.tl,param5.tr,param5.bl,param5.br);
         if(param14)
         {
            _loc15_.drawRoundRectComplex(param14.x,param14.y,param14.w,param14.h,param5.tl,param5.tr,param5.bl,param5.br);
         }
         _loc15_.endFill();
      }
      
      private function getAllStyles() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         if(getStyle("gradientType") != undefined)
         {
            this._gradientType = getStyle("gradientType");
         }
         else
         {
            this._gradientType = DEFAULT_GRADIENTTYPE;
         }
         if(getStyle("bordergradientType") != undefined)
         {
            this._bgradientType = getStyle("bordergradientType");
         }
         else
         {
            this._bgradientType = DEFAULT_GRADIENTTYPE;
         }
         if(getStyle("colorsConfiguration") != undefined)
         {
            this._colorsconfig = ArrayUtil.toArray(getStyle("colorsConfiguration"));
         }
         else
         {
            this._ngradients = this._colorsconfig.length;
         }
         if(getStyle("fillColors") != undefined)
         {
            this._fillColors = new Array();
            _loc1_ = new Array();
            _loc1_ = getStyle("fillColors").toString().split(",");
            _loc2_ = int(this._colorsconfig.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this._fillColors.push(_loc1_.slice(0,this._colorsconfig[_loc3_]));
               _loc1_ = _loc1_.slice(this._colorsconfig[_loc3_]);
               _loc3_++;
            }
         }
         else
         {
            this._fillColors = new Array(DEFAULT_FILLCOLORS);
         }
         if(getStyle("borderColors") != undefined)
         {
            this._bfillColors = getStyle("borderColors");
         }
         else
         {
            this._bfillColors = new Array(DEFAULT_FILLCOLORS);
         }
         if(getStyle("borderThickness") != undefined)
         {
            this._borderThickness = getStyle("borderThickness");
         }
         else
         {
            this._borderThickness = DEFAULT_BORDERTHICKNESS;
         }
         if(getStyle("fillAlphas") != undefined)
         {
            this._fillAlphas = new Array();
            _loc1_ = new Array();
            _loc1_ = getStyle("fillAlphas").toString().split(",");
            _loc4_ = int(this._colorsconfig.length);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this._fillAlphas.push(_loc1_.slice(0,this._colorsconfig[_loc3_]));
               _loc1_ = _loc1_.slice(this._colorsconfig[_loc3_]);
               _loc3_++;
            }
         }
         else
         {
            this._fillAlphas = new Array();
            _loc5_ = int(this._colorsconfig.length);
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc1_ = new Array();
               _loc6_ = 0;
               while(_loc6_ < this._colorsconfig[_loc3_])
               {
                  _loc1_.push(DEFAULT_FILLALPHAS);
                  _loc6_++;
               }
               this._fillAlphas.push(_loc1_);
               _loc3_++;
            }
         }
         if(getStyle("borderAlphas") != undefined)
         {
            this._bfillAlphas = getStyle("borderAlphas");
         }
         else
         {
            this._bfillAlphas = new Array();
            _loc7_ = int(this._bfillColors.length);
            _loc3_ = 0;
            while(_loc3_ < _loc7_)
            {
               this._bfillAlphas.push(DEFAULT_FILLALPHAS);
               _loc3_++;
            }
         }
         if(getStyle("gradientRatio") != undefined)
         {
            this._gradientRatio = getStyle("gradientRatio");
            _loc1_ = new Array();
            _loc1_ = getStyle("gradientRatio").toString().split(",");
            _loc8_ = new Array();
            _loc9_ = int(this._colorsconfig.length);
            _loc3_ = 0;
            while(_loc3_ < _loc9_)
            {
               _loc8_.push(_loc1_.slice(0,this._colorsconfig[_loc3_]));
               _loc1_ = _loc1_.slice(this._colorsconfig[_loc3_]);
               _loc3_++;
            }
            this._gradientRatio = _loc8_;
         }
         else
         {
            this._gradientRatio = new Array();
            _loc10_ = int(this._colorsconfig.length);
            _loc3_ = 0;
            while(_loc3_ < _loc10_)
            {
               this._gradientRatio.push(this.generateDefaultRatio(this._colorsconfig[_loc3_]));
               _loc3_++;
            }
         }
         if(getStyle("bordergradientRatio") != undefined)
         {
            this._bgradientRatio = getStyle("bordergradientRatio");
         }
         else
         {
            this._bgradientRatio = new Array();
            _loc11_ = int(this._colorsconfig.length);
            _loc3_ = 0;
            while(_loc3_ < _loc11_)
            {
               this._bgradientRatio = this.generateDefaultRatio(this._bfillColors.length);
               _loc3_++;
            }
         }
         if(getStyle("angle") != undefined)
         {
            _loc1_ = new Array();
            _loc1_.push(getStyle("angle"));
            this._angle = _loc1_[0].toString().split(",");
         }
         else
         {
            this._angle = new Array();
            _loc12_ = int(this._colorsconfig.length);
            _loc3_ = 0;
            while(_loc3_ < _loc12_)
            {
               this._angle.push(DEFAULT_ANGLE);
               _loc3_++;
            }
         }
         if(getStyle("borderAngle") != undefined)
         {
            this._bangle = getStyle("borderAngle");
         }
         else
         {
            this._bangle = DEFAULT_ANGLE;
         }
         if(getStyle("spreadMethod") != undefined)
         {
            this._spreadMethod = getStyle("spreadMethod");
         }
         else
         {
            this._spreadMethod = DEFAULT_SPREADMETHOD;
         }
         if(getStyle("borderSpreadMethod") != undefined)
         {
            this._bspreadMethod = getStyle("borderSpreadMethod");
         }
         else
         {
            this._bspreadMethod = DEFAULT_SPREADMETHOD;
         }
         if(getStyle("interpolationMethod") != undefined)
         {
            this._interpolationMethod = getStyle("interpolationMethod");
         }
         else
         {
            this._interpolationMethod = DEFAULT_INTERPOLATIONMETHOD;
         }
         if(getStyle("borderInterpolationMethod") != undefined)
         {
            this._binterpolationMethod = getStyle("borderInterpolationMethod");
         }
         else
         {
            this._binterpolationMethod = DEFAULT_INTERPOLATIONMETHOD;
         }
         if(getStyle("focalPointRatio") != undefined)
         {
            this._focalPointRatio = new Array();
            _loc1_ = new Array();
            _loc1_.push(getStyle("focalPointRatio"));
            this._focalPointRatio = _loc1_[0].toString().split(",");
         }
         else
         {
            this._focalPointRatio = new Array();
            _loc13_ = int(this._colorsconfig.length);
            _loc3_ = 0;
            while(_loc3_ < _loc13_)
            {
               this._focalPointRatio.push(DEFAULT_FOCALPOINTRATIO);
               _loc3_++;
            }
         }
         if(getStyle("borderfocalPointRatio") != undefined)
         {
            this._bfocalPointRatio = getStyle("borderfocalPointRatio");
         }
         else
         {
            this._bfocalPointRatio = DEFAULT_FOCALPOINTRATIO;
         }
         if(getStyle("offsetX") != undefined)
         {
            _loc1_ = new Array();
            _loc1_.push(getStyle("offsetX"));
            this._offsetx = _loc1_[0].toString().split(",");
         }
         else
         {
            this._offsetx = new Array();
            _loc14_ = int(this._colorsconfig.length);
            _loc3_ = 0;
            while(_loc3_ < _loc14_)
            {
               this._offsetx.push(DEFAULT_OFFSETX);
               _loc3_++;
            }
         }
         if(getStyle("borderOffsetX") != undefined)
         {
            this._boffsetx = getStyle("borderOffsetX");
         }
         else
         {
            this._boffsetx = DEFAULT_OFFSETX;
         }
         if(getStyle("offsetY") != undefined)
         {
            _loc1_ = new Array();
            _loc1_.push(getStyle("offsetY"));
            this._offsety = _loc1_[0].toString().split(",");
         }
         else
         {
            this._offsety = new Array();
            _loc15_ = int(this._colorsconfig.length);
            _loc3_ = 0;
            while(_loc3_ < _loc15_)
            {
               this._offsety.push(DEFAULT_OFFSETY);
               _loc3_++;
            }
         }
         if(getStyle("borderOffsetY") != undefined)
         {
            this._boffsety = getStyle("borderOffsetY");
         }
         else
         {
            this._boffsety = DEFAULT_OFFSETY;
         }
         if(getStyle("topLeftRadius") != 0 && getStyle("topLeftRadius") != undefined || getStyle("topRightRadius") != 0 && getStyle("topRightRadius") != undefined || getStyle("bottomLeftRadius") != 0 && getStyle("bottomLeftRadius") != undefined || getStyle("bottomRightRadius") != 0 && getStyle("bottomRightRadius") != undefined)
         {
            if(getStyle("topLeftRadius") != undefined)
            {
               this._topLeftRadius = getStyle("topLeftRadius");
            }
            else
            {
               this._topLeftRadius = DEFAULT_TOPLEFTRADIUS;
            }
            if(getStyle("topRightRadius") != undefined)
            {
               this._topRightRadius = getStyle("topRightRadius");
            }
            else
            {
               this._topRightRadius = DEFAULT_TOPRIGHTRADIUS;
            }
            if(getStyle("bottomLeftRadius") != undefined)
            {
               this._bottomLeftRadius = getStyle("bottomLeftRadius");
            }
            else
            {
               this._bottomLeftRadius = DEFAULT_BOTTOMLEFTRADIUS;
            }
            if(getStyle("bottomRightRadius") != undefined)
            {
               this._bottomRightRadius = getStyle("bottomRightRadius");
            }
            else
            {
               this._bottomRightRadius = DEFAULT_BOTTOMRIGHTRADIUS;
            }
         }
         else
         {
            this._topLeftRadius = getStyle("cornerRadius");
            this._topRightRadius = getStyle("cornerRadius");
            this._bottomLeftRadius = getStyle("cornerRadius");
            this._bottomRightRadius = getStyle("cornerRadius");
         }
      }
      
      private function generateDefaultRatio(param1:Number) : Array
      {
         var _loc5_:Number = NaN;
         var _loc2_:Number = 255 / (param1 - 1);
         var _loc3_:Array = new Array();
         var _loc4_:Number = 0;
         while(_loc4_ < param1)
         {
            _loc5_ = 255 - _loc2_ * _loc4_;
            _loc3_.push(_loc5_);
            _loc3_.sort(Array.NUMERIC);
            _loc4_++;
         }
         return _loc3_;
      }
      
      override public function styleChanged(param1:String) : void
      {
         super.styleChanged(param1);
         if(param1 == "fillColors" || param1 == "fillAlphas" || param1 == "cornerRadius" || param1 == "angle" || param1 == "spreadMethod" || param1 == "gradientType" || param1 == "gradientRatio" || param1 == "offsetX" || param1 == "offsetY" || param1 == "interpolationMethod" || param1 == "topLeftRadius" || param1 == "topRightRadius" || param1 == "bottomLeftRadius" || param1 == "bottomRightRadius" || param1 == "focalPointRatio" || param1 == "gradientType" || param1 == "borderColors" || param1 == "borderAlphas" || param1 == "bordergradientRatio" || param1 == "borderThickness" || param1 == "borderOffsetX" || param1 == "borderOffsetY" || param1 == "borderfocalPointRatio" || param1 == "borderSpreadMethod" || param1 == "borderInterpolationMethod" || param1 == "borderAngle" || param1 == "colorsConfiguration")
         {
            this.bStylePropChanged = true;
            invalidateDisplayList();
            return;
         }
      }
   }
}

