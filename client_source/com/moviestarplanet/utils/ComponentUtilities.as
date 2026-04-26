package com.moviestarplanet.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   import mx.core.Container;
   import mx.core.UIComponent;
   
   public class ComponentUtilities
   {
      
      public function ComponentUtilities()
      {
         super();
         throw new Error("Dont instantiate instance of static class " + getQualifiedClassName(this) + ".");
      }
      
      public static function flattenArray(param1:Array) : Array
      {
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(param1[_loc3_] is Array)
            {
               _loc5_ = flattenArray(param1[_loc3_] as Array);
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  _loc2_.push(_loc5_[_loc6_]);
                  _loc6_++;
               }
            }
            else
            {
               _loc2_.push(param1[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function applyToClasses(param1:Function, param2:UIComponent, ... rest) : void
      {
         var _loc5_:DisplayObject = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param2.numChildren)
         {
            _loc5_ = param2.getChildAt(_loc4_);
            _loc6_ = flattenArray(rest);
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               if(getQualifiedClassName(_loc5_) == getQualifiedClassName(_loc6_[_loc7_]))
               {
                  param1(_loc5_);
               }
               _loc7_++;
            }
            if(_loc5_ is Container)
            {
               applyToClasses(param1,Container(_loc5_),rest);
            }
            _loc4_++;
         }
      }
      
      public static function findInstancesByClass(param1:DisplayObject, param2:Class) : Array
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:int = 0;
         var _loc6_:DisplayObject = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc3_:Array = new Array();
         if(param1 is param2)
         {
            _loc3_.push(param1);
         }
         if(param1 is DisplayObjectContainer)
         {
            _loc4_ = param1 as DisplayObjectContainer;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.numChildren)
            {
               _loc6_ = _loc4_.getChildAt(_loc5_);
               _loc7_ = findInstancesByClass(_loc6_,param2);
               _loc8_ = 0;
               while(_loc8_ < _loc7_.length)
               {
                  _loc3_.push(_loc7_[_loc8_]);
                  _loc8_++;
               }
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public static function findDirectChildInstances(param1:DisplayObjectContainer, param2:Class, param3:Boolean = false) : Array
      {
         var _loc5_:DisplayObject = null;
         var _loc4_:Array = [];
         var _loc6_:int = 0;
         while(_loc6_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc6_);
            if(_loc5_ is param2)
            {
               _loc4_.push(_loc5_);
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public static function printInstances(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:int = 0;
         trace(param1.name);
         if(param1 is DisplayObjectContainer)
         {
            _loc2_ = param1 as DisplayObjectContainer;
            _loc3_ = 0;
            while(_loc3_ < _loc2_.numChildren)
            {
               printInstances(_loc2_.getChildAt(_loc3_));
               _loc3_++;
            }
         }
      }
      
      public static function findInstance(param1:DisplayObject, param2:String) : DisplayObject
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:int = 0;
         if(param1 != null && param1.name == param2)
         {
            _loc3_ = param1;
         }
         else if(param1 is DisplayObjectContainer)
         {
            _loc4_ = DisplayObjectContainer(param1);
            _loc5_ = 0;
            while(_loc5_ < _loc4_.numChildren)
            {
               _loc3_ = findInstanceBFS(param2,_loc4_.getChildAt(_loc5_));
               if(_loc3_ != null)
               {
                  break;
               }
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public static function findInstanceBFS(param1:String, param2:DisplayObject, param3:int = -1) : DisplayObject
      {
         return scanBFSNR(param1,[new WrapperBFS(param2,0)],param3);
      }
      
      private static function scanBFS(param1:String, param2:Array, param3:int = -1) : DisplayObject
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:int = 0;
         var _loc4_:WrapperBFS = param2.shift();
         if(_loc4_ == null)
         {
            return null;
         }
         if(_loc4_.displayObject.name == param1)
         {
            return _loc4_.displayObject;
         }
         if(param3 < 0 || _loc4_.level < param3)
         {
            if(_loc4_.displayObject is DisplayObjectContainer)
            {
               _loc5_ = _loc4_.displayObject as DisplayObjectContainer;
               _loc6_ = 0;
               while(_loc6_ < _loc5_.numChildren)
               {
                  param2.push(new WrapperBFS(_loc5_.getChildAt(_loc6_),_loc4_.level + 1));
                  _loc6_++;
               }
            }
         }
         return scanBFS(param1,param2,param3);
      }
      
      private static function scanBFSNR(param1:String, param2:Array, param3:int = -1) : DisplayObject
      {
         var _loc4_:WrapperBFS = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:int = 0;
         while(true)
         {
            _loc4_ = param2.shift();
            if(_loc4_ == null)
            {
               break;
            }
            if(_loc4_.displayObject.name == param1)
            {
               return _loc4_.displayObject;
            }
            if(param3 < 0 || _loc4_.level < param3)
            {
               if(_loc4_.displayObject is DisplayObjectContainer)
               {
                  _loc5_ = _loc4_.displayObject as DisplayObjectContainer;
                  _loc6_ = 0;
                  while(_loc6_ < _loc5_.numChildren)
                  {
                     param2.push(new WrapperBFS(_loc5_.getChildAt(_loc6_),_loc4_.level + 1));
                     _loc6_++;
                  }
               }
            }
            if(param2.length <= 0)
            {
               return null;
            }
         }
         return null;
      }
      
      public static function invokePropertyOnClasses(param1:Object, param2:Class, param3:String, ... rest) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Function = null;
         var _loc7_:DisplayObjectContainer = null;
         var _loc8_:int = 0;
         var _loc9_:DisplayObject = null;
         if(param1 != null && param1.hasOwnProperty(param3) == true)
         {
            _loc5_ = param1[param3];
            if(_loc5_ is Function)
            {
               _loc6_ = _loc5_ as Function;
               _loc6_.apply(null,ComponentUtilities.flattenArray(rest));
            }
         }
         if(param1 is DisplayObjectContainer)
         {
            _loc7_ = DisplayObjectContainer(param1);
            _loc8_ = 0;
            while(_loc8_ < _loc7_.numChildren)
            {
               _loc9_ = _loc7_.getChildAt(_loc8_);
               if(_loc9_ is param2)
               {
                  invokePropertyOnClasses(_loc9_,param2,param3,rest);
               }
               _loc8_++;
            }
         }
      }
      
      public static function getVisibleBounds(param1:DisplayObject) : Rectangle
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Rectangle = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc2_:Array = new Array();
         if(param1 is DisplayObjectContainer)
         {
            _loc3_ = param1 as DisplayObjectContainer;
            _loc4_ = Number(Number.POSITIVE_INFINITY);
            _loc5_ = Number(Number.POSITIVE_INFINITY);
            _loc6_ = Number(Number.NEGATIVE_INFINITY);
            _loc7_ = Number(Number.NEGATIVE_INFINITY);
            _loc8_ = 0;
            while(_loc8_ < _loc3_.numChildren)
            {
               _loc9_ = getVisibleBounds(_loc3_.getChildAt(_loc8_));
               if(_loc9_ != null)
               {
                  if(_loc9_.x < _loc4_)
                  {
                     _loc4_ = Number(_loc9_.x);
                  }
                  if(_loc9_.y < _loc5_)
                  {
                     _loc5_ = Number(_loc9_.y);
                  }
                  if(_loc9_.x + _loc9_.width > _loc6_)
                  {
                     _loc6_ = _loc9_.x + _loc9_.width;
                  }
                  if(_loc9_.y + _loc9_.height > _loc7_)
                  {
                     _loc7_ = _loc9_.y + _loc9_.height;
                  }
               }
               _loc8_++;
            }
            return new Rectangle(_loc4_,_loc5_,_loc6_ - _loc4_,_loc7_ - _loc5_);
         }
         if(param1.visible == true && param1.alpha > 0)
         {
            _loc10_ = Number(Math.min(Math.max(0,param1.x),param1.loaderInfo.width));
            _loc11_ = Number(Math.min(Math.max(0,param1.y),param1.loaderInfo.height));
            _loc12_ = Number(Math.min(param1.width,param1.width + param1.x));
            _loc13_ = Number(Math.min(param1.height,param1.height + param1.y));
            return new Rectangle(_loc10_,_loc11_,_loc12_,_loc13_);
         }
         return null;
      }
      
      public static function invokePropertyOnClassesExceptions(param1:Object, param2:Class, param3:String, param4:Array, param5:Array) : void
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:Function = null;
         var _loc11_:DisplayObjectContainer = null;
         var _loc12_:int = 0;
         var _loc13_:DisplayObject = null;
         var _loc6_:Boolean = false;
         if(param1 is DisplayObject)
         {
            _loc7_ = (param1 as DisplayObject).name;
            for each(_loc8_ in param5)
            {
               if(_loc7_ == _loc8_)
               {
                  _loc6_ = true;
                  break;
               }
            }
         }
         if(_loc6_ == false)
         {
            if(param1 != null && param1.hasOwnProperty(param3) == true)
            {
               _loc9_ = param1[param3];
               if(_loc9_ is Function)
               {
                  _loc10_ = _loc9_ as Function;
                  _loc10_.apply(null,ComponentUtilities.flattenArray(param4));
               }
            }
            if(param1 is DisplayObjectContainer)
            {
               _loc11_ = DisplayObjectContainer(param1);
               _loc12_ = 0;
               while(_loc12_ < _loc11_.numChildren)
               {
                  _loc13_ = _loc11_.getChildAt(_loc12_);
                  if(_loc13_ is param2)
                  {
                     invokePropertyOnClassesExceptions(_loc13_,param2,param3,param4,param5);
                  }
                  _loc12_++;
               }
            }
         }
      }
      
      public static function getLanguageLabel(param1:MovieClip, param2:String) : String
      {
         var _loc3_:String = "en";
         var _loc4_:int = 0;
         while(_loc4_ < param1.currentLabels.length)
         {
            if(param2 == param1.currentLabels[_loc4_].name)
            {
               _loc3_ = param2;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}

