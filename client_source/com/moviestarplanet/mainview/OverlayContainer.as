package com.moviestarplanet.mainview
{
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   
   public class OverlayContainer extends Canvas
   {
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({"type":Canvas});
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function OverlayContainer()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
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
   }
}

