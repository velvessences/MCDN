package com.moviestarplanet.mainview
{
   import com.moviestarplanet.Certificate.forms.CertificateAdvertisementIngame;
   import com.moviestarplanet.Components.ViewComponent.ViewComponentViewStack;
   import com.moviestarplanet.Forms.FriendActivityListComponent;
   import com.moviestarplanet.Forms.twitter.TwitterConfig;
   import com.moviestarplanet.admin.ServerInformation;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.core.controller.commands.ContinueSettingUpCommand;
   import com.moviestarplanet.frame.TopBar;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.worldactions.WorldActionController;
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
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.styles.*;
   
   public class MainView extends Canvas
   {
      
      private var _1878962770certificateAdvertisement:CertificateAdvertisementIngame;
      
      private var _1855777567christmasContainer:Canvas;
      
      private var _1089836496dgReportOverview:DgReportOverview;
      
      private var _125463153flashContainer:UIComponent;
      
      private var _766246706friendActivityListComponent:FriendActivityListComponent;
      
      private var _1175614121introductionLayer:Canvas;
      
      private var _943659787mainMenuViewStack:ViewComponentViewStack;
      
      private var _802533089moviestarContainer:MoviestarContainer;
      
      private var _1342967055onlineUserCount:OnlineUserCount;
      
      private var _72982820popupCanvas:Canvas;
      
      private var _1233046835reportOverview:ReportOverview;
      
      private var _165269413specialOfferCanvas:SpecialOfferCanvas;
      
      private var _868071810topBar:TopBar;
      
      private var _1676986475twitterConfig:TwitterConfig;
      
      private var _1467336802vipGroup:JudgeJuryCelebVipVBox;
      
      private var _786935559worldActionContainer:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "events":{"creationComplete":"___MainView_Canvas1_creationComplete"},
         "stylesFactory":function():void
         {
            this.backgroundAlpha = 0;
         },
         "propertiesFactory":function():Object
         {
            return {"childDescriptors":[new UIComponentDescriptor({
               "type":Canvas,
               "id":"christmasContainer"
            }),new UIComponentDescriptor({
               "type":MoviestarContainer,
               "id":"moviestarContainer"
            }),new UIComponentDescriptor({
               "type":CertificateAdvertisementIngame,
               "id":"certificateAdvertisement",
               "propertiesFactory":function():Object
               {
                  return {
                     "left":20,
                     "bottom":0
                  };
               }
            }),new UIComponentDescriptor({
               "type":TopBar,
               "id":"topBar"
            }),new UIComponentDescriptor({
               "type":ViewComponentViewStack,
               "id":"mainMenuViewStack",
               "propertiesFactory":function():Object
               {
                  return {"childDescriptors":[new UIComponentDescriptor({"type":Canvas})]};
               }
            }),new UIComponentDescriptor({
               "type":TwitterConfig,
               "id":"twitterConfig"
            }),new UIComponentDescriptor({
               "type":DgReportOverview,
               "id":"dgReportOverview"
            }),new UIComponentDescriptor({
               "type":ReportOverview,
               "id":"reportOverview"
            }),new UIComponentDescriptor({
               "type":OnlineUserCount,
               "id":"onlineUserCount"
            }),new UIComponentDescriptor({"type":AdminWindowButton}),new UIComponentDescriptor({"type":TestingFormButton}),new UIComponentDescriptor({"type":MangroveTestingButton}),new UIComponentDescriptor({"type":AvatarNameLabel}),new UIComponentDescriptor({
               "type":JudgeJuryCelebVipVBox,
               "id":"vipGroup"
            }),new UIComponentDescriptor({
               "type":SpecialOfferCanvas,
               "id":"specialOfferCanvas"
            }),new UIComponentDescriptor({
               "type":Canvas,
               "id":"popupCanvas",
               "propertiesFactory":function():Object
               {
                  return {
                     "horizontalScrollPolicy":"off",
                     "verticalScrollPolicy":"off",
                     "percentWidth":100,
                     "percentHeight":100,
                     "childDescriptors":[new UIComponentDescriptor({"type":MSPUpperLeftLogo}),new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"worldActionContainer",
                        "propertiesFactory":function():Object
                        {
                           return {
                              "scaleX":0.75,
                              "scaleY":0.75
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"introductionLayer"
                     })]
                  };
               }
            }),new UIComponentDescriptor({
               "type":FriendActivityListComponent,
               "id":"friendActivityListComponent"
            }),new UIComponentDescriptor({
               "type":UIComponent,
               "id":"flashContainer"
            })]};
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function MainView()
      {
         super();
         mx_internal::_document = this;
         this.x = 1169;
         this.y = 55;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.clipContent = true;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___MainView_Canvas1_creationComplete);
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
      
      private function OnMainViewCreationComplete() : void
      {
         if(Config.IsRunningInDevelopment)
         {
            this.flashContainer.addChild(new ServerInformation());
         }
         this.moviestarContainer.moviestarLoaded(Main.Instance.mainCanvas.moviestar);
         WorldActionController.addWorldActionsTo(this.worldActionContainer,969,730);
         WindowStack.clearViewStack();
         WindowStack.container = this.popupCanvas;
         new ContinueSettingUpCommand().execute();
      }
      
      public function ___MainView_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.OnMainViewCreationComplete();
      }
      
      [Bindable(event="propertyChange")]
      public function get certificateAdvertisement() : CertificateAdvertisementIngame
      {
         return this._1878962770certificateAdvertisement;
      }
      
      public function set certificateAdvertisement(param1:CertificateAdvertisementIngame) : void
      {
         var _loc2_:Object = this._1878962770certificateAdvertisement;
         if(_loc2_ !== param1)
         {
            this._1878962770certificateAdvertisement = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"certificateAdvertisement",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get christmasContainer() : Canvas
      {
         return this._1855777567christmasContainer;
      }
      
      public function set christmasContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1855777567christmasContainer;
         if(_loc2_ !== param1)
         {
            this._1855777567christmasContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"christmasContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get dgReportOverview() : DgReportOverview
      {
         return this._1089836496dgReportOverview;
      }
      
      public function set dgReportOverview(param1:DgReportOverview) : void
      {
         var _loc2_:Object = this._1089836496dgReportOverview;
         if(_loc2_ !== param1)
         {
            this._1089836496dgReportOverview = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dgReportOverview",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get flashContainer() : UIComponent
      {
         return this._125463153flashContainer;
      }
      
      public function set flashContainer(param1:UIComponent) : void
      {
         var _loc2_:Object = this._125463153flashContainer;
         if(_loc2_ !== param1)
         {
            this._125463153flashContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"flashContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get friendActivityListComponent() : FriendActivityListComponent
      {
         return this._766246706friendActivityListComponent;
      }
      
      public function set friendActivityListComponent(param1:FriendActivityListComponent) : void
      {
         var _loc2_:Object = this._766246706friendActivityListComponent;
         if(_loc2_ !== param1)
         {
            this._766246706friendActivityListComponent = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"friendActivityListComponent",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get introductionLayer() : Canvas
      {
         return this._1175614121introductionLayer;
      }
      
      public function set introductionLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1175614121introductionLayer;
         if(_loc2_ !== param1)
         {
            this._1175614121introductionLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"introductionLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mainMenuViewStack() : ViewComponentViewStack
      {
         return this._943659787mainMenuViewStack;
      }
      
      public function set mainMenuViewStack(param1:ViewComponentViewStack) : void
      {
         var _loc2_:Object = this._943659787mainMenuViewStack;
         if(_loc2_ !== param1)
         {
            this._943659787mainMenuViewStack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainMenuViewStack",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get moviestarContainer() : MoviestarContainer
      {
         return this._802533089moviestarContainer;
      }
      
      public function set moviestarContainer(param1:MoviestarContainer) : void
      {
         var _loc2_:Object = this._802533089moviestarContainer;
         if(_loc2_ !== param1)
         {
            this._802533089moviestarContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"moviestarContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get onlineUserCount() : OnlineUserCount
      {
         return this._1342967055onlineUserCount;
      }
      
      public function set onlineUserCount(param1:OnlineUserCount) : void
      {
         var _loc2_:Object = this._1342967055onlineUserCount;
         if(_loc2_ !== param1)
         {
            this._1342967055onlineUserCount = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"onlineUserCount",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get popupCanvas() : Canvas
      {
         return this._72982820popupCanvas;
      }
      
      public function set popupCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._72982820popupCanvas;
         if(_loc2_ !== param1)
         {
            this._72982820popupCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"popupCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get reportOverview() : ReportOverview
      {
         return this._1233046835reportOverview;
      }
      
      public function set reportOverview(param1:ReportOverview) : void
      {
         var _loc2_:Object = this._1233046835reportOverview;
         if(_loc2_ !== param1)
         {
            this._1233046835reportOverview = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reportOverview",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get specialOfferCanvas() : SpecialOfferCanvas
      {
         return this._165269413specialOfferCanvas;
      }
      
      public function set specialOfferCanvas(param1:SpecialOfferCanvas) : void
      {
         var _loc2_:Object = this._165269413specialOfferCanvas;
         if(_loc2_ !== param1)
         {
            this._165269413specialOfferCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"specialOfferCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get topBar() : TopBar
      {
         return this._868071810topBar;
      }
      
      public function set topBar(param1:TopBar) : void
      {
         var _loc2_:Object = this._868071810topBar;
         if(_loc2_ !== param1)
         {
            this._868071810topBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get twitterConfig() : TwitterConfig
      {
         return this._1676986475twitterConfig;
      }
      
      public function set twitterConfig(param1:TwitterConfig) : void
      {
         var _loc2_:Object = this._1676986475twitterConfig;
         if(_loc2_ !== param1)
         {
            this._1676986475twitterConfig = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"twitterConfig",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get vipGroup() : JudgeJuryCelebVipVBox
      {
         return this._1467336802vipGroup;
      }
      
      public function set vipGroup(param1:JudgeJuryCelebVipVBox) : void
      {
         var _loc2_:Object = this._1467336802vipGroup;
         if(_loc2_ !== param1)
         {
            this._1467336802vipGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"vipGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get worldActionContainer() : Canvas
      {
         return this._786935559worldActionContainer;
      }
      
      public function set worldActionContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._786935559worldActionContainer;
         if(_loc2_ !== param1)
         {
            this._786935559worldActionContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"worldActionContainer",_loc2_,param1));
            }
         }
      }
   }
}

