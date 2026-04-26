package com.moviestarplanet.color
{
   import com.moviestarplanet.color.colorpicker.ColorPickerModel;
   import com.moviestarplanet.color.colorpicker.ColorPickerModelInterface;
   import com.moviestarplanet.color.colorpicker.ColorPickerView;
   import com.moviestarplanet.color.colortooltip.ColorTooltipModel;
   import com.moviestarplanet.color.colortooltip.ColorTooltipModelInterface;
   import com.moviestarplanet.color.colortooltip.ColorTooltipView;
   import com.moviestarplanet.color.mobilecolorpicker.MobileColorPickerView;
   import com.moviestarplanet.color.tooltipwrapper.ColorTooltip;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ColorController
   {
      
      public static var applicationContainer:DisplayObjectContainer;
      
      private static var tooltipInstances:Array = new Array();
      
      public static const QUADRANT_UPPERRIGHT:int = 0;
      
      public static const QUADRANT_UPPERLEFT:int = 1;
      
      public static const QUADRANT_LOWERLEFT:int = 2;
      
      public static const QUADRANT_LOWERRIGHT:int = 3;
      
      public function ColorController()
      {
         super();
      }
      
      private static function checkancestry(param1:DisplayObject, ... rest) : Boolean
      {
         var _loc3_:int = 0;
         while(param1.parent != null)
         {
            _loc3_ = 0;
            while(_loc3_ < rest.length)
            {
               trace(param1.toString());
               if(param1 is rest[_loc3_])
               {
                  return true;
               }
               _loc3_++;
            }
            param1 = param1.parent;
         }
         return false;
      }
      
      public static function openColorPicker(param1:DisplayObjectContainer, param2:int, param3:int, param4:Array, param5:Function, param6:Function, param7:int = -1, param8:Point = null, param9:Number = -1) : void
      {
         var model:ColorPickerModelInterface;
         var stage:Stage = null;
         var clickRef:Function = null;
         var view:ColorPickerView = null;
         var mouseclicked:Function = null;
         var internalResult:Function = null;
         var container:DisplayObjectContainer = param1;
         var x:int = param2;
         var y:int = param3;
         var colorScheme:Array = param4;
         var result:Function = param5;
         var update:Function = param6;
         var quadrant:int = param7;
         var pickerOrigin:Point = param8;
         var pickerMaxWidth:Number = param9;
         mouseclicked = function(param1:MouseEvent):void
         {
            var _loc2_:DisplayObject = param1.target as DisplayObject;
            if(checkancestry(_loc2_,ColorPickerView) == false)
            {
               stage.removeEventListener(MouseEvent.MOUSE_UP,clickRef);
               container.removeChild(view);
            }
         };
         internalResult = function(param1:uint):void
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,clickRef);
            container.removeChild(view);
            result(param1);
         };
         stage = container.stage;
         clickRef = mouseclicked;
         stage.addEventListener(MouseEvent.MOUSE_UP,clickRef);
         model = new ColorPickerModel(colorScheme,internalResult,update);
         view = new ColorPickerView(model,19);
         if(quadrant == -1)
         {
            if(pickerOrigin == null)
            {
               pickerOrigin = new Point(0,0);
            }
            openColorPickerWithPlacement(view,container,pickerOrigin,pickerMaxWidth);
         }
         else
         {
            openColorPickerInQuadrant(view,container,x,y,quadrant);
         }
      }
      
      private static function openColorPickerInQuadrant(param1:DisplayObject, param2:DisplayObjectContainer, param3:int, param4:int, param5:int) : void
      {
         switch(param5 % 4)
         {
            case QUADRANT_UPPERRIGHT:
               param4 -= param1.height;
               break;
            case QUADRANT_UPPERLEFT:
               param3 -= param1.width;
               param4 -= param1.height;
               break;
            case QUADRANT_LOWERLEFT:
               param3 -= param1.width;
               break;
            case QUADRANT_LOWERRIGHT:
         }
         var _loc6_:Point = new Point(param3,param4);
         var _loc7_:Point = new Point(param3 + param1.width,param4 + param1.height);
         var _loc8_:Point = param2.localToGlobal(_loc6_);
         var _loc9_:Point = param2.localToGlobal(_loc7_);
         var _loc10_:Point = applicationContainer.globalToLocal(_loc8_);
         var _loc11_:Point = applicationContainer.globalToLocal(_loc9_);
         if(_loc10_.y < 0)
         {
            param4 -= _loc10_.y;
         }
         else if(_loc11_.y > applicationContainer.height)
         {
            param4 -= _loc11_.y - applicationContainer.height;
         }
         if(_loc10_.x < 0)
         {
            param3 -= _loc10_.x;
         }
         else if(_loc11_.x > applicationContainer.width)
         {
            param3 -= _loc11_.x - applicationContainer.width;
         }
         param1.x = param3;
         param1.y = param4;
         param2.addChild(param1);
      }
      
      private static function openColorPickerWithPlacement(param1:ColorPickerView, param2:DisplayObjectContainer, param3:Point, param4:Number) : void
      {
         param1.x = param3.x;
         param1.y = param3.y;
         var _loc5_:Number = param4 / param1.width;
         param1.width = _loc5_ * param1.width;
         param1.height = _loc5_ * param1.height;
         param2.addChild(param1);
      }
      
      public static function openColorTooltip(param1:DisplayObjectContainer, param2:int, param3:int, param4:Array, param5:Array, param6:Function, param7:Function, param8:int, param9:Boolean = true, param10:Class = null, param11:Point = null, param12:Boolean = true, param13:Function = null, param14:Boolean = false) : ColorRequestInterface
      {
         var model:ColorTooltipModelInterface;
         var colorRequest:ColorRequestInterface;
         var clickRef:Function = null;
         var view:ColorTooltipView = null;
         var addedDisplayObject:DisplayObject = null;
         var cttInstance:Object = null;
         var mouseclicked:Function = null;
         var closerequested:Function = null;
         var container:DisplayObjectContainer = param1;
         var x:int = param2;
         var y:int = param3;
         var initialColors:Array = param4;
         var defaultColors:Array = param5;
         var result:Function = param6;
         var update:Function = param7;
         var pickerQuadrant:int = param8;
         var autoRemove:Boolean = param9;
         var TooltipView:Class = param10;
         var toolTipOffset:Point = param11;
         var centered:Boolean = param12;
         var onRemoved:Function = param13;
         var oldColorPicker:Boolean = param14;
         mouseclicked = function(param1:MouseEvent):void
         {
            var _loc2_:DisplayObject = param1.target as DisplayObject;
            if(checkancestry(_loc2_,ColorTooltipView,ColorPickerView,MobileColorPickerView) == false)
            {
               closerequested();
            }
         };
         closerequested = function():void
         {
            var _loc1_:int = 0;
            if(autoRemove)
            {
               container.stage.removeEventListener(MouseEvent.MOUSE_UP,clickRef);
            }
            if(addedDisplayObject.parent)
            {
               container.removeChild(addedDisplayObject);
            }
            if(onRemoved != null)
            {
               onRemoved();
            }
            if(tooltipInstances != null)
            {
               _loc1_ = int(tooltipInstances.indexOf(cttInstance));
               if(_loc1_ > -1)
               {
                  tooltipInstances.splice(_loc1_,1);
               }
            }
            view.destroy();
         };
         if(TooltipView == null)
         {
            TooltipView = ColorTooltipView;
         }
         clickRef = mouseclicked;
         if(autoRemove)
         {
            container.stage.addEventListener(MouseEvent.MOUSE_UP,clickRef);
         }
         model = new ColorTooltipModel(initialColors,defaultColors,result,update,pickerQuadrant,toolTipOffset);
         view = new TooltipView(model,applicationContainer,centered,container,oldColorPicker);
         if(ColorTooltip.isFlex(container))
         {
            addedDisplayObject = ColorTooltip.createWrapperFor(view);
         }
         else
         {
            addedDisplayObject = view;
         }
         addedDisplayObject.x = x;
         addedDisplayObject.y = y;
         addedDisplayObject.name = "thahoodHint";
         container.addChild(addedDisplayObject);
         cttInstance = {
            "container":container,
            "view":addedDisplayObject,
            "clickRef":clickRef
         };
         tooltipInstances.push(cttInstance);
         colorRequest = new ColorRequest(closerequested,view);
         return colorRequest;
      }
      
      public static function isColorToolTipOpen() : Boolean
      {
         return tooltipInstances.length > 0;
      }
      
      public static function closeAllToolTips() : int
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         if(tooltipInstances != null)
         {
            for each(_loc2_ in tooltipInstances)
            {
               if(_loc2_)
               {
                  if(_loc2_.container != null)
                  {
                     if(_loc2_.container.stage != null)
                     {
                        _loc2_.container.stage.removeEventListener(MouseEvent.MOUSE_UP,_loc2_.clickRef);
                     }
                     _loc2_.container.removeChild(_loc2_.view);
                  }
               }
            }
         }
         tooltipInstances = new Array();
         return _loc1_;
      }
   }
}

