package com.moviestarplanet.utils.tooltips
{
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.utils.tooltips.interfaces.TooltipWrapper;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class MSP_ToolTipManager
   {
      
      private static var _container:DisplayObject;
      
      private static var _toolTips:Dictionary;
      
      private static var _isContainerDefined:Boolean;
      
      private static var _currentToolTipElement:ToolTipsElement;
      
      private static var _currentElement:DisplayObject;
      
      private static var timer:Timer;
      
      private static const POPUP_DELAY:Number = 600;
      
      private static const FOLLOW_MOUSE:Boolean = true;
      
      public static const AUTO_ORIENTATION:String = "AUTO";
      
      public static const LEFT_ORIENTATION:String = "LEFT";
      
      public static const RIGHT_ORIENTATION:String = "RIGHT";
      
      private static const TOOLTIP_RIGHT_DISTANCE:int = 15;
      
      private static const TOOLTIP_DOWN_DISTANCE:int = 20;
      
      public function MSP_ToolTipManager()
      {
         super();
      }
      
      public static function initialize(param1:DisplayObject) : void
      {
         _toolTips = new Dictionary(true);
         _container = param1;
         _isContainerDefined = true;
         timer = new Timer(POPUP_DELAY,1);
         timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
      }
      
      public static function add(param1:DisplayObject, param2:String, param3:Boolean = true, param4:String = "AUTO") : void
      {
         if(ConstantsPlatform.isWeb)
         {
            if(_toolTips[param1] != null)
            {
               (_toolTips[param1] as ToolTipsElement).toolTipText = param2;
            }
            else
            {
               param1.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
               param1.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
               _toolTips[param1] = new ToolTipsElement(param2,param3,param4);
            }
         }
      }
      
      public static function remove(param1:DisplayObject) : void
      {
         if(ConstantsPlatform.isWeb)
         {
            param1.removeEventListener(MouseEvent.ROLL_OVER,onRollOver);
            param1.removeEventListener(MouseEvent.ROLL_OUT,onRollOut);
            _toolTips[param1] = null;
            if(param1 == _currentElement)
            {
               onRollOut(null);
            }
         }
      }
      
      public static function update(param1:DisplayObject, param2:String) : Boolean
      {
         if(_toolTips[param1] != null)
         {
            (_toolTips[param1] as ToolTipsElement).toolTipText = param2;
            return true;
         }
         return false;
      }
      
      private static function onRollOver(param1:Event) : void
      {
         if(_isContainerDefined)
         {
            _currentElement = param1.currentTarget as DisplayObject;
            _currentToolTipElement = _toolTips[_currentElement] as ToolTipsElement;
            if(_toolTips[_currentElement].delay == true)
            {
               timer.start();
            }
            else
            {
               timerComplete();
            }
         }
      }
      
      private static function timerComplete(param1:Event = null) : void
      {
         TooltipWrapper.createTooltip(_currentToolTipElement);
         positionToolTip();
         if(FOLLOW_MOUSE == true)
         {
            _currentElement.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
         }
      }
      
      private static function positionToolTip() : void
      {
         var _loc1_:Point = _currentElement.localToGlobal(new Point(_currentElement.mouseX,_currentElement.mouseY));
         switch(_currentToolTipElement.orientation)
         {
            case LEFT_ORIENTATION:
               positionToolTipLeft(_loc1_);
               break;
            case RIGHT_ORIENTATION:
               positionToolTipRight(_loc1_);
               break;
            case AUTO_ORIENTATION:
            default:
               if(doesNotExtendTooFarRight(_loc1_) && doesNotExtendTooFarDown(_loc1_))
               {
                  positionToolTipRight(_loc1_);
                  break;
               }
               positionToolTipLeft(_loc1_);
         }
      }
      
      private static function positionToolTipRight(param1:Point) : void
      {
         TooltipWrapper.setPosition(param1.x + TOOLTIP_RIGHT_DISTANCE,param1.y + TOOLTIP_DOWN_DISTANCE);
      }
      
      private static function positionToolTipLeft(param1:Point) : void
      {
         TooltipWrapper.setPosition(param1.x - TooltipWrapper.width,param1.y);
      }
      
      private static function doesNotExtendTooFarRight(param1:Point) : Boolean
      {
         return param1.x + TooltipWrapper.width + TOOLTIP_RIGHT_DISTANCE < _container.stage.stageWidth;
      }
      
      private static function doesNotExtendTooFarDown(param1:Point) : Boolean
      {
         return param1.y + TooltipWrapper.height + TOOLTIP_DOWN_DISTANCE < _container.stage.stageHeight;
      }
      
      private static function onMouseMove(param1:MouseEvent) : void
      {
         if(_currentElement != null)
         {
            positionToolTip();
            return;
         }
         throw Error("_currentElement is null and still has event listener. MSP_ToolTipManager");
      }
      
      private static function onRollOut(param1:Event) : void
      {
         timer.stop();
         timer.reset();
         if(TooltipWrapper.hasToolTip())
         {
            _currentElement.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
            TooltipWrapper.destroy();
            _currentElement = null;
         }
      }
   }
}

