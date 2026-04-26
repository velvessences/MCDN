package com.moviestarplanet.windowpopup.popup
{
   import com.moviestarplanet.controls.utils.Buttonizer;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.flash.components.buttons.ButtonWithFrames;
   import com.moviestarplanet.utils.ClickBlocker;
   import com.moviestarplanet.utils.ObjectUtilities;
   import com.moviestarplanet.utils.flash.MSP_FlashLoader;
   import com.moviestarplanet.window.IPreventAspectRatioChange;
   import com.moviestarplanet.window.base.WindowLayers;
   import com.moviestarplanet.window.event.WindowEvent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class Prompt extends BaseSwfPopup implements IPreventAspectRatioChange
   {
      
      public static const YES:uint = 1;
      
      public static const NO:uint = 2;
      
      public static const OK:uint = 4;
      
      public static const CANCEL:uint = 8;
      
      public static const BLOCKING:uint = 16;
      
      public static const CLOSE:uint = 17;
      
      public static var embedFonts:Boolean = true;
      
      protected var text:String;
      
      protected var title:String;
      
      protected var flags:uint;
      
      protected var closeHandler:Function;
      
      protected var buttonCallback:Function;
      
      protected var defaultButtonFlag:uint;
      
      private var buttonsWithFrames:Array = new Array();
      
      private const MIN_SHOW_TIME:int = 250;
      
      private var blocker:Sprite;
      
      protected var clickBlocker:ClickBlocker;
      
      private var onClickBlockerClicked:Function;
      
      private var blockerVisibilityValue:Boolean = true;
      
      private var preventAspectRatioChange:Boolean;
      
      public function Prompt(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4, param8:String = "swf/popups/NeutralMessagePopUp.swf", param9:Function = null, param10:Function = null, param11:Boolean = false)
      {
         super(param8);
         this.text = param1;
         this.title = param2;
         this.flags = param3;
         this.closeHandler = param5;
         this.buttonCallback = param10;
         this.defaultButtonFlag = param7;
         this.onClickBlockerClicked = param9;
         this.preventAspectRatioChange = param11;
         this.focusRect = false;
      }
      
      public static function show(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4, param8:Function = null) : Prompt
      {
         return new Prompt(param1,param2,param3,param4,param5,param6,param7,"swf/popups/NeutralMessagePopUp.swf",null,param8);
      }
      
      public static function showFriendly(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4, param8:Function = null) : void
      {
         var callback:Function = null;
         var text:String = param1;
         var title:String = param2;
         var flags:uint = param3;
         var popupParent:Sprite = param4;
         var closeHandler:Function = param5;
         var iconClass:Class = param6;
         var defaultButtonFlag:uint = param7;
         var buttonClickCallback:Function = param8;
         callback = function(param1:String):void
         {
            doShowFriendly(text,title,flags,popupParent,closeHandler,iconClass,defaultButtonFlag,buttonClickCallback,param1);
         };
         new SwfCreater().findSwf(callback);
      }
      
      public static function showEvil(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4, param8:Function = null) : Prompt
      {
         var prompt:Prompt = null;
         var promptRemovedFromStage:Function = null;
         var text:String = param1;
         var title:String = param2;
         var flags:uint = param3;
         var popupParent:Sprite = param4;
         var closeHandler:Function = param5;
         var iconClass:Class = param6;
         var defaultButtonFlag:uint = param7;
         var buttonClickCallback:Function = param8;
         promptRemovedFromStage = function(param1:Object):void
         {
            prompt.removeEventListener(Event.REMOVED_FROM_STAGE,promptRemovedFromStage);
            if(closeHandler != null)
            {
               closeHandler();
            }
         };
         prompt = new Prompt(text,title,flags,popupParent,closeHandler,iconClass,defaultButtonFlag,"swf/popups/EvilBonieMessagePopUp.swf",null,buttonClickCallback);
         prompt.addEventListener(Event.REMOVED_FROM_STAGE,promptRemovedFromStage);
         return prompt;
      }
      
      public static function showCombat(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4, param8:Function = null, param9:Function = null, param10:Boolean = true, param11:Boolean = true) : Prompt
      {
         var _loc12_:String = param10 ? "swf/popups/CombatPopup.swf" : "swf/popups/CombatPopupNoAnchor.swf";
         return new Prompt(param1,param2,param3,param4,param5,param6,param7,_loc12_,param8,param9,param11);
      }
      
      public static function doShowFriendly(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4, param8:Function = null, param9:String = "swf/popups/PositivMessagePopUp.swf") : Prompt
      {
         var prompt:Prompt = null;
         var promptRemovedFromStage:Function = null;
         var text:String = param1;
         var title:String = param2;
         var flags:uint = param3;
         var popupParent:Sprite = param4;
         var closeHandler:Function = param5;
         var iconClass:Class = param6;
         var defaultButtonFlag:uint = param7;
         var buttonClickCallback:Function = param8;
         var swf:String = param9;
         promptRemovedFromStage = function(param1:Object):void
         {
            prompt.removeEventListener(Event.REMOVED_FROM_STAGE,promptRemovedFromStage);
            if(closeHandler != null)
            {
               closeHandler(new PromptEvent(PromptEvent.CLOSE,false,false,flags));
            }
         };
         prompt = new Prompt(text,title,flags,popupParent,closeHandler,iconClass,defaultButtonFlag,swf,null,buttonClickCallback);
         prompt.addEventListener(Event.REMOVED_FROM_STAGE,promptRemovedFromStage);
         return prompt;
      }
      
      public function isBlockerShowing() : Boolean
      {
         return this.blocker != null;
      }
      
      override protected function loadDone(param1:MSP_FlashLoader) : void
      {
         var movieClipContent:MovieClip;
         var textfield:TextField;
         var buttons:Array;
         var visibleButtons:Array;
         var totalWidth:int;
         var button:MovieClip = null;
         var totalFreeSpace:int = 0;
         var margin:int = 0;
         var currentXPosition:int = 0;
         var button2:MovieClip = null;
         var i:int = 0;
         var childOfInterest:DisplayObject = null;
         var loader:MSP_FlashLoader = param1;
         if(this.flags & BLOCKING)
         {
            MessageCommunicator.subscribe(WindowEvent.WINDOW_OPENED,this.onWindowOpened);
         }
         super.loadDone(loader);
         movieClipContent = content as MovieClip;
         textfield = movieClipContent.SystemMessage.Body;
         ObjectUtilities.traverseObject(movieClipContent,ObjectUtilities.traverserDisplayObject,this.stopMC);
         movieClipContent.SystemMessage.Title.text = this.title || "";
         movieClipContent.SystemMessage.Body.text = this.text || "";
         if(!embedFonts)
         {
            this.setToNotEmbed(movieClipContent.SystemMessage);
         }
         this.increaseBodyTextIfTooSmall(textfield);
         this.resizeTextFieldIfTooBig(movieClipContent,movieClipContent.SystemMessage.Title,2,45,true);
         this.resizeTextFieldIfTooBig(movieClipContent,movieClipContent.SystemMessage.Body,6,13);
         if(movieClipContent.SystemMessage.CloseButton)
         {
            Buttonizer.buttonize(movieClipContent.SystemMessage.CloseButton,this.closeButtonClicked,false);
         }
         this.hideOrButtonizeButtons(movieClipContent.SystemMessage.YesButton,Prompt.YES,this.buttonCallback);
         this.hideOrButtonizeButtons(movieClipContent.SystemMessage.NoButton,Prompt.NO,this.buttonCallback);
         this.hideOrButtonizeButtons(movieClipContent.SystemMessage.OkButton,Prompt.OK,this.buttonCallback);
         this.hideOrButtonizeButtons(movieClipContent.SystemMessage.CancelButton,Prompt.CANCEL,this.buttonCallback);
         buttons = new Array(movieClipContent.SystemMessage.YesButton,movieClipContent.SystemMessage.NoButton,movieClipContent.SystemMessage.OkButton,movieClipContent.SystemMessage.CancelButton);
         visibleButtons = buttons.filter(function(param1:MovieClip, param2:int, param3:Array):Boolean
         {
            return param1 ? Boolean(param1.visible) : false;
         });
         totalWidth = 0;
         for each(button in visibleButtons)
         {
            totalWidth += button.width;
         }
         totalFreeSpace = movieClipContent.SystemMessage.ButtonContainer.width - totalWidth;
         margin = totalFreeSpace / (visibleButtons.length + 1);
         currentXPosition = movieClipContent.SystemMessage.ButtonContainer.x + margin;
         for each(button2 in visibleButtons)
         {
            button2.y = movieClipContent.SystemMessage.ButtonContainer.y;
            button2.x = currentXPosition;
            currentXPosition = button2.x + button2.width + margin;
            i = 0;
            while(i < button2.numChildren)
            {
               childOfInterest = button2.getChildAt(i);
               if(childOfInterest is TextField)
               {
                  childOfInterest.y = button2.height / 2 - childOfInterest.height / 2;
               }
               i++;
            }
         }
         if(stage != null)
         {
            stage.focus = this;
         }
      }
      
      private function onWindowOpened(param1:MsgEvent) : void
      {
         MessageCommunicator.unscribe(WindowEvent.WINDOW_OPENED,this.onWindowOpened);
         if(param1.data == this)
         {
            this.activateBlocker();
         }
      }
      
      protected function activateBlocker() : void
      {
         if(this.clickBlocker == null)
         {
            this.clickBlocker = new ClickBlocker();
            this.clickBlocker.activateClickBlocker(parent);
            this.clickBlocker.setVisibility(this.blockerVisibilityValue);
         }
      }
      
      public function setBlockerVisibility(param1:Boolean) : void
      {
         this.blockerVisibilityValue = param1;
         if(this.clickBlocker != null)
         {
            this.clickBlocker.setVisibility(this.blockerVisibilityValue);
         }
      }
      
      private function closeButtonClicked(param1:MouseEvent = null) : void
      {
         this.close();
         if(this.closeHandler != null)
         {
            this.closeHandler(new PromptEvent(PromptEvent.CLOSE,false,false,CLOSE));
         }
      }
      
      override protected function close() : void
      {
         this.removeBlocker();
         super.close();
      }
      
      protected function removeBlocker() : void
      {
         if(this.clickBlocker)
         {
            this.clickBlocker.removeClickBlocker();
            this.clickBlocker = null;
            if(this.onClickBlockerClicked != null)
            {
               this.onClickBlockerClicked();
            }
         }
      }
      
      private function stopMC(param1:DisplayObject) : void
      {
         var _loc2_:MovieClip = null;
         if(param1 is MovieClip)
         {
            _loc2_ = param1 as MovieClip;
            _loc2_.stop();
         }
      }
      
      public function doPreventAspectRatioChange() : Boolean
      {
         return this.preventAspectRatioChange;
      }
      
      override protected function get contentWidth() : int
      {
         return 831;
      }
      
      override protected function get contentHeight() : int
      {
         return 352;
      }
      
      override protected function get xPos() : int
      {
         return 200;
      }
      
      override protected function show() : void
      {
         hideLoading();
         super.show();
      }
      
      override public function getZIndex() : int
      {
         return WindowLayers.PROMPT;
      }
      
      private function resizeTextFieldIfTooBig(param1:MovieClip, param2:TextField, param3:int, param4:int, param5:Boolean = false) : void
      {
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:MovieClip = null;
         if(param2.numLines > param3)
         {
            _loc6_ = (param2.numLines - param3) * param4;
            param1.SystemMessage.Background.height += _loc6_;
            param2.height += _loc6_;
            param1.SystemMessage.ButtonContainer.y += _loc6_;
            if(param5)
            {
               param1.SystemMessage.Body.y += _loc6_;
            }
            scrollRect = new Rectangle(scrollRect.x,scrollRect.y,scrollRect.width,scrollRect.height + _loc6_);
            y += -_loc6_ / 2;
            _loc7_ = param1.SytemMessage;
            _loc8_ = _loc7_ ? param1.SystemMessage.anchor : null;
            if(_loc8_ != null)
            {
               _loc9_ = param1.SystemMessage.SideHandRight1;
               _loc9_.y = param1.SystemMessage.Background.y + 67.8;
            }
         }
      }
      
      private function increaseBodyTextIfTooSmall(param1:TextField) : void
      {
         var _loc2_:TextFormat = null;
         if(param1.numLines < 3)
         {
            _loc2_ = param1.defaultTextFormat;
            _loc2_.size = int(param1.defaultTextFormat.size) + 6;
            param1.defaultTextFormat = _loc2_;
            param1.text = param1.text;
         }
      }
      
      private function hideOrButtonizeButtons(param1:MovieClip, param2:uint, param3:Function = null) : void
      {
         var buttonClickHandler:Function = null;
         var listenForEnterKey:Function = null;
         var keyPress:Function = null;
         var buttonWithFrames:ButtonWithFrames = null;
         var t:Timer = null;
         var button:MovieClip = param1;
         var correspondingFlag:uint = param2;
         var buttonClickCallback:Function = param3;
         buttonClickHandler = function(param1:MouseEvent = null):void
         {
            if(buttonClickCallback != null)
            {
               buttonClickCallback(new PromptEvent(PromptEvent.CLOSE,false,false,correspondingFlag));
            }
            else
            {
               stage.removeEventListener(KeyboardEvent.KEY_UP,keyPress);
               close();
               if(closeHandler != null)
               {
                  closeHandler(new PromptEvent(PromptEvent.CLOSE,false,false,correspondingFlag));
               }
            }
         };
         listenForEnterKey = function(param1:TimerEvent):void
         {
            if(stage)
            {
               stage.addEventListener(KeyboardEvent.KEY_UP,keyPress,false,0,true);
            }
         };
         keyPress = function(param1:KeyboardEvent):void
         {
            if(param1.keyCode == 13 && stage != null)
            {
               buttonClickHandler();
            }
         };
         if(button == null)
         {
            return;
         }
         if(this.flags & correspondingFlag)
         {
            buttonWithFrames = new ButtonWithFrames(button,buttonClickHandler,true);
            this.buttonsWithFrames.push(buttonWithFrames);
            if(!embedFonts)
            {
               this.setToNotEmbed(button);
            }
         }
         else
         {
            button.visible = false;
         }
         if(correspondingFlag == this.defaultButtonFlag)
         {
            t = new Timer(this.MIN_SHOW_TIME,1);
            t.addEventListener(TimerEvent.TIMER,listenForEnterKey);
            t.start();
         }
      }
      
      override protected function destroy() : void
      {
         var _loc1_:ButtonWithFrames = null;
         this.removeBlocker();
         super.destroy();
         for each(_loc1_ in this.buttonsWithFrames)
         {
            _loc1_.destroy();
         }
      }
      
      private function setToNotEmbed(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:TextFormat = null;
         var _loc4_:TextField = null;
         var _loc5_:int = 0;
         while(_loc5_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc5_);
            if(_loc2_ is TextField)
            {
               _loc4_ = _loc2_ as TextField;
               _loc4_.embedFonts = false;
               _loc3_ = TextField(_loc4_).defaultTextFormat;
               _loc3_.font = "Arial";
               _loc3_.size = int(_loc3_.size) * 0.8;
               _loc4_.defaultTextFormat = _loc3_;
               _loc4_.setTextFormat(_loc3_);
            }
            _loc5_++;
         }
      }
   }
}

