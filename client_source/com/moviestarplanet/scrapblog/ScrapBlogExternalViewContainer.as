package com.moviestarplanet.scrapblog
{
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Components.GradientCanvas;
   import com.moviestarplanet.window.loading.LoadingProgressBarAS;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class ScrapBlogExternalViewContainer extends GradientCanvas
   {
      
      private var _1092797764closeBtn:CloseButton;
      
      private var _1011050834scrapBlogContainer:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":GradientCanvas,
         "events":{"creationComplete":"___ScrapBlogExternalViewContainer_GradientCanvas1_creationComplete"},
         "propertiesFactory":function():Object
         {
            return {
               "width":1000,
               "height":490,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"scrapBlogContainer",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "left":10,
                        "right":10,
                        "top":10,
                        "bottom":10,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":LoadingProgressBarAS,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "verticalCenter":0,
                                 "horizontalCenter":0
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":CloseButton,
                  "id":"closeBtn",
                  "events":{"click":"__closeBtn_click"}
               })]
            };
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function ScrapBlogExternalViewContainer()
      {
         super();
         mx_internal::_document = this;
         this.width = 1000;
         this.height = 490;
         this.styleName = "creamOverlay";
         this.addEventListener("creationComplete",this.___ScrapBlogExternalViewContainer_GradientCanvas1_creationComplete);
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
      
      public function set scrapBlog(param1:UIComponent) : void
      {
         this.scrapBlogContainer.addChild(param1);
      }
      
      private function onCreationComplete() : void
      {
         this.visible = true;
      }
      
      private function close() : void
      {
         if(Boolean(this.parent) && Boolean(this.parent.contains(this)))
         {
            parent.removeChild(this);
         }
      }
      
      public function ___ScrapBlogExternalViewContainer_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function __closeBtn_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      [Bindable(event="propertyChange")]
      public function get closeBtn() : CloseButton
      {
         return this._1092797764closeBtn;
      }
      
      public function set closeBtn(param1:CloseButton) : void
      {
         var _loc2_:Object = this._1092797764closeBtn;
         if(_loc2_ !== param1)
         {
            this._1092797764closeBtn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"closeBtn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scrapBlogContainer() : Canvas
      {
         return this._1011050834scrapBlogContainer;
      }
      
      public function set scrapBlogContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1011050834scrapBlogContainer;
         if(_loc2_ !== param1)
         {
            this._1011050834scrapBlogContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scrapBlogContainer",_loc2_,param1));
            }
         }
      }
   }
}

