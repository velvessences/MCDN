package com.moviestarplanet.gamescaleutils
{
   import com.moviestarplanet.utils.StageReference;
   import flash.system.Capabilities;
   
   public class ScreenSize
   {
      
      private static var instance:ScreenSize;
      
      private var is3_2:Boolean;
      
      private var is4_3:Boolean;
      
      private var is5_3:Boolean;
      
      private var is16_10:Boolean;
      
      private var is16_9:Boolean;
      
      private var isWide:Boolean;
      
      private var _isAtLeastSmall:Boolean;
      
      private var _isAtLeastNormal:Boolean;
      
      private var _isAtLeastLarge:Boolean;
      
      private var _isXLarge:Boolean;
      
      private var _diagonalMm:int;
      
      private const aspect_3_2:Number = 1.5;
      
      private const aspect_4_3:Number = 1.3333333333333333;
      
      private const aspect_5_3:Number = 1.6666666666666667;
      
      private const aspect_16_10:Number = 1.6;
      
      private const aspect_16_9:Number = 1.7777777777777777;
      
      private var ratioValues:Array = [this.aspect_3_2,this.aspect_4_3,this.aspect_5_3,this.aspect_16_10,this.aspect_16_9];
      
      private const INCHES_PER_MM:Number = 0.03937;
      
      public function ScreenSize(param1:ScreenSizeSingleton)
      {
         super();
         if(!param1)
         {
            throw new Error("ScreenSize must be singleton");
         }
         this.initialize();
      }
      
      public static function get fullScreenWidth() : Number
      {
         return StageReference.getStage().fullScreenWidth;
      }
      
      public static function get fullScreenHeight() : Number
      {
         return StageReference.getStage().fullScreenHeight;
      }
      
      public static function get isAspect4x3() : Boolean
      {
         return getInstance().is4_3;
      }
      
      public static function get isAspect5x3() : Boolean
      {
         return getInstance().is5_3;
      }
      
      public static function get isAspect3x2() : Boolean
      {
         return getInstance().is3_2;
      }
      
      public static function get isAspect16x9() : Boolean
      {
         return getInstance().is16_9;
      }
      
      public static function get isAspect16x10() : Boolean
      {
         return getInstance().is16_10;
      }
      
      public static function get isAspectWide() : Boolean
      {
         return getInstance().isWide;
      }
      
      public static function get isAtLeastSmall() : Boolean
      {
         return getInstance()._isAtLeastSmall;
      }
      
      public static function get isAtLeastNormal() : Boolean
      {
         return getInstance()._isAtLeastNormal;
      }
      
      public static function get isAtLeastLarge() : Boolean
      {
         return getInstance()._isAtLeastLarge;
      }
      
      public static function get isSmall() : Boolean
      {
         return getInstance()._isAtLeastSmall && !getInstance()._isAtLeastNormal;
      }
      
      public static function get isNormal() : Boolean
      {
         return getInstance()._isAtLeastNormal && !getInstance()._isAtLeastLarge;
      }
      
      public static function get isLarge() : Boolean
      {
         return getInstance()._isAtLeastLarge && !getInstance()._isXLarge;
      }
      
      public static function get isPhone() : Boolean
      {
         return isTablet == false;
      }
      
      public static function get isTablet() : Boolean
      {
         return getInstance()._isAtLeastLarge;
      }
      
      public static function get isXLarge() : Boolean
      {
         return getInstance()._isXLarge;
      }
      
      internal static function get diagonalMm() : int
      {
         return getInstance()._diagonalMm;
      }
      
      public static function getInstance() : ScreenSize
      {
         if(instance == null)
         {
            instance = new ScreenSize(new ScreenSizeSingleton());
         }
         return instance;
      }
      
      public function initialize() : void
      {
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Number = NaN;
         this.resetValues();
         var _loc1_:Number = Number(Capabilities.screenDPI);
         var _loc2_:Number = fullScreenWidth / _loc1_;
         var _loc3_:Number = fullScreenHeight / _loc1_;
         var _loc4_:Number = _loc2_ * 160;
         var _loc5_:Number = _loc3_ * 160;
         var _loc6_:Number = Number(Math.min(_loc4_,_loc5_));
         var _loc7_:Number = Number(Math.max(_loc4_,_loc5_));
         var _loc8_:Number = Number(Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_));
         this._isAtLeastSmall = _loc6_ >= 310 && _loc7_ >= 426;
         this._isAtLeastNormal = _loc6_ >= 310 && _loc7_ >= 470;
         this._isAtLeastLarge = _loc6_ >= 480 && _loc7_ >= 640;
         this._isXLarge = _loc6_ >= 720 && _loc7_ >= 960;
         this._diagonalMm = int(_loc8_ / this.INCHES_PER_MM);
         var _loc9_:Number = Math.ceil(_loc7_ / _loc6_ * 1000) / 1000;
         if(this.isAspect(_loc9_,3,2))
         {
            this.is3_2 = true;
         }
         else if(this.isAspect(_loc9_,4,3))
         {
            this.is4_3 = true;
         }
         else if(this.isAspect(_loc9_,5,3))
         {
            this.is5_3 = true;
         }
         else if(this.isAspect(_loc9_,16,10))
         {
            this.is16_10 = true;
         }
         else if(this.isAspect(_loc9_,16,9))
         {
            this.is16_9 = true;
         }
         else
         {
            _loc10_ = 10000;
            _loc11_ = -1;
            _loc12_ = 0;
            while(_loc12_ < this.ratioValues.length)
            {
               _loc13_ = Number(Math.abs(this.ratioValues[_loc12_] - _loc9_));
               if(_loc13_ < _loc10_)
               {
                  _loc11_ = _loc12_;
                  _loc10_ = _loc13_;
               }
               _loc12_++;
            }
            if(_loc11_ == 0)
            {
               this.is3_2 = true;
            }
            else if(_loc11_ == 1)
            {
               this.is4_3 = true;
            }
            else if(_loc11_ == 2)
            {
               this.is5_3 = true;
            }
            else if(_loc11_ == 3)
            {
               this.is16_10 = true;
            }
            else if(_loc11_ == 4)
            {
               this.is16_9 = true;
            }
         }
         this.isWide = this.is16_9 || this.is16_10 || this.is5_3;
      }
      
      private function resetValues() : void
      {
         this.is3_2 = false;
         this.is4_3 = false;
         this.is5_3 = false;
         this.is16_10 = false;
         this.is16_9 = false;
         this.isWide = false;
         this._isAtLeastSmall = false;
         this._isAtLeastNormal = false;
         this._isAtLeastLarge = false;
         this._isXLarge = false;
         this._diagonalMm = 0;
      }
      
      private function isAspect(param1:Number, param2:int, param3:int) : Boolean
      {
         var _loc4_:Number = Number(param2) / Number(param3);
         return param1 == _loc4_;
      }
   }
}

class ScreenSizeSingleton
{
   
   public function ScreenSizeSingleton()
   {
      super();
   }
}
