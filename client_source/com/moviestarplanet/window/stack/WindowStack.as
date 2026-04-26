package com.moviestarplanet.window.stack
{
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.window.base.AbstractWindow;
   import com.moviestarplanet.window.base.WindowLayers;
   import com.moviestarplanet.window.event.WindowEvent;
   import com.moviestarplanet.window.loading.LoadingBar;
   import com.moviestarplanet.window.utils.MovieClipStateManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getQualifiedClassName;
   import mx.core.Container;
   import mx.core.FlexSprite;
   import mx.effects.Blur;
   import mx.events.EffectEvent;
   
   public class WindowStack extends EventDispatcher
   {
      
      public static var _container:Container;
      
      public static var defaultCloseButtonClass:Class;
      
      public static var tweenerClass:Class;
      
      private static var _windowStack:WindowStack;
      
      public static const Z_ROOM:int = WindowLayers.ROOM;
      
      public static const Z_BROWSER:int = WindowLayers.BROWSER;
      
      public static const Z_CONTENT:int = WindowLayers.CONTENT;
      
      public static const Z_INFO:int = WindowLayers.INFO;
      
      public static const Z_FRIENDACTIVITY:int = WindowLayers.FRIENDACTIVITY;
      
      public static const Z_YOUTUBE:int = WindowLayers.YOUTUBE;
      
      public static const Z_MSPOPUP:int = WindowLayers.MSPOPUP;
      
      public static const Z_ARCADE:int = WindowLayers.ARCADE;
      
      public static const Z_CHATBOX:int = WindowLayers.CHATBOX;
      
      public static const Z_NOTICE:int = WindowLayers.NOTICE;
      
      public static const Z_PROMPT:int = WindowLayers.PROMPT;
      
      public static const VIEWSTACK_CLEARED:String = "VIEWSTACK_CLEARED";
      
      private static const STACKABLE_OPENING_STARTED:String = "STACKABLE_OPENING_STARTED";
      
      private static const STACKABLE_OPENING_ENDED:String = "STACKABLE_OPENING_ENDED";
      
      private static const BLUR_STRENGTH:int = 5;
      
      private static const BLUR_DURATION:int = 300;
      
      private static const NO_CLASS:String = "na";
      
      private static var currentShownClass:String = NO_CLASS;
      
      private const zIndices:Dictionary;
      
      public const openWindows:Array;
      
      private var showingIsLocked:Boolean = false;
      
      private var currentStackable:WindowStackableInterface;
      
      private var animation:WindowStackAnimation;
      
      private var blurIn:Blur;
      
      private var blurOut:Blur;
      
      private var fadeCompleteCallback:Function;
      
      private var statemanagers:Dictionary;
      
      private const loadingBar:LoadingBar;
      
      public function WindowStack(param1:Function = null)
      {
         var iBlurInComplete:Function = null;
         var iOpenEnded:Function = null;
         var iOpenStarted:Function = null;
         var caller:Function = param1;
         this.zIndices = new Dictionary(true);
         this.openWindows = new Array();
         this.loadingBar = new LoadingBar();
         super();
         iBlurInComplete = function():void
         {
            if(fadeCompleteCallback != null)
            {
               fadeCompleteCallback();
            }
         };
         iOpenEnded = function():void
         {
            showingIsLocked = false;
         };
         iOpenStarted = function():void
         {
            showingIsLocked = true;
         };
         if(caller != singletonPreventer)
         {
            throw new Error("Creation of Singleton is not valid");
         }
         this.statemanagers = new Dictionary(true);
         this.blurIn = new Blur();
         this.blurIn.blurXFrom = 0;
         this.blurIn.blurXTo = BLUR_STRENGTH;
         this.blurIn.blurYFrom = 0;
         this.blurIn.blurYTo = BLUR_STRENGTH;
         this.blurIn.duration = BLUR_DURATION;
         this.blurIn.addEventListener(EffectEvent.EFFECT_END,iBlurInComplete);
         this.blurOut = new Blur();
         this.blurOut.blurXFrom = BLUR_STRENGTH;
         this.blurOut.blurXTo = 0;
         this.blurOut.blurYFrom = BLUR_STRENGTH;
         this.blurOut.blurYTo = 0;
         this.blurOut.duration = BLUR_DURATION;
         addEventListener(STACKABLE_OPENING_STARTED,iOpenStarted);
         addEventListener(STACKABLE_OPENING_ENDED,iOpenEnded);
      }
      
      public static function set container(param1:Container) : void
      {
         _container = param1;
         windowStack.animation = new WindowStackAnimation();
         windowStack.animation.setContainer(param1);
      }
      
      public static function get container() : Container
      {
         return _container;
      }
      
      private static function singletonPreventer() : void
      {
      }
      
      public static function get windowStack() : WindowStack
      {
         if(_windowStack == null)
         {
            _windowStack = new WindowStack(singletonPreventer);
         }
         return _windowStack;
      }
      
      public static function getCurrentShownClass() : String
      {
         return currentShownClass;
      }
      
      public static function clearViewStack() : void
      {
         windowStack.iClearViewStack();
      }
      
      public static function clearAllViews() : void
      {
         windowStack.iClearAllViews();
      }
      
      public static function contains(param1:WindowStackableInterface) : Boolean
      {
         return windowStack.isInStack(param1);
      }
      
      public static function containsSprite(param1:Sprite) : Boolean
      {
         return windowStack.isSpriteInStack(param1);
      }
      
      public static function showChildWindow(param1:DisplayObjectContainer, param2:int, param3:int, param4:DisplayObjectContainer) : void
      {
         var parentClosed:Function = null;
         var window:DisplayObjectContainer = param1;
         var x:int = param2;
         var y:int = param3;
         var parent:DisplayObjectContainer = param4;
         parentClosed = function(param1:Event = null):void
         {
            windowStack.close(window);
         };
         var z:int = getZIndex(parent) + 1;
         if(window is WindowStackableInterface)
         {
            showViewStackable(window as WindowStackableInterface,x,y,z);
         }
         else
         {
            showSpriteAsViewStackable(window as Sprite,x,y,z);
         }
         parent.addEventListener(Event.REMOVED_FROM_STAGE,parentClosed);
      }
      
      public static function showViewStackable(param1:WindowStackableInterface, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:WindowStackableContainer = null;
         if(param1 != null)
         {
            _loc5_ = param1 as WindowStackableContainer;
            if(_loc5_ != null)
            {
               currentShownClass = getQualifiedClassName(_loc5_.window) as String;
            }
            else
            {
               currentShownClass = getQualifiedClassName(param1) as String;
            }
         }
         windowStack.iShowViewStackable(param1,param2,param3,param4);
      }
      
      public static function getAllWindowsAt(param1:int) : Vector.<WindowStackableInterface>
      {
         var _loc3_:WindowStackableInterface = null;
         var _loc2_:Vector.<WindowStackableInterface> = new Vector.<WindowStackableInterface>();
         for each(_loc3_ in windowStack.openWindows)
         {
            if(windowStack.zIndices[_loc3_] == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function removeViewStackable(param1:WindowStackableInterface) : void
      {
         currentShownClass = NO_CLASS;
         windowStack.iRemoveViewStackable(param1);
      }
      
      public static function showSpriteAsViewStackable(param1:Sprite, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:WindowStackableContainer = new WindowStackableContainer(param1);
         showViewStackable(_loc5_,param2,param3,param4);
      }
      
      public static function showSpriteAsViewStackableWithCloseButton(param1:Sprite, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:WindowStackableContainer = new WindowStackableContainer(param1);
         _loc7_.width = param4;
         _loc7_.height = param5;
         _loc7_.horizontalScrollPolicy = "off";
         _loc7_.verticalScrollPolicy = "off";
         _loc7_.clipContent = false;
         var _loc8_:Sprite = new defaultCloseButtonClass();
         _loc8_.addEventListener(MouseEvent.CLICK,_loc7_.closeHandler);
         _loc7_.addChild(_loc8_);
         _loc8_.x = param4 - 30;
         _loc8_.y = 5;
         showViewStackable(_loc7_,param2,param3,param6);
      }
      
      public static function removeSpriteViewStackable(param1:Sprite) : void
      {
         param1.dispatchEvent(new Event(Event.CLOSE));
         windowStack.dispatchEvent(new Event(Event.CLOSE));
      }
      
      private static function getZIndex(param1:Object) : int
      {
         while(windowStack.zIndices[param1] == null && param1.parent != null)
         {
            param1 = param1.parent;
         }
         var _loc2_:Object = windowStack.zIndices[param1];
         if(_loc2_)
         {
            return int(_loc2_);
         }
         return Z_INFO;
      }
      
      public static function getWindowByType(param1:String) : DisplayObject
      {
         var _loc3_:Object = null;
         var _loc4_:DisplayObjectContainer = null;
         var _loc2_:String = "";
         for each(_loc3_ in windowStack.openWindows)
         {
            if((_loc3_ as DisplayObjectContainer).name == param1)
            {
               return _loc3_ as DisplayObject;
            }
            if(_loc3_.numChildren > 0)
            {
               _loc4_ = _loc3_.getChildAt(0) as DisplayObjectContainer;
               if(_loc4_.numChildren > 0)
               {
                  _loc2_ = getQualifiedClassName(_loc4_.getChildAt(0));
                  if(_loc2_ == param1)
                  {
                     return _loc3_ as DisplayObject;
                  }
               }
            }
         }
         return null;
      }
      
      public static function getStage() : Stage
      {
         return _container.stage;
      }
      
      public static function closeAllWindows() : void
      {
         throw new Error("closeAllWindows() is not implemented!");
      }
      
      public function getStacks() : Vector.<Object>
      {
         return Vector.<Object>(this.openWindows);
      }
      
      private function showStackable(param1:WindowStackableInterface, param2:int, param3:int) : void
      {
         var iOpenComplete:Function = null;
         var testGraphicsDone:Function = null;
         var statemanager:MovieClipStateManager = null;
         var stackable:WindowStackableInterface = param1;
         var x:int = param2;
         var y:int = param3;
         var beginWindowAnimation:Function = function():void
         {
            if(stackable != null)
            {
               currentStackable = stackable;
               iOpenComponent(currentStackable as DisplayObjectContainer);
            }
         };
         var iOpenComponent:Function = function(param1:DisplayObjectContainer):void
         {
            if(currentStackable is DisplayObject)
            {
               animation.open(currentStackable as DisplayObject,x,y,iOpenComplete);
               pushDownToZIndex();
            }
         };
         iOpenComplete = function():void
         {
            dispatchEvent(new Event(STACKABLE_OPENING_ENDED));
         };
         var waitForGraphics:Function = function():void
         {
            var _loc1_:Timer = new Timer(200,20);
            _loc1_.addEventListener(TimerEvent.TIMER,testGraphicsDone);
            _loc1_.start();
         };
         testGraphicsDone = function(param1:Event):void
         {
            if(Boolean(hasGraphics(stackable as DisplayObject)) || param1.target.currentCount >= param1.target.repeatCount)
            {
               loadingBar.hide();
               param1.target.stop();
               if(param1.target.currentCount < param1.target.repeatCount)
               {
                  windowStack.dispatchEvent(new WindowEvent(WindowEvent.GRAPHICS_DONE,stackable as DisplayObjectContainer));
               }
            }
         };
         var hasGraphics:Function = function(param1:DisplayObject):Boolean
         {
            var _loc2_:int = 0;
            if((param1 is MovieClip || param1 is FlexSprite) && param1.width > 0 && param1.height > 0)
            {
               return true;
            }
            if(param1 is DisplayObjectContainer)
            {
               _loc2_ = 0;
               while(_loc2_ < DisplayObjectContainer(param1).numChildren)
               {
                  if(Boolean(hasGraphics(DisplayObjectContainer(param1).getChildAt(_loc2_))))
                  {
                     return true;
                  }
                  _loc2_++;
               }
            }
            return false;
         };
         var pushDownToZIndex:Function = function():void
         {
            var _loc2_:DisplayObject = null;
            var _loc3_:int = 0;
            var _loc1_:DisplayObject = null;
            for each(_loc2_ in openWindows)
            {
               if(getZIndex(_loc2_) > getZIndex(stackable))
               {
                  if(_loc1_ == null || getZIndex(_loc2_) < getZIndex(_loc1_))
                  {
                     _loc1_ = _loc2_;
                  }
               }
            }
            if(_loc1_)
            {
               _loc3_ = container.getChildIndex(_loc1_);
               container.setChildIndex(stackable as DisplayObject,_loc3_);
            }
         };
         if(this.currentStackable != null && !this.isFloating(stackable) && !this.isFloating(this.currentStackable) && getZIndex(this.currentStackable) != Z_PROMPT && getZIndex(this.currentStackable) != Z_NOTICE)
         {
            statemanager = new MovieClipStateManager(this.currentStackable as DisplayObject);
            statemanager.stop();
            this.statemanagers[this.currentStackable] = statemanager;
            if(this.currentStackable is WindowStackableUnmodalizableInterface == false)
            {
               this.setEnabled(this.currentStackable as DisplayObjectContainer,false);
            }
         }
         beginWindowAnimation();
         waitForGraphics();
         if(!stackable is AbstractWindow)
         {
            this.loadingBar.show();
         }
         this.setEnabled(stackable as DisplayObjectContainer,true);
      }
      
      private function isFloating(param1:Object) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc2_:int = getZIndex(param1);
         _loc3_ = param1 is WindowFloatingInterface || param1 is WindowStackableContainer && param1.window is WindowFloatingInterface;
         return _loc2_ == Z_CHATBOX || _loc2_ == Z_YOUTUBE || _loc2_ == Z_MSPOPUP || _loc2_ == Z_ARCADE || _loc3_;
      }
      
      private function isInStack(param1:Object) : Boolean
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.openWindows)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isSpriteInStack(param1:Sprite) : Boolean
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.openWindows)
         {
            if(_loc2_ is WindowStackableContainer)
            {
               if(WindowStackableContainer(_loc2_).window == param1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function iShowViewStackable(param1:WindowStackableInterface, param2:int, param3:int, param4:int) : void
      {
         if(this.showingIsLocked == false)
         {
            if(contains(param1))
            {
               this.closeHigherWindowsThatAreNotPopups(param4 + 1);
               return;
            }
            this.closeHigherWindowsThatAreNotPopups(param4);
            dispatchEvent(new Event(STACKABLE_OPENING_STARTED));
            this.openWindows.push(param1);
            this.zIndices[param1] = param4;
            this.showStackable(param1,param2,param3);
            this.enteringAnalyticsEvent(param1);
         }
      }
      
      private function iRemoveViewStackable(param1:WindowStackableInterface) : void
      {
         var _loc3_:MovieClipStateManager = null;
         var _loc2_:int = int(this.openWindows.indexOf(param1));
         if(_loc2_ >= 0)
         {
            this.openWindows.splice(_loc2_,1);
            if(container.contains(param1 as DisplayObject))
            {
               container.removeChild(DisplayObject(param1));
            }
            delete this.zIndices[param1];
            this.setCurrentStackableToTopWindow();
            _loc3_ = this.statemanagers[this.currentStackable] as MovieClipStateManager;
            if(_loc3_ != null)
            {
               _loc3_.reset();
               delete this.statemanagers[this.currentStackable];
            }
            if(this.currentStackable != null)
            {
               this.setEnabled(this.currentStackable as DisplayObjectContainer,true);
            }
         }
         this.leavingAnalyticsEvent(param1);
      }
      
      private function setCurrentStackableToTopWindow() : void
      {
         var _loc1_:int = this.openWindows.length - 1;
         var _loc2_:* = int(_loc1_ - 1);
         while(_loc2_ >= 0)
         {
            if(!this.isFloating(this.openWindows[_loc2_]) && getZIndex(this.openWindows[_loc2_]) > getZIndex(this.openWindows[_loc1_]))
            {
               _loc1_ = _loc2_;
            }
            _loc2_--;
         }
         if(this.openWindows[_loc1_] is WindowStackableInterface == false)
         {
            this.currentStackable = null;
         }
         else
         {
            this.currentStackable = this.openWindows[_loc1_];
         }
      }
      
      private function iClearViewStack() : void
      {
         var _loc1_:* = int(this.openWindows.length - 1);
         while(_loc1_ >= 0)
         {
            if(!this.isFloating(this.openWindows[_loc1_]))
            {
               this.close(this.openWindows[_loc1_]);
            }
            _loc1_--;
         }
         container.dispatchEvent(new Event(VIEWSTACK_CLEARED));
      }
      
      private function iClearAllViews() : void
      {
         var _loc1_:* = int(this.openWindows.length - 1);
         while(_loc1_ >= 0)
         {
            this.close(this.openWindows[_loc1_]);
            _loc1_--;
         }
         container.dispatchEvent(new Event(VIEWSTACK_CLEARED));
      }
      
      private function closeHigherWindowsThatAreNotPopups(param1:int) : void
      {
         var _loc3_:* = 0;
         var _loc2_:Boolean = param1 > Z_INFO;
         if(!_loc2_)
         {
            _loc3_ = int(this.openWindows.length - 1);
            while(_loc3_ >= 0)
            {
               if(this.zIndices[this.openWindows[_loc3_]] >= param1 && !this.isFloating(this.openWindows[_loc3_]) && this.zIndices[this.openWindows[_loc3_]] != Z_PROMPT && this.zIndices[this.openWindows[_loc3_]] != Z_NOTICE)
               {
                  this.close(this.openWindows[_loc3_]);
               }
               _loc3_--;
            }
         }
      }
      
      private function close(param1:DisplayObjectContainer) : void
      {
         var _loc2_:Boolean = false;
         if(param1 is WindowStackableEditorInterface)
         {
            WindowStackableEditorInterface(param1).requestClose();
            return;
         }
         if(param1 is WindowStackableInterface)
         {
            this.iRemoveViewStackable(param1 as WindowStackableInterface);
         }
         else if(param1 != null && Boolean(param1.hasOwnProperty("parent")) && param1.parent != null)
         {
            param1.parent.removeChild(param1);
            _loc2_ = true;
         }
         var _loc3_:* = int(this.openWindows.length - 1);
         while(_loc3_ >= 0)
         {
            if(this.openWindows[_loc3_] == param1)
            {
               this.openWindows.splice(_loc3_,1);
            }
            _loc3_--;
         }
         delete this.zIndices[param1];
         if(_loc2_)
         {
            this.leavingAnalyticsEvent(param1);
         }
      }
      
      private function setEnabled(param1:DisplayObjectContainer, param2:Boolean) : void
      {
         param1.mouseChildren = param1.mouseEnabled = param2;
         if(param2)
         {
            (tweenerClass as Object).to(param1,0.4,{"colorMatrixFilter":{}});
         }
         else
         {
            (tweenerClass as Object).to(param1,0.4,{"colorMatrixFilter":{
               "colorize":0,
               "amount":0.5
            }});
         }
      }
      
      private function enteringAnalyticsEvent(param1:Object) : void
      {
         MessageCommunicator.sendMessage(WindowEvent.WINDOW_OPENING,param1);
      }
      
      private function leavingAnalyticsEvent(param1:Object) : void
      {
         MessageCommunicator.sendMessage(WindowEvent.WINDOW_CLOSING,param1);
      }
   }
}

