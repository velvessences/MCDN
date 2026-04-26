package com.moviestarplanet.window.utils
{
   import com.moviestarplanet.window.stack.WindowStack;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.containers.Canvas;
   import mx.core.Container;
   
   public class PopupUtils extends WindowStack
   {
      
      public static var rootContainer:Container;
      
      public static var windowCanvasRect:Rectangle;
      
      private static var _stageDisabler:Canvas;
      
      public function PopupUtils()
      {
         super();
      }
      
      public static function addPopupUnderMouse(param1:Container, param2:int = -1, param3:int = -1, param4:Function = null, param5:int = 9) : void
      {
         rootContainer.addChild(param1);
         if(param2 > 0)
         {
            param1.width = param2;
         }
         if(param3 > 0)
         {
            param1.height = param3;
         }
         param1.x = rootContainer.mouseX;
         param1.y = rootContainer.mouseY;
         var _loc6_:Number = param1.x + param1.width - rootContainer.width;
         var _loc7_:Number = param1.y + param1.height - rootContainer.height;
         if(_loc6_ > 0)
         {
            param1.x -= _loc6_;
         }
         if(_loc7_ > 0)
         {
            param1.y -= _loc7_;
         }
         showPopupInternal(param1,null,param4,false,param5);
      }
      
      public static function showPopupRectangle(param1:Container, param2:Rectangle, param3:Container = null, param4:Function = null) : void
      {
         showPopupDimensions(param1,param2.x,param2.y,param2.width,param2.height,param3,param4);
      }
      
      public static function showPopupDimensions(param1:Container, param2:int, param3:int, param4:int, param5:int, param6:Container = null, param7:Function = null) : void
      {
         param1.x = param2;
         param1.y = param3;
         param1.width = param4;
         param1.height = param5;
         showPopupInternal(param1,param6,param7);
      }
      
      public static function showPopupChatbox(param1:Container, param2:int, param3:int) : void
      {
         var _loc4_:Number = windowCanvasRect.width + windowCanvasRect.x - param1.width;
         var _loc5_:Number = windowCanvasRect.height + windowCanvasRect.y - param1.height;
         if(_loc5_ < 0)
         {
            windowCanvasRect.height + windowCanvasRect.y - 320;
         }
         param1.x = param2 < _loc4_ ? param2 : _loc4_;
         param1.y = param3 < _loc5_ ? param3 : _loc5_;
         showPopupInternalNoTween(param1,null,null,false,Z_CHATBOX);
      }
      
      public static function showPopupXY(param1:Container, param2:int, param3:int, param4:Container = null, param5:Function = null) : void
      {
         param1.x = param2;
         param1.y = param3;
         showPopupInternal(param1,param4,param5);
      }
      
      public static function showPopupCentered(param1:Container, param2:Container = null, param3:Function = null, param4:Boolean = false) : void
      {
         var _loc5_:Container = param2 == null ? rootContainer : param2;
         param1.x = windowCanvasRect.x + windowCanvasRect.width / 2 - param1.width / 2;
         param1.y = windowCanvasRect.y + windowCanvasRect.height / 2 - param1.height / 2;
         showPopupInternal(param1,_loc5_,param3,param4);
      }
      
      public static function removePopup(param1:Container, param2:Function = null, param3:DisplayObjectContainer = null, param4:Boolean = true) : void
      {
         var remove:Function = null;
         var tweener:PopupTweener = null;
         var popup:Container = param1;
         var onClose:Function = param2;
         var parentContainer:DisplayObjectContainer = param3;
         var useTweener:Boolean = param4;
         remove = function():void
         {
            removeSpriteViewStackable(popup);
            if(onClose != null)
            {
               onClose();
            }
         };
         if(useTweener)
         {
            tweener = new PopupTweener(popup);
            tweener.tweenHide(remove);
         }
         else
         {
            remove();
         }
      }
      
      private static function showPopupInternalNoTween(param1:Container, param2:Container = null, param3:Function = null, param4:Boolean = false, param5:int = 9) : void
      {
         var removeStageDisabler:Function = null;
         var popup:Container = param1;
         var container:Container = param2;
         var onDone:Function = param3;
         var disableStage:Boolean = param4;
         var z:int = param5;
         removeStageDisabler = function(param1:Event):void
         {
            if(_stageDisabler != null && _stageDisabler.parent != null)
            {
               _stageDisabler.parent.removeChild(_stageDisabler);
               _stageDisabler = null;
            }
         };
         var usedContainer:Container = container == null ? rootContainer : container;
         if(disableStage)
         {
            _stageDisabler = new Canvas();
            _stageDisabler.width = usedContainer.width;
            _stageDisabler.height = usedContainer.height;
            _stageDisabler.setStyle("backgroundColor",0);
            _stageDisabler.alpha = 0;
            usedContainer.addChild(_stageDisabler);
            popup.addEventListener(Event.REMOVED_FROM_STAGE,removeStageDisabler);
            (tweenerClass as Object).to(_stageDisabler,0.3,{"alpha":0.3});
         }
         popup.isPopUp = true;
         showSpriteAsViewStackable(popup,0,0,z);
      }
      
      private static function showPopupInternal(param1:Container, param2:Container = null, param3:Function = null, param4:Boolean = false, param5:int = 9) : void
      {
         var tweener:PopupTweener;
         var removeStageDisabler:Function = null;
         var popup:Container = param1;
         var container:Container = param2;
         var onDone:Function = param3;
         var disableStage:Boolean = param4;
         var z:int = param5;
         removeStageDisabler = function(param1:Event):void
         {
            if(_stageDisabler != null && _stageDisabler.parent != null)
            {
               _stageDisabler.parent.removeChild(_stageDisabler);
               _stageDisabler = null;
            }
         };
         var usedContainer:Container = container == null ? rootContainer : container;
         if(disableStage)
         {
            _stageDisabler = new Canvas();
            _stageDisabler.width = usedContainer.width;
            _stageDisabler.height = usedContainer.height;
            _stageDisabler.setStyle("backgroundColor",0);
            _stageDisabler.alpha = 0;
            usedContainer.addChild(_stageDisabler);
            popup.addEventListener(Event.REMOVED_FROM_STAGE,removeStageDisabler);
            (tweenerClass as Object).to(_stageDisabler,0.3,{"alpha":0.3});
         }
         tweener = new PopupTweener(popup);
         popup.isPopUp = true;
         showSpriteAsViewStackable(popup,0,0,z);
         popup.validateNow();
         tweener.tweenShow(function():void
         {
            if(onDone != null)
            {
               onDone();
            }
         });
      }
      
      public static function positionInQuadrant(param1:DisplayObject, param2:DisplayObject, param3:Number, param4:Number, param5:int) : void
      {
         switch(param5 % 4)
         {
            case 0:
               param1.x = param3;
               param1.y = param4 - param1.height;
               break;
            case 1:
               param1.x = param3;
               param1.y = param4;
               break;
            case 2:
               param1.x = param3 - param1.width;
               param1.y = param4;
               break;
            case 3:
               param1.x = param3 - param1.width;
               param1.y = param4 - param1.height;
         }
         var _loc6_:Point = new Point(0,0);
         var _loc7_:Point = new Point(rootContainer.width,rootContainer.height);
         _loc6_ = rootContainer.localToGlobal(_loc6_);
         _loc7_ = rootContainer.localToGlobal(_loc7_);
         _loc6_ = param1.globalToLocal(_loc6_);
         _loc7_ = param1.globalToLocal(_loc7_);
         if(_loc6_.x > 0)
         {
            param1.x += _loc6_.x - 0;
         }
         else if(_loc7_.x < param1.width)
         {
            param1.x += _loc7_.x - param1.width;
         }
         if(_loc6_.y > 0)
         {
            param1.y += _loc6_.y - 0;
         }
         else if(_loc7_.y < param1.height)
         {
            param1.y += _loc7_.y - param1.height;
         }
      }
   }
}

