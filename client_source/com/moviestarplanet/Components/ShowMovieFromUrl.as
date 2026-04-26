package com.moviestarplanet.Components
{
   import com.moviestarplanet.clientcensor.WhiteListBase;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.moviestudio.MovieStudio;
   import com.moviestarplanet.msg.MSPDataEvent;
   import com.moviestarplanet.utils.chatfilter.BadWordFilter;
   import flash.events.Event;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class ShowMovieFromUrl extends GradientCanvas
   {
      
      private var _1221611226movieStudio:MovieStudio;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":GradientCanvas,
         "propertiesFactory":function():Object
         {
            return {
               "width":1000,
               "height":520,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":MovieStudio,
                  "id":"movieStudio",
                  "events":{"creationComplete":"__movieStudio_creationComplete"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":980,
                        "height":500,
                        "top":10,
                        "left":10,
                        "showMovieFromUrl":true
                     };
                  }
               })]
            };
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var main:Main;
      
      private var urlGuid:String;
      
      private var urlGuidInitialized:Boolean;
      
      private var badWordFilterInitialized:Boolean;
      
      public function ShowMovieFromUrl()
      {
         super();
         mx_internal::_document = this;
         this.horizontalCenter = 0;
         this.verticalCenter = 0;
         this.styleName = "creamOverlay";
         this.width = 1000;
         this.height = 520;
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
      
      public function init(param1:String) : void
      {
         this.urlGuid = param1;
         this.urlGuidInitialized = true;
         this.continueIfAllDependenciesAreObtained();
      }
      
      private function onResizeMain(param1:Event) : void
      {
         scaleX = Main.Instance.mainCanvas.scaleX;
         scaleY = Main.Instance.mainCanvas.scaleX;
      }
      
      private function prepareApplication() : void
      {
         WhiteListBase.instance = new BadWordFilter(this.badWordFilterInitComplete);
      }
      
      private function close(param1:Event) : void
      {
         Main.Instance.removeEventListener(Event.RESIZE,this.onResizeMain);
         MessageCommunicator.send(new MSPDataEvent(MSPDataEvent.MOVIE_FROM_URL_CLOSED));
         parent.removeChild(this);
      }
      
      private function badWordFilterInitComplete() : void
      {
         this.badWordFilterInitialized = true;
         this.continueIfAllDependenciesAreObtained();
      }
      
      private function continueIfAllDependenciesAreObtained() : void
      {
         if(this.urlGuidInitialized && this.badWordFilterInitialized)
         {
            this.finishSetup();
         }
      }
      
      private function finishSetup() : void
      {
         scaleX = Main.Instance.mainCanvas.scaleX;
         scaleY = Main.Instance.mainCanvas.scaleX;
         Main.Instance.addEventListener(Event.RESIZE,this.onResizeMain,false,0,true);
         this.movieStudio.addEventListener(Event.CLOSE,this.close);
         this.movieStudio.playMovieFromGuid(this.urlGuid);
         this.movieStudio.hideButtonsForFrontpage();
      }
      
      public function __movieStudio_creationComplete(param1:FlexEvent) : void
      {
         this.prepareApplication();
      }
      
      [Bindable(event="propertyChange")]
      public function get movieStudio() : MovieStudio
      {
         return this._1221611226movieStudio;
      }
      
      public function set movieStudio(param1:MovieStudio) : void
      {
         var _loc2_:Object = this._1221611226movieStudio;
         if(_loc2_ !== param1)
         {
            this._1221611226movieStudio = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieStudio",_loc2_,param1));
            }
         }
      }
   }
}

