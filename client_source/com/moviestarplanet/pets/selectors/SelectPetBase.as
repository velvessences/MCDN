package com.moviestarplanet.pets.selectors
{
   import com.moviestarplanet.Components.ClickItemShop;
   import com.moviestarplanet.Components.CloseButton;
   import com.moviestarplanet.Components.GradientCanvas;
   import com.moviestarplanet.Components.MSP_ItemContainer;
   import com.moviestarplanet.Components.TitleBar;
   import com.moviestarplanet.Components.Wrapper.BonsterListItemWrapper;
   import com.moviestarplanet.bonster.service.BonsterAMFService;
   import com.moviestarplanet.bonster.service.BonsterShopSwitch;
   import com.moviestarplanet.bonster.valueobjects.ActorBonsterRelItem;
   import com.moviestarplanet.clickitems.ClickItem;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.moviestar.controller.AddClickItemToMovieStarCommand;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.pet.service.PetAMFService;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.shopping.ShoppingModuleManager;
   import com.moviestarplanet.utils.MyRoomItem;
   import com.moviestarplanet.utils.displayobject.DisplayObjectUtilities;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
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
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class SelectPetBase extends GradientCanvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private var _1271589544buyButton:Button;
      
      private var _2080892951lblNoItems:Label;
      
      private var _974682250noneButton:Button;
      
      private var _821223289stuffViewItems:MSP_ItemContainer;
      
      private var _1870028133titleBar:TitleBar;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _givingActorId:Number = -1;
      
      private var alreadyUpdated:Boolean = false;
      
      protected var items:Array;
      
      public var allowNone:Boolean = true;
      
      public var actionWhenClicked:Boolean = false;
      
      private var _onDoneFunc:Function;
      
      public var onBonsterDoneFunc:Function;
      
      private var allPets:Array;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SelectPetBase()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":GradientCanvas,
            "events":{
               "add":"___SelectPetBase_GradientCanvas1_add",
               "show":"___SelectPetBase_GradientCanvas1_show",
               "initialize":"___SelectPetBase_GradientCanvas1_initialize",
               "creationComplete":"___SelectPetBase_GradientCanvas1_creationComplete"
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":466,
                  "height":174,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":TitleBar,
                     "id":"titleBar",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "top":0,
                           "left":0,
                           "right":0
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":CloseButton,
                     "events":{"click":"___SelectPetBase_CloseButton1_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":435,
                           "y":5
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":MSP_ItemContainer,
                     "id":"stuffViewItems",
                     "stylesFactory":function():void
                     {
                        this.cornerRadius = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "VerticalGap":10,
                           "HorizontalGap":10,
                           "PageSize":5,
                           "width":406,
                           "height":97,
                           "x":30,
                           "y":40
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"lblNoItems",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 16;
                        this.fontWeight = "bold";
                        this.color = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":84,
                           "visible":false,
                           "horizontalCenter":0
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":142,
                           "right":60,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Button,
                              "id":"buyButton",
                              "events":{"click":"__buyButton_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "y":142,
                                    "visible":false,
                                    "includeInLayout":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"noneButton",
                              "events":{"click":"__noneButton_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {"y":142};
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this.items = [];
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         bindings = this._SelectPetBase_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_pets_selectors_SelectPetBaseWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SelectPetBase[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.styleName = "creamOverlay";
         this.width = 466;
         this.height = 174;
         this.addEventListener("add",this.___SelectPetBase_GradientCanvas1_add);
         this.addEventListener("show",this.___SelectPetBase_GradientCanvas1_show);
         this.addEventListener("initialize",this.___SelectPetBase_GradientCanvas1_initialize);
         this.addEventListener("creationComplete",this.___SelectPetBase_GradientCanvas1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SelectPetBase._watcherSetupUtil = param1;
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
      
      public function get onDoneFunc() : Function
      {
         return this._onDoneFunc;
      }
      
      public function set onDoneFunc(param1:Function) : void
      {
         this._onDoneFunc = param1;
      }
      
      private function creationComplete(param1:Event) : void
      {
         this.update();
      }
      
      protected function initializeElements(param1:Event) : void
      {
      }
      
      public function Enter() : void
      {
         this.update();
      }
      
      public function set givingActorId(param1:Number) : void
      {
         this._givingActorId = param1;
         this.update();
      }
      
      private function update() : void
      {
         if(Boolean(initialized) && !this.alreadyUpdated)
         {
            this.getBonsters();
            this.alreadyUpdated = true;
            this.noneButton.visible = this.allowNone;
            this.noneButton.includeInLayout = this.allowNone;
         }
      }
      
      private function getBonsters() : void
      {
         if(this.shouldIncludeBonsters())
         {
            new BonsterAMFService().GetBonsterListByActor(ActorSession.loggedInActor.ActorId,false,this.gotBonsters,null,true);
         }
         else
         {
            this.gotBonsters(new Array());
         }
      }
      
      private function gotBonsters(param1:Array) : void
      {
         this.allPets = param1;
         this.getClickItemsForActor();
      }
      
      private function getClickItemsForActor() : void
      {
         var _loc1_:Function = this.getServiceCall();
         var _loc2_:Array = this.getServiceParams();
         _loc2_.push(this.result);
         _loc1_.apply(null,_loc2_);
      }
      
      protected function getServiceCall() : Function
      {
         return new PetAMFService().GetClickItemsForActor;
      }
      
      protected function getServiceParams() : Array
      {
         return [ActorSession.getActorId()];
      }
      
      protected function result(param1:Array) : void
      {
         this.allPets = this.allPets.concat(param1);
         if(this.allPets.length == 0)
         {
            this.lblNoItems.visible = true;
            this.buyButton.visible = this.buyButton.includeInLayout = true;
         }
         else
         {
            this.populateStuffViewItems(this.allPets);
         }
      }
      
      protected function populateStuffViewItems(param1:Array) : void
      {
         var _loc3_:MyRoomItem = null;
         var _loc4_:BonsterListItemWrapper = null;
         this.items = [];
         var _loc2_:int = 0;
         while(_loc2_ < this.allPets.length)
         {
            if(this.allPets[_loc2_] is ActorClickItemRel)
            {
               if(!ClickItem.isClickItemPlant(this.allPets[_loc2_]))
               {
                  _loc3_ = new MyRoomItem(null,null,false,this.allPets[_loc2_]);
                  _loc3_.addEventListener(MouseEvent.CLICK,this.itemClicked);
                  this.items.push(_loc3_);
               }
            }
            else if(this.allPets[_loc2_] is ActorBonsterRelItem)
            {
               _loc4_ = new BonsterListItemWrapper(this.allPets[_loc2_]);
               _loc4_.addEventListener(MouseEvent.CLICK,this.itemClicked);
               this.items.push(_loc4_);
            }
            _loc2_++;
         }
         this.stuffViewItems.PagedItems = this.items;
      }
      
      private function GetTargetArray(param1:Cloth) : Array
      {
         switch(param1.ClothesCategoryId)
         {
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
            case 28:
            case 29:
            case 30:
            case 32:
            case 33:
            case 46:
               return this.items;
            default:
               return null;
         }
      }
      
      protected function shouldIncludeBonsters() : Boolean
      {
         return true;
      }
      
      protected function itemClicked(param1:Event) : void
      {
         var _loc2_:String = null;
         if(param1.currentTarget is MyRoomItem)
         {
            _loc2_ = MyRoomItem(param1.currentTarget).actorClickItemRel.ActorClickItemRelId.toString();
         }
         else if(param1.currentTarget is BonsterListItemWrapper)
         {
            _loc2_ = "BONSTER" + BonsterListItemWrapper(param1.currentTarget).actorBonsterRel.ActorBonsterRelId.toString();
         }
         if(this.actionWhenClicked)
         {
            if(Main.Instance.mainCanvas.applicationViewStack.mainView.twitterConfig.selectedMouthExpressionKey != _loc2_)
            {
               Main.Instance.mainCanvas.applicationViewStack.mainView.twitterConfig.send.visible = true;
            }
            Main.Instance.mainCanvas.applicationViewStack.mainView.twitterConfig.selectedMouthExpressionKey = _loc2_;
            new AddClickItemToMovieStarCommand(Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar,true).addClickItemToActor(_loc2_);
         }
         if(this.onDoneFunc != null && param1.currentTarget is MyRoomItem)
         {
            this.onDoneFunc(MyRoomItem(param1.currentTarget).actorClickItemRel);
         }
         else if(this.onBonsterDoneFunc != null && param1.currentTarget is BonsterListItemWrapper)
         {
            this.onBonsterDoneFunc(BonsterListItemWrapper(param1.currentTarget).actorBonsterRel);
         }
         this.close();
      }
      
      protected function disableButton(param1:MyRoomItem) : void
      {
         param1.mouseChildren = false;
         param1.usefogEffect = false;
         param1.removeEventListener(MouseEvent.CLICK,this.itemClicked);
         DisplayObjectUtilities.dimMore(param1,false);
      }
      
      protected function disableBonsterButton(param1:BonsterListItemWrapper) : void
      {
         param1.mouseChildren = false;
         param1.removeEventListener(MouseEvent.CLICK,this.itemClicked);
         DisplayObjectUtilities.dimMore(param1,false);
      }
      
      private function noneClicked() : void
      {
         if(this.actionWhenClicked == false)
         {
            this.close();
         }
         else
         {
            if(Main.Instance.mainCanvas.applicationViewStack.mainView.twitterConfig.selectedMouthExpressionKey != "none")
            {
               Main.Instance.mainCanvas.applicationViewStack.mainView.twitterConfig.send.visible = true;
            }
            Main.Instance.mainCanvas.applicationViewStack.mainView.twitterConfig.selectedMouthExpressionKey = "none";
            Main.Instance.mainCanvas.applicationViewStack.mainView.moviestarContainer.myMovieStar.clickItem = null;
            this.close();
         }
         if(this.onDoneFunc != null)
         {
            this.onDoneFunc(null);
         }
      }
      
      private function buyClicked() : void
      {
         this.close();
         var _loc1_:Array = new Array();
         _loc1_[1] = "Boonie";
         _loc1_[2] = "PetPets";
         var _loc2_:int = Math.random() * 10 % 2 + 1;
         if(BonsterShopSwitch.IsShopSwitchOn)
         {
            ShoppingModuleManager.getInstance().openPetShop(ShoppingModuleManager.PETSHOP_GOTO_DEFAULT_TAB);
         }
         else
         {
            ClickItemShop.getInstance().enterClickItemShop(_loc2_,MSPLocaleManagerWeb.getInstance().getString("SHOP",[_loc1_[_loc2_]]));
         }
      }
      
      public function open() : void
      {
         OldPopupHandler.getInstance().showPopup(this,x,y,false);
      }
      
      public function close() : void
      {
         this.disposeBonsters();
         this.stuffViewItems.disposeBonsters();
         removeChildren();
         if(parent != null && Boolean(parent.contains(this)))
         {
            parent.removeChild(this);
         }
      }
      
      public function disposeBonsters() : void
      {
         var _loc2_:Object = null;
         var _loc3_:BonsterListItemWrapper = null;
         var _loc4_:* = 0;
         var _loc5_:Object = null;
         var _loc6_:ActorBonsterRelItem = null;
         var _loc1_:* = int(this.items.length);
         while(_loc1_ >= 0)
         {
            _loc2_ = this.items[_loc1_];
            if(_loc2_ is BonsterListItemWrapper)
            {
               this.items.splice(_loc1_,1);
               _loc3_ = _loc2_ as BonsterListItemWrapper;
               _loc3_.destroy();
            }
            _loc1_--;
         }
         if(this.allPets)
         {
            _loc4_ = int(this.allPets.length);
            while(_loc4_ >= 0)
            {
               _loc5_ = this.allPets[_loc4_];
               if(_loc5_ is ActorBonsterRelItem)
               {
                  this.allPets.splice(_loc4_,1);
                  _loc6_ = _loc5_ as ActorBonsterRelItem;
                  _loc6_.destroy();
               }
               _loc4_--;
            }
         }
      }
      
      protected function getTitleText() : String
      {
         throw new Error("Subclass must override getTitleText");
      }
      
      protected function getNoPetsText() : String
      {
         throw new Error("Subclass must override getNoPetsText");
      }
      
      public function ___SelectPetBase_GradientCanvas1_add(param1:FlexEvent) : void
      {
         this.Enter();
      }
      
      public function ___SelectPetBase_GradientCanvas1_show(param1:FlexEvent) : void
      {
         this.Enter();
      }
      
      public function ___SelectPetBase_GradientCanvas1_initialize(param1:FlexEvent) : void
      {
         this.initializeElements(param1);
      }
      
      public function ___SelectPetBase_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.creationComplete(param1);
      }
      
      public function ___SelectPetBase_CloseButton1_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function __buyButton_click(param1:MouseEvent) : void
      {
         this.buyClicked();
      }
      
      public function __noneButton_click(param1:MouseEvent) : void
      {
         this.noneClicked();
      }
      
      private function _SelectPetBase_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = getTitleText();
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"titleBar.label");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = getNoPetsText();
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"lblNoItems.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("BUY") || "Buy";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"buyButton.label");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("NONE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"noneButton.label");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get buyButton() : Button
      {
         return this._1271589544buyButton;
      }
      
      public function set buyButton(param1:Button) : void
      {
         var _loc2_:Object = this._1271589544buyButton;
         if(_loc2_ !== param1)
         {
            this._1271589544buyButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buyButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblNoItems() : Label
      {
         return this._2080892951lblNoItems;
      }
      
      public function set lblNoItems(param1:Label) : void
      {
         var _loc2_:Object = this._2080892951lblNoItems;
         if(_loc2_ !== param1)
         {
            this._2080892951lblNoItems = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblNoItems",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get noneButton() : Button
      {
         return this._974682250noneButton;
      }
      
      public function set noneButton(param1:Button) : void
      {
         var _loc2_:Object = this._974682250noneButton;
         if(_loc2_ !== param1)
         {
            this._974682250noneButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"noneButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stuffViewItems() : MSP_ItemContainer
      {
         return this._821223289stuffViewItems;
      }
      
      public function set stuffViewItems(param1:MSP_ItemContainer) : void
      {
         var _loc2_:Object = this._821223289stuffViewItems;
         if(_loc2_ !== param1)
         {
            this._821223289stuffViewItems = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stuffViewItems",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleBar() : TitleBar
      {
         return this._1870028133titleBar;
      }
      
      public function set titleBar(param1:TitleBar) : void
      {
         var _loc2_:Object = this._1870028133titleBar;
         if(_loc2_ !== param1)
         {
            this._1870028133titleBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"titleBar",_loc2_,param1));
            }
         }
      }
   }
}

