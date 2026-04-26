package com.moviestarplanet.Forms
{
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.configurations.Config;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import mx.containers.TitleWindow;
   import mx.controls.TextArea;
   import mx.managers.CursorManager;
   
   public class ResizableTitleWindow extends TitleWindow
   {
      
      private static var CURSOR_CLASS:Class = ResizableTitleWindow_CURSOR_CLASS;
      
      private static var CURSOR_X_OFFSET:Number = -5;
      
      private static var CURSOR_Y_OFFSET:Number = -5;
      
      private static const closeSkin:Class = ResizableTitleWindow_closeSkin;
      
      public var resizeHandleSize:int = 10;
      
      public var allowResizing:Boolean = true;
      
      private var m_dragStartMouseX:Number;
      
      private var m_dragStartMouseY:Number;
      
      private var m_resizeHandle:Loader;
      
      private var m_startHeight:Number;
      
      private var m_startWidth:Number;
      
      private var area:TextArea;
      
      private var savedScrollPos:Number;
      
      private var closeButton:CloseButton;
      
      public function ResizableTitleWindow()
      {
         super();
         this.setStyle("closeButtonOverSkin",closeSkin);
         this.setStyle("closeButtonDownSkin",closeSkin);
         this.setStyle("closeButtonSkin",closeSkin);
         this.setStyle("closeButtonUpSkin",closeSkin);
      }
      
      override protected function createChildren() : void
      {
         var imgurl:URLRequest;
         var loadComplete:Function = null;
         loadComplete = function(param1:Event):void
         {
            rawChildren.addChild(m_resizeHandle);
            invalidateDisplayList();
         };
         super.createChildren();
         this.closeButton = new CloseButton();
         this.closeButton.addEventListener(MouseEvent.CLICK,this.close);
         this.closeButton.y = 3;
         this.closeButton.height = this.closeButton.width = 18;
         titleBar.addChild(this.closeButton);
         this.m_resizeHandle = new Loader();
         imgurl = new URLRequest(Config.toAbsoluteURL("img/Icons/Resize_icon.png",Config.LOCAL_CDN_URL));
         this.m_resizeHandle.load(imgurl);
         this.m_resizeHandle.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
         this.m_resizeHandle.width = this.resizeHandleSize;
         this.m_resizeHandle.height = this.resizeHandleSize;
         this.m_resizeHandle.alpha = 1;
         this.m_resizeHandle.addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler,false,0,true);
         this.m_resizeHandle.addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler,false,0,true);
         this.m_resizeHandle.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler,false,0,true);
         this.m_resizeHandle.visible = this.allowResizing;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         if(this.m_resizeHandle != null)
         {
            this.m_resizeHandle.x = this.unscaledWidth - this.resizeHandleSize * 1.3;
            this.m_resizeHandle.y = this.unscaledHeight - this.resizeHandleSize * 1.3;
            this.m_resizeHandle.width = this.m_resizeHandle.height = this.resizeHandleSize;
         }
         this.adjust();
      }
      
      private function adjust() : void
      {
         this.closeButton.x = titleBar.width - 20;
      }
      
      public function close(param1:Event = null) : void
      {
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         var _loc2_:Number = parent.mouseX - this.m_dragStartMouseX;
         var _loc3_:Number = parent.mouseY - this.m_dragStartMouseY;
         if(parent.mouseX < parent.width && parent.mouseY < parent.height)
         {
            this.width = Math.max(this.m_startWidth + _loc2_,minWidth);
            this.height = Math.max(this.m_startHeight + _loc3_,minHeight);
         }
         if(this.area != null)
         {
            this.area.verticalScrollPosition = this.savedScrollPos;
         }
      }
      
      public function setTextArea(param1:TextArea) : void
      {
         this.area = param1;
      }
      
      private function mouseDownHandler(param1:MouseEvent) : void
      {
         if(this.area != null)
         {
            this.savedScrollPos = this.area.verticalScrollPosition;
         }
         this.setCursor();
         this.m_dragStartMouseX = parent.mouseX;
         this.m_dragStartMouseY = parent.mouseY;
         this.m_startWidth = this.width;
         this.m_startHeight = this.height;
         systemManager.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler,false,0,true);
         systemManager.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler,false,0,true);
         systemManager.stage.addEventListener(Event.MOUSE_LEAVE,this.mouseLeaveHandler,false,0,true);
      }
      
      private function mouseLeaveHandler(param1:Event) : void
      {
         this.mouseUpHandler();
         systemManager.stage.removeEventListener(Event.MOUSE_LEAVE,this.mouseLeaveHandler);
      }
      
      private function mouseUpHandler(param1:MouseEvent = null) : void
      {
         systemManager.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         systemManager.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         systemManager.stage.removeEventListener(Event.MOUSE_LEAVE,this.mouseLeaveHandler);
         CursorManager.removeCursor(CursorManager.currentCursorID);
      }
      
      private function rollOutHandler(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            CursorManager.removeCursor(CursorManager.currentCursorID);
         }
      }
      
      private function rollOverHandler(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            this.setCursor();
         }
      }
      
      private function setCursor() : void
      {
         CursorManager.removeCursor(CursorManager.currentCursorID);
         CursorManager.setCursor(CURSOR_CLASS,2,CURSOR_X_OFFSET,CURSOR_Y_OFFSET);
      }
   }
}

