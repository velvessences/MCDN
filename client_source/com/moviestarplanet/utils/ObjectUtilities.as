package com.moviestarplanet.utils
{
   import flash.display.DisplayObjectContainer;
   import flash.utils.getQualifiedClassName;
   
   public class ObjectUtilities
   {
      
      public function ObjectUtilities()
      {
         super();
         throw new Error("Do not instantiate " + getQualifiedClassName(this));
      }
      
      public static function traverseObject(param1:Object, param2:Function, param3:Function) : void
      {
         var _loc5_:Object = null;
         param3.apply(null,[param1]);
         var _loc4_:Array = param2.apply(null,[param1]);
         if(_loc4_ != null)
         {
            for each(_loc5_ in _loc4_)
            {
               traverseObject(_loc5_,param2,param3);
            }
         }
      }
      
      public static function traverserDisplayObject(param1:Object) : Array
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:int = 0;
         var _loc2_:Array = new Array();
         if(param1 is DisplayObjectContainer)
         {
            _loc3_ = param1 as DisplayObjectContainer;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.numChildren)
            {
               try
               {
                  _loc2_.push(_loc3_.getChildAt(_loc4_));
               }
               catch(err:Error)
               {
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      public static function matchObjects(param1:Array, param2:Array, param3:String, param4:String, param5:Function) : void
      {
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         for each(_loc6_ in param1)
         {
            _loc7_ = findLeaf(_loc6_,param3);
            for each(_loc8_ in param2)
            {
               _loc9_ = findLeaf(_loc8_,param4);
               if(_loc7_.valueOf() == _loc9_.valueOf())
               {
                  param5.call(null,_loc6_,_loc8_);
               }
            }
         }
      }
      
      private static function findLeaf(param1:Object, param2:String) : Object
      {
         var _loc5_:Object = null;
         var _loc3_:Array = param2.split(".");
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = param1[_loc3_[_loc4_]];
            if(_loc5_ is Function)
            {
               param1 = _loc5_();
            }
            else
            {
               param1 = _loc5_;
            }
            _loc4_++;
         }
         return param1;
      }
   }
}

