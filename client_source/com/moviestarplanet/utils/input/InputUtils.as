package com.moviestarplanet.utils.input
{
   import com.greensock.TweenLite;
   import com.moviestarplanet.Components.FontSelector.FontColorSelector;
   import com.moviestarplanet.Components.FontSelector.FontColorSelectorEvent;
   import com.moviestarplanet.emoticon.selector.EmoticonSelectorControllerWeb;
   import com.moviestarplanet.flash.components.popups.viponly.VIPOnlyPopUp;
   import com.moviestarplanet.messaging.module.moduleparts.messagingwindow.embedmapping.MessagingEmoticonContainer;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.textfield.TextFieldUtilities;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.utils.PopupUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import mx.core.UIComponent;
   
   public class InputUtils
   {
      
      private static var tabArray:Array;
      
      private static var tabbingStage:Stage;
      
      private static var dict:Dictionary = new Dictionary(true);
      
      public function InputUtils()
      {
         super();
      }
      
      public static function mapInput(param1:InputAreaInterface, param2:Function) : void
      {
         if(param2 == null)
         {
            return;
         }
         param1.addEventListener(KeyboardEvent.KEY_UP,keyUp);
         dict[param1.textArea] = param2;
      }
      
      private static function keyUp(param1:KeyboardEvent) : void
      {
         if(param1.charCode == 13 && param1.shiftKey == false)
         {
            TextFieldUtilities.truncateExcessiveLineBreaks(param1.currentTarget.textArea);
            (dict[param1.currentTarget.textArea] as Function).call();
         }
      }
      
      public static function unMapInput(param1:InputAreaInterface) : void
      {
         param1.removeEventListener(KeyboardEvent.KEY_UP,keyUp);
         if(dict[param1] != null)
         {
            delete dict[param1];
         }
      }
      
      public static function mapEmoticonFunctions(param1:InputAreaInterface, param2:Function = null, param3:int = 1, param4:Boolean = false) : void
      {
         var window:DisplayObjectContainer = null;
         var emoticonSelected:Function = null;
         var emoteClick:Function = null;
         var inputArea:InputAreaInterface = param1;
         var emoticonSelectedCallback:Function = param2;
         var quadrant:int = param3;
         var useBig:Boolean = param4;
         emoticonSelected = function(param1:String):void
         {
            var _loc2_:String = null;
            var _loc3_:int = 0;
            if(useBig && Boolean(shouldPrintBig(param1)))
            {
               _loc2_ = String.fromCharCode(29);
               emoticonSelectedCallback(_loc2_ + param1 + _loc2_);
            }
            else
            {
               if(!useBig && emoticonSelectedCallback != null)
               {
                  emoticonSelectedCallback();
               }
               _loc3_ = inputArea.textArea.selectionBeginIndex + param1.length;
               inputArea.textArea.replaceText(inputArea.textArea.selectionBeginIndex,inputArea.textArea.selectionEndIndex,param1);
               inputArea.textArea.setSelection(_loc3_,_loc3_);
            }
         };
         emoteClick = function(param1:MouseEvent):void
         {
            var _loc2_:Point = window.globalToLocal(new Point(window.stage.mouseX,window.stage.mouseY));
            EmoticonSelectorControllerWeb.OpenEmoticonSelector(window,_loc2_.x,_loc2_.y,emoticonSelected,quadrant,useBig);
         };
         var shouldPrintBig:Function = function(param1:String):Boolean
         {
            return param1.indexOf("(octo_") == 0 || param1.indexOf("(square_") == 0 || param1.indexOf("(dj_") == 0 || param1.indexOf("(santa_") == 0 || param1.indexOf("(hearts_") == 0;
         };
         window = Main.Instance.mainCanvas;
         DisplayObjectUtilities.buttonize(inputArea.emoticonBtn,emoteClick,true,false);
      }
      
      public static function mapFontFunctions(param1:InputAreaInterface, param2:Function, param3:int = 1, param4:int = 10, param5:int = 20) : void
      {
         var window:DisplayObjectContainer = null;
         var emoticonContainer:DisplayObjectContainer = null;
         var fontcolorSelector:FontColorSelector = null;
         var addedToStage:Function = null;
         var fontColorClick:Function = null;
         var anywhereClicked:Function = null;
         var colorSelected:Function = null;
         var inputArea:InputAreaInterface = param1;
         var colorSelectedFunction:Function = param2;
         var quadrant:int = param3;
         var rows:int = param4;
         var size:int = param5;
         addedToStage = function(param1:Event):void
         {
            window.stage.addEventListener(MouseEvent.CLICK,anywhereClicked);
            fontcolorSelector.addEventListener(FontColorSelectorEvent.FONTCOLOR_SELECTED,colorSelected);
            DisplayObjectUtilities.buttonize(inputArea.fontColorButton,fontColorClick);
         };
         fontColorClick = function(param1:MouseEvent):void
         {
            if(ActorSession.loggedInActor.isVip)
            {
               open();
            }
            else
            {
               VIPOnlyPopUp.Show(MSPLocaleManagerWeb.getInstance().getString("MESSAGING_COLOR_VIPONLY"),WindowStack.Z_PROMPT);
            }
         };
         anywhereClicked = function(param1:MouseEvent):void
         {
            if(param1.target != fontcolorSelector && param1.target != inputArea.fontColorButton)
            {
               close();
            }
         };
         var close:Function = function():void
         {
            if(window.contains(emoticonContainer))
            {
               if(window is UIComponent)
               {
                  window.removeChild(emoticonContainer.parent);
               }
               else
               {
                  window.removeChild(emoticonContainer);
               }
            }
         };
         var open:Function = function():void
         {
            var _loc4_:UIComponent = null;
            var _loc1_:Point = window.globalToLocal(new Point(window.stage.mouseX,window.stage.mouseY));
            var _loc2_:Number = Number(emoticonContainer.width);
            var _loc3_:Number = Number(emoticonContainer.height);
            if(window is UIComponent)
            {
               _loc4_ = new UIComponent();
               _loc4_.addChild(emoticonContainer);
               window.addChild(_loc4_);
            }
            else
            {
               window.addChild(emoticonContainer);
            }
            PopupUtils.positionInQuadrant(emoticonContainer,window,_loc1_.x,_loc1_.y,quadrant);
            emoticonContainer.width = 0;
            emoticonContainer.height = 0;
            TweenLite.to(emoticonContainer,0.3,{
               "width":_loc2_,
               "height":_loc3_
            });
         };
         colorSelected = function(param1:FontColorSelectorEvent):void
         {
            colorSelectedFunction(param1.color);
            close();
         };
         window = Main.Instance.mainCanvas;
         emoticonContainer = new MessagingEmoticonContainer();
         fontcolorSelector = new FontColorSelector(rows,size);
         emoticonContainer.addChild(fontcolorSelector);
         if(Boolean(window.parent) && Boolean(window.stage))
         {
            addedToStage(null);
         }
         else
         {
            window.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
         }
      }
      
      public static function addTabbingFunctionality(param1:Array, param2:int, param3:Stage) : void
      {
         removeTabbingFunctionality();
         tabbingStage = param3;
         tabArray = param1;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] as DisplayObject != null)
            {
               (param1[_loc4_] as DisplayObject).addEventListener(KeyboardEvent.KEY_DOWN,onKey);
            }
            _loc4_++;
         }
      }
      
      private static function onKey(param1:KeyboardEvent) : void
      {
         var timerComplete:Function;
         var index:int = 0;
         var timer:Timer = null;
         var e:KeyboardEvent = param1;
         if(e.keyCode == 9)
         {
            timerComplete = function(param1:TimerEvent):void
            {
               if(index + 1 >= tabArray.length)
               {
                  index = 0;
               }
               else
               {
                  ++index;
               }
               tabbingStage.focus = tabArray[index];
            };
            index = int(tabArray.indexOf(e.target));
            timer = new Timer(100,1);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
            timer.start();
         }
      }
      
      public static function removeTabbingFunctionality() : void
      {
         var _loc1_:int = 0;
         tabbingStage = null;
         if(tabArray != null)
         {
            _loc1_ = 0;
            while(_loc1_ < tabArray.length)
            {
               if(tabArray[_loc1_] as DisplayObject != null)
               {
                  (tabArray[_loc1_] as DisplayObject).removeEventListener(KeyboardEvent.KEY_DOWN,onKey);
               }
               _loc1_++;
            }
         }
      }
   }
}

