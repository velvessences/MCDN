package com.moviestarplanet.Components.searchshop
{
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Components.GradientCanvas;
   import com.moviestarplanet.Components.TitleBar;
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
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class SearchClothesShopPopup extends GradientCanvas
   {
      
      private var _631907107lblSearchBarTitle:TitleBar;
      
      private var _1058056547textInput:TextInput;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":GradientCanvas,
         "events":{"creationComplete":"___SearchClothesShopPopup_GradientCanvas1_creationComplete"},
         "propertiesFactory":function():Object
         {
            return {
               "width":400,
               "height":120,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":TitleBar,
                  "id":"lblSearchBarTitle",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Search in Clothes Shop",
                        "top":0,
                        "left":0,
                        "right":0
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":HBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalGap = 30;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":40,
                        "left":20,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "propertiesFactory":function():Object
                           {
                              return {"text":"Item name:"};
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"textInput",
                           "propertiesFactory":function():Object
                           {
                              return {"width":200};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":HBox,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":80,
                        "left":20,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "events":{"click":"___SearchClothesShopPopup_Button1_click"},
                           "propertiesFactory":function():Object
                           {
                              return {"label":"Search"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "events":{"click":"___SearchClothesShopPopup_Button2_click"},
                           "propertiesFactory":function():Object
                           {
                              return {"label":"Cancel"};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":CloseButton,
                  "events":{"click":"___SearchClothesShopPopup_CloseButton1_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":390,
                        "y":5
                     };
                  }
               })]
            };
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var result:Function;
      
      public function SearchClothesShopPopup()
      {
         super();
         mx_internal::_document = this;
         this.width = 400;
         this.height = 120;
         this.styleName = "blackOverlay";
         this.addEventListener("creationComplete",this.___SearchClothesShopPopup_GradientCanvas1_creationComplete);
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
      
      protected function cancelClickHandler(param1:MouseEvent) : void
      {
         this.close();
      }
      
      protected function searchClickHandler(param1:MouseEvent = null) : void
      {
         this.close();
         this.result(this.textInput.text);
      }
      
      private function close(param1:MouseEvent = null) : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      protected function creationCompleteHandler(param1:FlexEvent) : void
      {
         addEventListener(KeyboardEvent.KEY_UP,this.keyUpListener);
      }
      
      protected function keyUpListener(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            removeEventListener(KeyboardEvent.KEY_UP,this.keyUpListener);
            this.searchClickHandler();
         }
      }
      
      public function ___SearchClothesShopPopup_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.creationCompleteHandler(param1);
      }
      
      public function ___SearchClothesShopPopup_Button1_click(param1:MouseEvent) : void
      {
         this.searchClickHandler(param1);
      }
      
      public function ___SearchClothesShopPopup_Button2_click(param1:MouseEvent) : void
      {
         this.cancelClickHandler(param1);
      }
      
      public function ___SearchClothesShopPopup_CloseButton1_click(param1:MouseEvent) : void
      {
         this.close(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get lblSearchBarTitle() : TitleBar
      {
         return this._631907107lblSearchBarTitle;
      }
      
      public function set lblSearchBarTitle(param1:TitleBar) : void
      {
         var _loc2_:Object = this._631907107lblSearchBarTitle;
         if(_loc2_ !== param1)
         {
            this._631907107lblSearchBarTitle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblSearchBarTitle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get textInput() : TextInput
      {
         return this._1058056547textInput;
      }
      
      public function set textInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1058056547textInput;
         if(_loc2_ !== param1)
         {
            this._1058056547textInput = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"textInput",_loc2_,param1));
            }
         }
      }
   }
}

