package com.moviestarplanet.utils.displayobject
{
   import com.greensock.TweenMax;
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.utils.ComponentUtilities;
   import com.moviestarplanet.utils.ui.ImageTweenUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class DisplayObjectUtilities
   {
      
      public function DisplayObjectUtilities()
      {
         super();
         throw new Error("Do not instantiate " + getQualifiedClassName(this));
      }
      
      public static function getVisibleBounds(param1:DisplayObject) : Rectangle
      {
         var _loc2_:Matrix = new Matrix();
         var _loc3_:Rectangle = param1.getBounds(param1);
         if(_loc3_.width == 0 || _loc3_.height == 0)
         {
            return new Rectangle(0,0,0,0);
         }
         _loc2_.tx = -_loc3_.x;
         _loc2_.ty = -_loc3_.y;
         var _loc4_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         _loc4_.draw(param1,_loc2_);
         var _loc5_:Rectangle = _loc4_.getColorBoundsRect(4294967295,0,false);
         _loc4_.dispose();
         _loc5_.x += _loc3_.x;
         _loc5_.y += _loc3_.y;
         return _loc5_;
      }
      
      public static function setButtonizedEnabled(param1:DisplayObject, param2:Boolean, param3:Boolean = false, param4:Function = null) : void
      {
         if(param1 != null)
         {
            if(param1)
            {
               Buttonizer.setButtonizedEnabled(param1,param2,param3,param4);
            }
         }
      }
      
      public static function buttonizeFramesStates(param1:MovieClip, param2:Function, param3:Boolean = true, param4:String = null, param5:uint = 4369) : void
      {
         Buttonizer.buttonizeFramesStates(param1,param2,param3,param4,param5);
      }
      
      public static function buttonizeFrames(param1:MovieClip, param2:Function, param3:Boolean = true, param4:String = null) : void
      {
         buttonizeFramesStates(param1,param2,param3,param4,15);
      }
      
      public static function unbuttonizeFrames(param1:MovieClip, param2:Function) : void
      {
         Buttonizer.unbuttonizeFrames(param1,param2);
      }
      
      public static function dim(param1:DisplayObject, param2:Boolean, param3:Number = 0) : void
      {
         Buttonizer.dim(param1,param2);
      }
      
      public static function dimMore(param1:DisplayObject, param2:Boolean, param3:Number = 0) : void
      {
         Buttonizer.dimMore(param1,param2);
      }
      
      public static function desaturate(param1:DisplayObject, param2:Boolean) : void
      {
         if(param1 != null)
         {
            if(param2)
            {
               TweenMax.to(param1,0,{"colorMatrixFilter":{}});
            }
            else
            {
               TweenMax.to(param1,0,{"colorMatrixFilter":{
                  "saturation":0,
                  "brightness":1.1
               }});
            }
         }
      }
      
      public static function tint(param1:DisplayObject, param2:Number = 0.5, param3:Number = 0.5, param4:Number = 0.5) : void
      {
         var _loc5_:Array = param1.filters.concat();
         var _loc6_:Array = new Array();
         _loc6_ = _loc6_.concat([param2,param2,param2,0,0]);
         _loc6_ = _loc6_.concat([param3,param3,param3,0,0]);
         _loc6_ = _loc6_.concat([param4,param4,param4,0,0]);
         _loc6_ = _loc6_.concat([0,0,0,1,0]);
         var _loc7_:ColorMatrixFilter = new ColorMatrixFilter(_loc6_);
         _loc5_.push(_loc7_);
         param1.filters = _loc5_;
      }
      
      public static function buttonize(param1:DisplayObject, param2:Function, param3:Boolean = true, param4:Boolean = true, param5:String = null, param6:int = 1) : void
      {
         if(param1 == null)
         {
            return;
         }
         Buttonizer.buttonize(param1,param2,param3,param4,param5,param6);
         if(param3)
         {
            ImageTweenUtils.addGlow(param1);
         }
      }
      
      public static function unButtonize(param1:DisplayObject, param2:Function, param3:String = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         ImageTweenUtils.removeGlow(param1);
         Buttonizer.unButtonize(param1,param2);
      }
      
      public static function checkboxifyFrames(param1:MovieClip, param2:Function) : void
      {
         param1.stateChange = param2;
         param1.stop();
         Buttonizer.addCursorSettings(param1);
         param1.addEventListener(MouseEvent.MOUSE_UP,checkboxifyUp,false,0,true);
         param1.addEventListener(MouseEvent.MOUSE_OVER,checkboxifyOver,false,0,true);
         param1.addEventListener(MouseEvent.MOUSE_OUT,checkboxifyOut,false,0,true);
      }
      
      public static function addHoverSound(param1:Object) : void
      {
         Buttonizer.addHoverSound(param1);
      }
      
      private static function checkboxifyUp(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         switch(_loc2_.currentFrameLabel)
         {
            case "uncheckedHover":
            case "unchecked":
               _loc2_.stateChange(true);
               _loc2_.gotoAndStop("checkedHover");
               break;
            case "checkedHover":
            case "checked":
               _loc2_.stateChange(false);
               _loc2_.gotoAndStop("uncheckedHover");
         }
      }
      
      private static function checkboxifyOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         switch(_loc2_.currentFrameLabel)
         {
            case "unchecked":
               _loc2_.gotoAndStop("uncheckedHover");
               break;
            case "checked":
               _loc2_.gotoAndStop("checkedHover");
         }
      }
      
      private static function checkboxifyOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         switch(_loc2_.currentFrameLabel)
         {
            case "uncheckedHover":
               _loc2_.gotoAndStop("unchecked");
               break;
            case "checkedHover":
               _loc2_.gotoAndStop("checked");
         }
      }
      
      public static function disableClick(param1:DisplayObject, param2:Function) : void
      {
         var _loc3_:Sprite = null;
         param1.removeEventListener(MouseEvent.CLICK,param2);
         param1.alpha = 0.5;
         if(param1 is Sprite)
         {
            _loc3_ = param1 as Sprite;
            _loc3_.useHandCursor = false;
            _loc3_.buttonMode = false;
            _loc3_.mouseChildren = true;
         }
      }
      
      public static function enableClick(param1:DisplayObject, param2:Function) : void
      {
         var _loc3_:Sprite = null;
         param1.addEventListener(MouseEvent.CLICK,param2);
         param1.alpha = 1;
         if(param1 is Sprite)
         {
            _loc3_ = param1 as Sprite;
            _loc3_.useHandCursor = true;
            _loc3_.buttonMode = true;
            _loc3_.mouseChildren = false;
         }
      }
      
      public static function drawScaledBitmap(param1:DisplayObject, param2:Sprite, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:Matrix = new Matrix();
         _loc6_.scale(param5,param5);
         var _loc7_:Matrix = _loc6_.clone();
         _loc7_.invert();
         var _loc8_:BitmapData = new BitmapData(param3 * param5,param4 * param5,false,0);
         _loc8_.draw(param1,_loc6_,null,null,null,false);
         param2.graphics.clear();
         param2.graphics.beginBitmapFill(_loc8_,_loc7_);
         param2.graphics.drawRect(0,0,param3,param4);
         param2.graphics.endFill();
      }
      
      public static function gotoAndStopAllMovieClips(param1:DisplayObject, param2:uint) : void
      {
         var _loc3_:Array = null;
         var _loc4_:MovieClip = null;
         if(param1 != null)
         {
            _loc3_ = ComponentUtilities.findInstancesByClass(param1,MovieClip);
            for each(_loc4_ in _loc3_)
            {
               _loc4_.gotoAndStop(1);
            }
         }
      }
      
      public static function removeChildren(param1:DisplayObjectContainer, param2:int = 0) : void
      {
         while(param1.numChildren > param2)
         {
            param1.removeChildAt(param2);
         }
      }
      
      public static function modalize(param1:DisplayObjectContainer, param2:Function = null) : void
      {
         param1.mouseChildren = param1.mouseEnabled = false;
         TweenMax.to(param1,0.4,{"colorMatrixFilter":{
            "colorize":0,
            "amount":0.5
         }});
         if(param2 != null)
         {
            param2();
         }
      }
      
      public static function unmodalize(param1:DisplayObjectContainer) : void
      {
         param1.mouseChildren = param1.mouseEnabled = true;
         TweenMax.to(param1,0.4,{"colorMatrixFilter":{}});
      }
   }
}

