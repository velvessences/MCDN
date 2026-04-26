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
   import mx.containers.HBox;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class TitleBar extends GradientCanvas
   {
      
      private var _410956671container:HBox;
      
      private var _1938861975labelComponent:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":GradientCanvas,
         "events":{"creationComplete":"___TitleBar_GradientCanvas1_creationComplete"},
         "propertiesFactory":function():Object
         {
            return {
               "height":30,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":HBox,
                  "id":"container",
                  "stylesFactory":function():void
                  {
                     this.paddingTop = 0;
                     this.paddingBottom = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":5,
                        "bottom":5,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "id":"labelComponent",
                           "stylesFactory":function():void
                           {
                              this.color = 16777215;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"text":"TitleBar"};
                           }
                        })]
                     };
                  }
               })]
            };
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _label:String = "";
      
      private var _fontSize:Number = 0;
      
      public function TitleBar()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.height = 30;
         this.styleName = "titleBarOverlay";
         this.addEventListener("creationComplete",this.___TitleBar_GradientCanvas1_creationComplete);
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
      
      protected function setContainerHorizontalBounds() : void
      {
         this.container.setStyle("left",5);
      }
      
      protected function setFontFamily() : void
      {
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
         this.update();
      }
      
      public function setFontSize(param1:Number) : void
      {
         this._fontSize = param1;
      }
      
      private function onCreationComplete() : void
      {
         this.setContainerHorizontalBounds();
         this.setFontFamily();
         this.update();
      }
      
      private function update() : void
      {
         if(initialized)
         {
            this.labelComponent.text = this._label;
            if(this._fontSize != 0)
            {
               this.labelComponent.setStyle("fontSize",this._fontSize);
            }
         }
      }
      
      public function ___TitleBar_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      [Bindable(event="propertyChange")]
      public function get container() : HBox
      {
         return this._410956671container;
      }
      
      public function set container(param1:HBox) : void
      {
         var _loc2_:Object = this._410956671container;
         if(_loc2_ !== param1)
         {
            this._410956671container = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"container",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get labelComponent() : Label
      {
         return this._1938861975labelComponent;
      }
      
      public function set labelComponent(param1:Label) : void
      {
         var _loc2_:Object = this._1938861975labelComponent;
         if(_loc2_ !== param1)
         {
            this._1938861975labelComponent = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"labelComponent",_loc2_,param1));
            }
         }
      }
   }
}

