package com.moviestarplanet.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class FlashUtils
   {
      
      private static var useColorTinting:Boolean = false;
      
      public function FlashUtils()
      {
         super();
      }
      
      public static function ApplyColorMultipliers(param1:DisplayObject, param2:uint) : void
      {
         var _loc3_:ColorTransform = null;
         var _loc4_:ColorTransform = null;
         if(param1 != null)
         {
            _loc3_ = param1.transform.colorTransform;
            if(useColorTinting)
            {
               _loc4_ = new ColorTransform();
               _loc4_.color = param2;
               _loc3_.redMultiplier = Math.min(1,_loc4_.redOffset / 255 * 1);
               _loc3_.greenMultiplier = Math.min(1,_loc4_.greenOffset / 255 * 1);
               _loc3_.blueMultiplier = Math.min(1,_loc4_.blueOffset / 255 * 1);
               _loc3_.redOffset = 0.3 * 255;
               _loc3_.redOffset = 0.3 * 255;
               _loc3_.redOffset = 0.3 * 255;
            }
            else
            {
               _loc3_.color = param2;
            }
            param1.transform.colorTransform = _loc3_;
         }
      }
      
      public static function Assert(param1:Boolean, param2:String = "") : void
      {
         if(!param1)
         {
            trace(param2,"Assertion Failed");
         }
      }
      
      public static function GotoAndStopAndWaitForCompletion(param1:MovieClip, param2:Object, param3:Function = null, param4:int = 10) : void
      {
         var intervalId:int = 0;
         var setIntervalCallback:Function = null;
         var mc:MovieClip = param1;
         var frame:Object = param2;
         var done:Function = param3;
         var pollInterval:int = param4;
         setIntervalCallback = function():void
         {
            clearInterval(intervalId);
            if(Boolean(IsComplete(mc)))
            {
               done(mc);
            }
            else
            {
               intervalId = setInterval(setIntervalCallback,pollInterval);
            }
         };
         var IsComplete:Function = function(param1:DisplayObjectContainer):Boolean
         {
            var _loc3_:DisplayObject = null;
            var _loc2_:int = 0;
            while(_loc2_ < param1.numChildren)
            {
               _loc3_ = param1.getChildAt(_loc2_);
               if(_loc3_ == null)
               {
                  return false;
               }
               if(_loc3_ is DisplayObjectContainer)
               {
                  if(IsComplete(_loc3_ as DisplayObjectContainer) == false)
                  {
                     return false;
                  }
               }
               _loc2_++;
            }
            return true;
         };
         mc.gotoAndStop(frame);
         if(done == null)
         {
            return;
         }
         intervalId = int(setInterval(setIntervalCallback,10));
      }
      
      public static function NotifyWhenAllDone(param1:Function, param2:Array, param3:Function) : void
      {
         var doneCount:int = 0;
         var count:int = 0;
         var parameter:* = undefined;
         var LocalDone:Function = null;
         var functionWithDoneCallBack:Function = param1;
         var callParameters:Array = param2;
         var allDone:Function = param3;
         LocalDone = function():void
         {
            ++count;
            if(count == doneCount)
            {
               if(allDone != null)
               {
                  allDone();
               }
            }
         };
         if(callParameters.length == 0)
         {
            if(allDone != null)
            {
               allDone();
            }
            return;
         }
         doneCount = int(callParameters.length);
         count = 0;
         for each(parameter in callParameters)
         {
            functionWithDoneCallBack(parameter,LocalDone);
         }
      }
      
      public static function duplicateDisplayObject(param1:DisplayObject, param2:Boolean = false) : DisplayObject
      {
         var _loc5_:Rectangle = null;
         var _loc3_:Class = Object(param1).constructor;
         var _loc4_:DisplayObject = new _loc3_();
         _loc4_.transform = param1.transform;
         _loc4_.filters = param1.filters;
         _loc4_.cacheAsBitmap = param1.cacheAsBitmap;
         _loc4_.opaqueBackground = param1.opaqueBackground;
         if(param1.scale9Grid)
         {
            _loc5_ = param1.scale9Grid;
            _loc4_.scale9Grid = _loc5_;
         }
         if(param2 && Boolean(param1.parent))
         {
            param1.parent.addChild(_loc4_);
         }
         return _loc4_;
      }
   }
}

