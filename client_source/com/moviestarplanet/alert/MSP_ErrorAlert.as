package com.moviestarplanet.alert
{
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Components.GradientCanvas;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.popup.OldPopupHandler;
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
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.TextArea;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class MSP_ErrorAlert extends GradientCanvas
   {
      
      public static var showAlways:Boolean = false;
      
      private var _583847907lblHeader:Label;
      
      private var _26062707lblMail:Label;
      
      private var _879079651txtArea:TextArea;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":GradientCanvas,
         "events":{"creationComplete":"___MSP_ErrorAlert_GradientCanvas1_creationComplete"},
         "propertiesFactory":function():Object
         {
            return {
               "width":806,
               "height":566,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":Label,
                  "id":"lblHeader",
                  "stylesFactory":function():void
                  {
                     this.color = 16711680;
                     this.fontSize = 20;
                     this.fontWeight = "bold";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":"An Error Occurred",
                        "left":10,
                        "top":5,
                        "right":576
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "id":"lblMail",
                  "stylesFactory":function():void
                  {
                     this.color = 16711680;
                     this.fontSize = 15;
                     this.fontWeight = "bold";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":" - please copy and send to support@moviestarplanet.com",
                        "left":219,
                        "top":10,
                        "right":109
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":CloseButton,
                  "events":{"click":"___MSP_ErrorAlert_CloseButton1_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "right":10,
                        "top":10
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":TextArea,
                  "id":"txtArea",
                  "stylesFactory":function():void
                  {
                     this.color = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":true,
                        "top":44,
                        "left":10,
                        "bottom":40,
                        "right":10
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "events":{"click":"___MSP_ErrorAlert_Button1_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Ok",
                        "bottom":10,
                        "right":10,
                        "width":64
                     };
                  }
               })]
            };
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _logoutOnClose:Boolean = true;
      
      private var _pendingShow:Object = null;
      
      private var _message:String = "";
      
      public function MSP_ErrorAlert()
      {
         super();
         mx_internal::_document = this;
         this.width = 806;
         this.height = 566;
         this.styleName = "blackOverlay";
         this.addEventListener("creationComplete",this.___MSP_ErrorAlert_GradientCanvas1_creationComplete);
      }
      
      public static function show(param1:String, param2:Number = 200, param3:Number = 100, param4:Boolean = true) : void
      {
         var _loc5_:MSP_ErrorAlert = null;
         if(showAlways || ActorSession.loggedInActor != null && ActorSession.isModerator())
         {
            _loc5_ = new MSP_ErrorAlert();
            _loc5_._logoutOnClose = param4;
            _loc5_.message = param1;
            OldPopupHandler.getInstance().showFakePopup(_loc5_,param2,param3,false);
         }
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
      
      private function creationComplete() : void
      {
         this.update();
      }
      
      private function close() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      private function set message(param1:String) : void
      {
         if(this._message != param1)
         {
            this._message = param1;
            this.update();
         }
      }
      
      private function update() : void
      {
         if(initialized)
         {
            this.txtArea.text = this._message;
         }
      }
      
      private function okClicked() : void
      {
         this.close();
      }
      
      public function ___MSP_ErrorAlert_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.creationComplete();
      }
      
      public function ___MSP_ErrorAlert_CloseButton1_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function ___MSP_ErrorAlert_Button1_click(param1:MouseEvent) : void
      {
         this.okClicked();
      }
      
      [Bindable(event="propertyChange")]
      public function get lblHeader() : Label
      {
         return this._583847907lblHeader;
      }
      
      public function set lblHeader(param1:Label) : void
      {
         var _loc2_:Object = this._583847907lblHeader;
         if(_loc2_ !== param1)
         {
            this._583847907lblHeader = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblHeader",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblMail() : Label
      {
         return this._26062707lblMail;
      }
      
      public function set lblMail(param1:Label) : void
      {
         var _loc2_:Object = this._26062707lblMail;
         if(_loc2_ !== param1)
         {
            this._26062707lblMail = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblMail",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtArea() : TextArea
      {
         return this._879079651txtArea;
      }
      
      public function set txtArea(param1:TextArea) : void
      {
         var _loc2_:Object = this._879079651txtArea;
         if(_loc2_ !== param1)
         {
            this._879079651txtArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtArea",_loc2_,param1));
            }
         }
      }
   }
}

