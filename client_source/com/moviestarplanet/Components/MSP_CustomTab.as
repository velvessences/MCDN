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
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class MSP_CustomTab extends MSP_ClickCanvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private var _1938861975labelComponent:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private const selectedColor:String = "0xDA85B6";
      
      private const unselectedColor:String = "0xAB407E";
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function MSP_CustomTab()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":MSP_ClickCanvas,
            "events":{
               "creationComplete":"___MSP_CustomTab_MSP_ClickCanvas1_creationComplete",
               "click":"___MSP_CustomTab_MSP_ClickCanvas1_click"
            },
            "stylesFactory":function():void
            {
               this.cornerRadius = 5;
               this.borderStyle = "solid";
               this.borderThickness = 0;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "height":25,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.borderStyle = "none";
                        this.horizontalAlign = "center";
                        this.verticalAlign = "middle";
                        this.paddingLeft = 5;
                        this.paddingRight = 5;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "height":20,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Label,
                              "id":"labelComponent",
                              "stylesFactory":function():void
                              {
                                 this.fontFamily = "EmbedBADABB";
                                 this.fontSize = 14;
                                 this.color = 16777215;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":true,
                                    "includeInLayout":true,
                                    "percentWidth":100,
                                    "buttonMode":true,
                                    "useHandCursor":true,
                                    "mouseChildren":false
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         bindings = this._MSP_CustomTab_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_Components_MSP_CustomTabWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return MSP_CustomTab[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.height = 25;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.CanvasBackGroundAlpha = 0.9;
         this.buttonMode = true;
         this.useHandCursor = true;
         this.addEventListener("creationComplete",this.___MSP_CustomTab_MSP_ClickCanvas1_creationComplete);
         this.addEventListener("click",this.___MSP_CustomTab_MSP_ClickCanvas1_click);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         MSP_CustomTab._watcherSetupUtil = param1;
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
            this.cornerRadius = 5;
            this.borderStyle = "solid";
            this.borderThickness = 0;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function deselect() : void
      {
         setStyle("backgroundColor",this.unselectedColor);
         invalidateDisplayList();
      }
      
      public function select() : void
      {
         setStyle("backgroundColor",this.selectedColor);
         invalidateDisplayList();
      }
      
      protected function onCreationComplete() : void
      {
      }
      
      public function ___MSP_CustomTab_MSP_ClickCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function ___MSP_CustomTab_MSP_ClickCanvas1_click(param1:MouseEvent) : void
      {
         this.select();
      }
      
      private function _MSP_CustomTab_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = unselectedColor;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"this.CanvasBackGroundColor");
         result[1] = new Binding(this,null,null,"labelComponent.text","label");
         return result;
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

