package com.moviestarplanet.Components.Friends
{
   import com.moviestarplanet.Forms.ResizableTitleWindow;
   import com.moviestarplanet.managers.MSP_CursorManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import com.moviestarplanet.window.utils.PopupUtils;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class MyOnlineFriends extends ResizableTitleWindow implements WindowStackableInterface
   {
      
      private var _1399907075component:MyOnlineFriendsComponent;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":ResizableTitleWindow,
         "events":{"creationComplete":"___MyOnlineFriends_ResizableTitleWindow1_creationComplete"},
         "stylesFactory":function():void
         {
            this.borderStyle = "solid";
            this.roundedBottomCorners = true;
            this.cornerRadius = 10;
            this.borderThickness = 2;
            this.borderThicknessBottom = 0;
            this.borderThicknessLeft = 0;
            this.borderThicknessRight = 0;
            this.paddingLeft = 0;
            this.paddingRight = 0;
            this.paddingBottom = 0;
            this.paddingTop = 0;
            this.backgroundAlpha = 0.9;
            this.backgroundColor = 0;
            this.horizontalAlign = "center";
         },
         "propertiesFactory":function():Object
         {
            return {"childDescriptors":[new UIComponentDescriptor({
               "type":MyOnlineFriendsComponent,
               "id":"component",
               "propertiesFactory":function():Object
               {
                  return {
                     "percentWidth":100,
                     "percentHeight":100
                  };
               }
            })]};
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var useMoveCursor:Boolean = true;
      
      public function MyOnlineFriends()
      {
         super();
         mx_internal::_document = this;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.showCloseButton = false;
         this.minWidth = 200;
         this.minHeight = 320;
         this.addEventListener("creationComplete",this.___MyOnlineFriends_ResizableTitleWindow1_creationComplete);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.borderStyle = "solid";
            this.roundedBottomCorners = true;
            this.cornerRadius = 10;
            this.borderThickness = 2;
            this.borderThicknessBottom = 0;
            this.borderThicknessLeft = 0;
            this.borderThicknessRight = 0;
            this.paddingLeft = 0;
            this.paddingRight = 0;
            this.paddingBottom = 0;
            this.paddingTop = 0;
            this.backgroundAlpha = 0.9;
            this.backgroundColor = 0;
            this.horizontalAlign = "center";
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      protected function creationCompleteHandler() : void
      {
         title = MSPLocaleManagerWeb.getInstance().getString("MY_ONLINE_FRIENDS");
         titleBar.buttonMode = true;
         titleBar.useHandCursor = true;
         if(this.useMoveCursor)
         {
            titleTextField.addEventListener(MouseEvent.ROLL_OVER,this.setMoveCursor);
            titleTextField.addEventListener(MouseEvent.ROLL_OUT,this.setNormalCursor);
         }
      }
      
      private function setMoveCursor(param1:MouseEvent) : void
      {
         MSP_CursorManager.setMoveCursor();
      }
      
      private function setNormalCursor(param1:MouseEvent) : void
      {
         MSP_CursorManager.setNormalCursor();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
      }
      
      override public function close(param1:Event = null) : void
      {
         PopupUtils.removePopup(this,null,this.parent);
         WindowStack.removeViewStackable(this);
      }
      
      public function ___MyOnlineFriends_ResizableTitleWindow1_creationComplete(param1:FlexEvent) : void
      {
         this.creationCompleteHandler();
      }
      
      [Bindable(event="propertyChange")]
      public function get component() : MyOnlineFriendsComponent
      {
         return this._1399907075component;
      }
      
      public function set component(param1:MyOnlineFriendsComponent) : void
      {
         var _loc2_:Object = this._1399907075component;
         if(_loc2_ !== param1)
         {
            this._1399907075component = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"component",_loc2_,param1));
            }
         }
      }
   }
}