import com.moviestarplanet.chatCommunicator.chatHelpers.chatpermission.ChatPermissionManager;
import com.moviestarplanet.injection.InjectionManager;
import com.moviestarplanet.model.IActorModel;

class SwfCreater
{
   
   [Inject]
   public var actor:IActorModel;
   
   public function SwfCreater()
   {
      super();
      InjectionManager.mapper().injectInto(this);
   }
   
   public function findSwf(param1:Function) : void
   {
      var startDateLoaded:Function = null;
      var callback:Function = param1;
      startDateLoaded = function(param1:String):void
      {
         var _loc2_:Date = actor.lastLogin;
         var _loc3_:Array = param1.split("-");
         var _loc4_:Date = new Date(_loc3_[0],_loc3_[1] - 1,_loc3_[2]);
         var _loc5_:Date = new Date(_loc3_[0],_loc3_[1] - 1,25);
         var _loc6_:String = "";
         if(_loc2_ < _loc4_ || _loc2_ > _loc5_)
         {
            _loc6_ = "swf/popups/PositivMessagePopUp.swf";
         }
         else
         {
            _loc6_ = "swf/popups/ChristmasMessagePopUp.swf";
         }
         callback(_loc6_);
      };
      ChatPermissionManager.instance.sessionService.GetAppSetting("ChristmasStartDate",startDateLoaded);
   }
}
