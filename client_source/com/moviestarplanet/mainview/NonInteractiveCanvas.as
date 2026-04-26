package com.moviestarplanet.mainview
{
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
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
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.filters.*;
   import mx.styles.*;
   
   public class NonInteractiveCanvas extends Canvas
   {
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "stylesFactory":function():void
         {
            this.backgroundAlpha = 0;
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function NonInteractiveCanvas()
      {
         super();
         mx_internal::_document = this;
         this.doubleClickEnabled = false;
         this.mouseFocusEnabled = false;
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.useHandCursor = false;
         this.buttonMode = false;
         this.x = 0;
         this.y = 0;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.clipContent = true;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
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
            this.backgroundAlpha = 0;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
   }
}

