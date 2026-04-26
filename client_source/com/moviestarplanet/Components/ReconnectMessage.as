package com.moviestarplanet.Components
{
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
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   public class ReconnectMessage extends GradientCanvas
   {
      
      private var _544786569txtMessage:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":GradientCanvas,
         "events":{"creationComplete":"___ReconnectMessage_GradientCanvas1_creationComplete"},
         "propertiesFactory":function():Object
         {
            return {
               "width":400,
               "height":100,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":TitleBar,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":0,
                        "left":0,
                        "right":0,
                        "height":30,
                        "label":"Connection problems"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Text,
                  "id":"txtMessage",
                  "stylesFactory":function():void
                  {
                     this.color = 16777215;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":"",
                        "top":38,
                        "width":380,
                        "right":10,
                        "bottom":10
                     };
                  }
               })]
            };
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _Message:String;
      
      public function ReconnectMessage()
      {
         super();
         mx_internal::_document = this;
         this.styleName = "blackOverlay";
         this.width = 400;
         this.height = 100;
         this.addEventListener("creationComplete",this.___ReconnectMessage_GradientCanvas1_creationComplete);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function close() : void
      {
         if(isPopUp)
         {
            PopUpManager.removePopUp(this);
         }
         else
         {
            parent.removeChild(this);
         }
      }
      
      public function get Message() : String
      {
         if(this._Message == null)
         {
            this._Message = new String();
         }
         return this._Message;
      }
      
      public function set Message(param1:String) : void
      {
         this._Message = param1;
         this.update();
      }
      
      private function update() : void
      {
         if(this.txtMessage != null)
         {
            this.txtMessage.text = this.Message;
         }
      }
      
      public function ___ReconnectMessage_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.update();
      }
      
      [Bindable(event="propertyChange")]
      public function get txtMessage() : Text
      {
         return this._544786569txtMessage;
      }
      
      public function set txtMessage(param1:Text) : void
      {
         var _loc2_:Object = this._544786569txtMessage;
         if(_loc2_ !== param1)
         {
            this._544786569txtMessage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtMessage",_loc2_,param1));
            }
         }
      }
   }
}

