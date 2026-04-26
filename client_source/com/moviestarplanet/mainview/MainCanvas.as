package com.moviestarplanet.mainview
{
   import com.moviestarplanet.Forms.world.MapHolder;
   import com.moviestarplanet.Forms.world.WorldBackground;
   import com.moviestarplanet.connections.LogoutHandler;
   import com.moviestarplanet.core.controller.commands.SetIsStartupScreenCommand;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.createuser.CreateUserController;
   import com.moviestarplanet.createuser.NewUserState;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.moviestar.MovieStar;
   import com.moviestarplanet.progressbar.HideProgressBarCommand;
   import mx.containers.Canvas;
   import mx.core.Container;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.PropertyChangeEvent;
   
   public class MainCanvas extends Canvas
   {
      
      private var _2064354163applicationViewStack:ApplicationViewStack;
      
      private var _1584442534cornerAdGlowbox:CornerAdGlowBox;
      
      private var _836164617mapArea:MapHolder;
      
      private var _1528162189nonInteractiveCanvas:NonInteractiveCanvas;
      
      private var _192872977overlayContainer:OverlayContainer;
      
      private var _2050195040worldBackground:WorldBackground;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "width":1240,
               "height":720,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":WorldBackground,
                  "id":"worldBackground",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":MapHolder,
                  "id":"mapArea"
               }),new UIComponentDescriptor({
                  "type":CornerAdGlowBox,
                  "id":"cornerAdGlowbox"
               }),new UIComponentDescriptor({
                  "type":NonInteractiveCanvas,
                  "id":"nonInteractiveCanvas"
               }),new UIComponentDescriptor({
                  "type":ApplicationViewStack,
                  "id":"applicationViewStack"
               }),new UIComponentDescriptor({
                  "type":OverlayContainer,
                  "id":"overlayContainer"
               })]
            };
         }
      });
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var moviestar:MovieStar;
      
      public function MainCanvas()
      {
         super();
         mx_internal::_document = this;
         this.width = 1240;
         this.height = 720;
         this.horizontalCenter = 0;
         this.horizontalScrollPolicy = "off";
         this.verticalCenter = 0;
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
      
      public function showMainView(param1:Function = null) : void
      {
         var failLoading:Function = null;
         var moviestarLoaded:Function = null;
         var callback:Function = param1;
         failLoading = function():void
         {
            LogoutHandler.getInstance().logout();
            ActorReload.getInstance().unregisterAllListeners();
         };
         moviestarLoaded = function(param1:MovieStar):void
         {
            applicationViewStack.RequestSelectChild(applicationViewStack.mainView,mainViewReady);
            if(callback != null)
            {
               callback();
            }
         };
         this.moviestar = new MovieStar();
         this.moviestar.scale = 0.6;
         this.moviestar.Load(ActorSession.getActorId(),moviestarLoaded,2,false,false,false,failLoading);
      }
      
      private function mainViewReady(param1:Container) : void
      {
         new SetIsStartupScreenCommand().execute(false);
         if(NewUserState.justCreated)
         {
            this.setMainViewVisibility(false);
            this.applicationViewStack.mainView.moviestarContainer.visible = false;
            Main.Instance.mainCanvas.applicationViewStack.mainView.friendActivityListComponent.visible = false;
            new SetIsStartupScreenCommand().execute(true);
            CreateUserController.openIntroduction(this.applicationViewStack.mainView.introductionLayer,this.introductionStarting,this.introductionPreremove);
         }
         else
         {
            this.setMainViewVisibility(true);
         }
         this.applicationViewStack.mainView.mainMenuViewStack.selectedIndex = 0;
         this.applicationViewStack.unLoadAndHideFrontPage();
         if(NewUserState.justCreated == false)
         {
            new HideProgressBarCommand().execute();
         }
      }
      
      private function setMainViewVisibility(param1:Boolean) : void
      {
         this.worldBackground.visible = param1;
         this.mapArea.visible = param1;
         this.applicationViewStack.visible = param1;
         this.overlayContainer.visible = param1;
         this.cornerAdGlowbox.visible = param1;
      }
      
      private function introductionStarting() : void
      {
         this.setMainViewVisibility(true);
         new HideProgressBarCommand().execute();
      }
      
      private function introductionPreremove() : void
      {
         this.applicationViewStack.mainView.moviestarContainer.visible = true;
         new SetIsStartupScreenCommand().execute(false);
         Main.Instance.mainCanvas.applicationViewStack.mainView.friendActivityListComponent.visible = true;
      }
      
      [Bindable(event="propertyChange")]
      public function get applicationViewStack() : ApplicationViewStack
      {
         return this._2064354163applicationViewStack;
      }
      
      public function set applicationViewStack(param1:ApplicationViewStack) : void
      {
         var _loc2_:Object = this._2064354163applicationViewStack;
         if(_loc2_ !== param1)
         {
            this._2064354163applicationViewStack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"applicationViewStack",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cornerAdGlowbox() : CornerAdGlowBox
      {
         return this._1584442534cornerAdGlowbox;
      }
      
      public function set cornerAdGlowbox(param1:CornerAdGlowBox) : void
      {
         var _loc2_:Object = this._1584442534cornerAdGlowbox;
         if(_loc2_ !== param1)
         {
            this._1584442534cornerAdGlowbox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cornerAdGlowbox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mapArea() : MapHolder
      {
         return this._836164617mapArea;
      }
      
      public function set mapArea(param1:MapHolder) : void
      {
         var _loc2_:Object = this._836164617mapArea;
         if(_loc2_ !== param1)
         {
            this._836164617mapArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mapArea",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get nonInteractiveCanvas() : NonInteractiveCanvas
      {
         return this._1528162189nonInteractiveCanvas;
      }
      
      public function set nonInteractiveCanvas(param1:NonInteractiveCanvas) : void
      {
         var _loc2_:Object = this._1528162189nonInteractiveCanvas;
         if(_loc2_ !== param1)
         {
            this._1528162189nonInteractiveCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"nonInteractiveCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get overlayContainer() : OverlayContainer
      {
         return this._192872977overlayContainer;
      }
      
      public function set overlayContainer(param1:OverlayContainer) : void
      {
         var _loc2_:Object = this._192872977overlayContainer;
         if(_loc2_ !== param1)
         {
            this._192872977overlayContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"overlayContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get worldBackground() : WorldBackground
      {
         return this._2050195040worldBackground;
      }
      
      public function set worldBackground(param1:WorldBackground) : void
      {
         var _loc2_:Object = this._2050195040worldBackground;
         if(_loc2_ !== param1)
         {
            this._2050195040worldBackground = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"worldBackground",_loc2_,param1));
            }
         }
      }
   }
}

