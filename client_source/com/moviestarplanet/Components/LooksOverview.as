package com.moviestarplanet.Components
{
   import com.moviestarplanet.Components.ViewComponent.ViewComponentViewStack;
   import com.moviestarplanet.Components.pushcontent.frienddisplayer.FriendDisplayerForLooks;
   import com.moviestarplanet.Components.pushcontent.utils.FriendDisplayerEvent;
   import com.moviestarplanet.analytics.IAnalytics;
   import com.moviestarplanet.analytics.IFeatureUsage;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.constants.analytics.FeatureUsage;
   import com.moviestarplanet.constants.analytics.TimeSpentConstants;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.look.service.LookAMFService;
   import com.moviestarplanet.look.valueobjects.LookItem;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.msg.ActionEvent;
   import com.moviestarplanet.msg.AreaEvent;
   import com.moviestarplanet.msg.events.CareerQuestEvent;
   import com.moviestarplanet.msg.events.CareerQuestsGoToDestinations;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.window.stack.WindowStackableInterface;
   import com.moviestarplanet.window.utils.PopupUtils;
   import com.moviestarplanet.windowpopup.popup.Prompt;
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
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.ViewStack;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class LooksOverview extends GradientCanvas implements IAnalytics, IFeatureUsage, WindowStackableInterface, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private static const SWF_URL_SHARE:String = new AssetUrl("push/PushFriends_20x20.swf",AssetUrl.ICON).toString();
      
      private static var _selectedTab:int = 0;
      
      private var _1378838065btnBox:HBox;
      
      private var _1132641002btnByOthers:MSP_CustomTabArial;
      
      private var _309488272btnForOthers:MSP_CustomTabArial;
      
      private var _875169718btnOwnLooks:MSP_CustomTabArial;
      
      private var _906431516btn_Share:MSP_ClickImage;
      
      private var _1382514330byOthers:MyLooks;
      
      private var _951530617content:Canvas;
      
      private var _969892236forOthers:MyLooks;
      
      private var _1639985614ownLooks:MyLooks;
      
      private var _1584105757viewStack:ViewStack;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var _actorId:Number;
      
      public var _actorName:String;
      
      private var startLookId:Number;
      
      private var openedInStack:Boolean;
      
      private var useStartLookForOthers:Boolean = false;
      
      private var createNew:Boolean = false;
      
      private var friendDisplayer:FriendDisplayerForLooks;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function LooksOverview()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":GradientCanvas,
            "events":{"creationComplete":"___LooksOverview_GradientCanvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.borderColor = 12040892;
               this.borderStyle = "solid";
               this.cornerRadius = 10;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":980,
                  "height":500,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"content",
                     "stylesFactory":function():void
                     {
                        this.borderStyle = "solid";
                        this.borderThickness = 0;
                        this.cornerRadius = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "top":0,
                           "width":980,
                           "percentHeight":100,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":HBox,
                              "id":"btnBox",
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0.3;
                                 this.backgroundColor = 0;
                                 this.paddingTop = 5;
                                 this.horizontalGap = 1;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":980,
                                    "left":10,
                                    "top":0,
                                    "right":0,
                                    "height":26,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":MSP_CustomTabArial,
                                       "id":"btnOwnLooks",
                                       "events":{"click":"__btnOwnLooks_click"}
                                    }),new UIComponentDescriptor({
                                       "type":MSP_CustomTabArial,
                                       "id":"btnForOthers",
                                       "events":{"click":"__btnForOthers_click"}
                                    }),new UIComponentDescriptor({
                                       "type":MSP_CustomTabArial,
                                       "id":"btnByOthers",
                                       "events":{"click":"__btnByOthers_click"}
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":ViewStack,
                              "id":"viewStack",
                              "events":{"change":"__viewStack_change"},
                              "stylesFactory":function():void
                              {
                                 this.backgroundAlpha = 0;
                                 this.borderStyle = "none";
                                 this.borderColor = 12040892;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "alpha":1,
                                    "bottom":0,
                                    "top":26,
                                    "left":10,
                                    "right":10,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":MyLooks,
                                       "id":"ownLooks",
                                       "events":{"creationComplete":"__ownLooks_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "serverCall":new LookAMFService().GetLooksForActor,
                                             "exitCall":Exit,
                                             "createNewLookClickCall":createNewLook
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MyLooks,
                                       "id":"forOthers",
                                       "events":{"creationComplete":"__forOthers_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "serverCall":new LookAMFService().GetLooksForOthers,
                                             "creatorMode":true,
                                             "exitCall":Exit,
                                             "createNewLookClickCall":createNewLook
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MyLooks,
                                       "id":"byOthers",
                                       "events":{"creationComplete":"__byOthers_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "serverCall":new LookAMFService().GetLooksByOthers,
                                             "exitCall":Exit,
                                             "createNewLookClickCall":createNewLook
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":MSP_ClickImage,
                              "id":"btn_Share",
                              "events":{"click":"__btn_Share_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "isRectangularHitbox":true,
                                    "top":5,
                                    "right":30
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":CloseButton,
                              "events":{"click":"___LooksOverview_CloseButton1_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "top":5,
                                    "right":5
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
         bindings = this._LooksOverview_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_Components_LooksOverviewWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return LooksOverview[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.styleName = "blackOverlay";
         this.width = 980;
         this.height = 500;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___LooksOverview_GradientCanvas1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      private static function preShow(param1:Number, param2:String, param3:Number = NaN, param4:Number = NaN) : LooksOverview
      {
         var _loc5_:LooksOverview = new LooksOverview();
         _loc5_.actorId = param1;
         _loc5_.actorName = param2;
         _loc5_.startLookId = param4;
         if(!param3 || param1 == param3)
         {
            _loc5_.selectedTab = 0;
         }
         else
         {
            _loc5_.selectedTab = 1;
         }
         return _loc5_;
      }
      
      public static function show(param1:Number, param2:String, param3:Number = NaN, param4:Number = NaN, param5:Boolean = false) : void
      {
         var _loc6_:LooksOverview = preShow(param1,param2,param3,param4);
         _loc6_.openedInStack = param5;
         if(param5 == true)
         {
            WindowStack.showViewStackable(_loc6_,235,80,WindowStack.Z_CONTENT);
         }
         else
         {
            OldPopupHandler.getInstance().showMainPopup(_loc6_,235,80);
         }
         MessageCommunicator.send(new AreaEvent(AreaEvent.LOOKS));
      }
      
      public static function showInParent(param1:Number, param2:String, param3:Number = NaN, param4:Number = NaN, param5:DisplayObjectContainer = null) : void
      {
         var _loc6_:LooksOverview = preShow(param1,param2,param3,param4);
         _loc6_.openedInStack = true;
         WindowStack.showChildWindow(_loc6_,235,80,param5);
         MessageCommunicator.send(new AreaEvent(AreaEvent.LOOKS));
      }
      
      public static function createLookFor(param1:Number, param2:String, param3:Number, param4:String) : void
      {
         var _loc5_:LooksOverview = new LooksOverview();
         _loc5_.actorId = param1;
         _loc5_.actorName = param2;
         _loc5_.selectedTab = 2;
         _loc5_.createNew = true;
         _loc5_.openedInStack = true;
         WindowStack.showViewStackable(_loc5_,235,80,WindowStack.Z_CONTENT);
         MessageCommunicator.sendMessage(CareerQuestEvent.USER_CLICKED_BUTTON,CareerQuestsGoToDestinations.GOTO_CREATE_FRIEND_LOOK);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         LooksOverview._watcherSetupUtil = param1;
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
            this.borderColor = 12040892;
            this.borderStyle = "solid";
            this.cornerRadius = 10;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set actorId(param1:Number) : void
      {
         this._actorId = param1;
         if(initialized)
         {
            this.ownLooks.actorId = param1;
            this.byOthers.actorId = param1;
            this.forOthers.actorId = param1;
         }
      }
      
      public function set actorName(param1:String) : void
      {
         if(param1 != this._actorName)
         {
            this._actorName = param1;
            if(initialized)
            {
               this.btnOwnLooks.label = this._actorName;
               this.btnForOthers.label = MSPLocaleManagerWeb.getInstance().getString("LOOKS_FOR_OTHERS",[this._actorName]);
               this.btnByOthers.label = MSPLocaleManagerWeb.getInstance().getString("LOOKS_BY_OTHERS",[this._actorName]);
            }
         }
      }
      
      public function createNewLook() : void
      {
         this.createNew = true;
         if(this._actorId == ActorSession.loggedInActor.ActorId)
         {
            this.selectedTab = 0;
            this.ownLooks.CreateNewLook();
            this.createNew = false;
            MessageCommunicator.send(new ActionEvent(ActionEvent.CREATE_NEW_LOOK_SELF));
         }
         else
         {
            this.selectedTab = 2;
            this.createNew = false;
            if(this.byOthers.initialized)
            {
               this.byOthersReady();
            }
            else
            {
               this.byOthers.addEventListener(FlexEvent.CREATION_COMPLETE,this.byOthersCreationComplete);
            }
         }
      }
      
      private function byOthersReady() : void
      {
         if(this.byOthers)
         {
            this.byOthers.CreateNewLook();
         }
      }
      
      private function byOthersCreationComplete(param1:Event) : void
      {
         this.byOthers.removeEventListener(FlexEvent.CREATION_COMPLETE,this.byOthersCreationComplete);
         this.byOthersReady();
      }
      
      private function onCreationComplete() : void
      {
         this.selectedTab = _selectedTab;
         if(_selectedTab == 0)
         {
            this.ownLooks.startLookId = this.startLookId;
         }
         else if(_selectedTab == 1)
         {
            this.useStartLookForOthers = true;
         }
         this.btnOwnLooks.label = this._actorName;
         MessageCommunicator.subscribe(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_LOOK,this.resetFriendDisplayer);
      }
      
      private function paneInitialized(param1:Event) : void
      {
         if(this.createNew && param1.currentTarget == this.byOthers)
         {
            this.createNew = false;
            this.byOthers.CreateNewLook();
         }
         else if(this.useStartLookForOthers && param1.currentTarget == this.forOthers)
         {
            (param1.currentTarget as MyLooks).startLookId = this.startLookId;
            this.useStartLookForOthers = false;
         }
         (param1.currentTarget as MyLooks).myLooksEditor.backgroundAncestor = this;
      }
      
      private function set selectedTab(param1:int) : void
      {
         if(initialized)
         {
            (this.btnBox.getChildAt(_selectedTab) as MSP_CustomTab).deselect();
         }
         _selectedTab = param1;
         if(initialized)
         {
            this.viewStack.selectedIndex = _selectedTab;
            (this.btnBox.getChildAt(_selectedTab) as MSP_CustomTab).select();
         }
         if(this.stage != null)
         {
            this.stage.focus = null;
         }
      }
      
      public function Exit() : void
      {
         var _loc1_:ViewComponentViewStack = null;
         var _loc2_:ViewStack = null;
         MessageCommunicator.sendMessage(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_LOOK,null);
         if(this.openedInStack == true)
         {
            WindowStack.removeViewStackable(this);
         }
         else
         {
            _loc1_ = parent as ViewComponentViewStack;
            if(_loc1_ != null)
            {
               _loc2_ = ViewStack(_loc1_);
               _loc2_.selectedIndex = 0;
               return;
            }
            if(isPopUp)
            {
               PopUpManager.removePopUp(this);
            }
            else if(parent)
            {
               parent.removeChild(this);
            }
         }
      }
      
      private function btn_Share_ClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:LookItem = null;
         if(MyLooks(this.viewStack.selectedChild).myLooksEditor._look == null || MyLooks(this.viewStack.selectedChild).myLooksEditor._look.LookId == 0)
         {
            Prompt.show("Please select a look in order to share it.","Select a look");
            return;
         }
         var _loc2_:int = 320;
         var _loc3_:int = 200;
         var _loc4_:Point = this.btn_Share.parent.localToGlobal(new Point(this.btn_Share.x + this.btn_Share.width - _loc3_,this.btn_Share.y + this.btn_Share.height));
         _loc4_ = Main.Instance.mainCanvas.globalToLocal(_loc4_);
         if(this.friendDisplayer == null)
         {
            _loc5_ = MyLooks(this.viewStack.selectedChild).myLooksEditor._look;
            this.friendDisplayer = new FriendDisplayerForLooks(_loc5_.LookId,EntityTypeType.LOOK,_loc5_.LookId,_loc5_.CreatorId,_loc5_.creatorName,_loc5_.ActorId);
         }
         PopupUtils.showPopupDimensions(this.friendDisplayer,_loc4_.x,_loc4_.y,_loc3_,_loc2_,Main.Instance.mainCanvas.applicationViewStack.mainView.popupCanvas);
      }
      
      private function resetFriendDisplayer(param1:MsgEvent) : void
      {
         this.friendDisplayer = null;
      }
      
      private function viewStackChanged() : void
      {
         this.friendDisplayer = null;
         MessageCommunicator.send(new FriendDisplayerEvent(FriendDisplayerEvent.CLOSE_FRIENDDISPLAYER_LOOK));
      }
      
      public function getAnalyticsNames() : Array
      {
         return [TimeSpentConstants.FEATURE_MOVIETOWN,TimeSpentConstants.FEATURE_LOOKS_BROWSER];
      }
      
      public function getFeatureNames() : Array
      {
         return [FeatureUsage.FEATURE_LOOKS,FeatureUsage.FEATURE_SUB1_BROWSER];
      }
      
      public function ___LooksOverview_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function __btnOwnLooks_click(param1:MouseEvent) : void
      {
         this.selectedTab = 0;
         this.btnByOthers.deselect();
         this.btnForOthers.deselect();
      }
      
      public function __btnForOthers_click(param1:MouseEvent) : void
      {
         this.selectedTab = 1;
         this.btnOwnLooks.deselect();
         this.btnByOthers.deselect();
      }
      
      public function __btnByOthers_click(param1:MouseEvent) : void
      {
         this.selectedTab = 2;
         this.btnOwnLooks.deselect();
         this.btnForOthers.deselect();
      }
      
      public function __viewStack_change(param1:IndexChangedEvent) : void
      {
         this.viewStackChanged();
      }
      
      public function __ownLooks_creationComplete(param1:FlexEvent) : void
      {
         this.paneInitialized(param1);
      }
      
      public function __forOthers_creationComplete(param1:FlexEvent) : void
      {
         this.paneInitialized(param1);
      }
      
      public function __byOthers_creationComplete(param1:FlexEvent) : void
      {
         this.paneInitialized(param1);
      }
      
      public function __btn_Share_click(param1:MouseEvent) : void
      {
         this.btn_Share_ClickHandler(param1);
      }
      
      public function ___LooksOverview_CloseButton1_click(param1:MouseEvent) : void
      {
         this.Exit();
      }
      
      private function _LooksOverview_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("/graphics/ramme_2011.swf",Config.LOCAL_CDN_URL);
         },function(param1:Object):void
         {
            content.setStyle("backgroundImage",param1);
         },"content.backgroundImage");
         result[1] = new Binding(this,null,null,"btnOwnLooks.label","_actorName");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("LOOKS_FOR_OTHERS",[_actorName]);
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnForOthers.label");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("LOOKS_BY_OTHERS",[_actorName]);
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnByOthers.label");
         result[4] = new Binding(this,null,null,"ownLooks.actorId","_actorId");
         result[5] = new Binding(this,null,null,"ownLooks.actorName","_actorName");
         result[6] = new Binding(this,null,null,"forOthers.actorId","_actorId");
         result[7] = new Binding(this,null,null,"forOthers.actorName","_actorName");
         result[8] = new Binding(this,null,null,"byOthers.actorId","_actorId");
         result[9] = new Binding(this,null,null,"byOthers.actorName","_actorName");
         result[10] = new Binding(this,function():Object
         {
            return LooksOverview.SWF_URL_SHARE;
         },null,"btn_Share.source");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SHARE_WITH");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btn_Share.toolTip");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnBox() : HBox
      {
         return this._1378838065btnBox;
      }
      
      public function set btnBox(param1:HBox) : void
      {
         var _loc2_:Object = this._1378838065btnBox;
         if(_loc2_ !== param1)
         {
            this._1378838065btnBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnByOthers() : MSP_CustomTabArial
      {
         return this._1132641002btnByOthers;
      }
      
      public function set btnByOthers(param1:MSP_CustomTabArial) : void
      {
         var _loc2_:Object = this._1132641002btnByOthers;
         if(_loc2_ !== param1)
         {
            this._1132641002btnByOthers = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnByOthers",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnForOthers() : MSP_CustomTabArial
      {
         return this._309488272btnForOthers;
      }
      
      public function set btnForOthers(param1:MSP_CustomTabArial) : void
      {
         var _loc2_:Object = this._309488272btnForOthers;
         if(_loc2_ !== param1)
         {
            this._309488272btnForOthers = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnForOthers",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnOwnLooks() : MSP_CustomTabArial
      {
         return this._875169718btnOwnLooks;
      }
      
      public function set btnOwnLooks(param1:MSP_CustomTabArial) : void
      {
         var _loc2_:Object = this._875169718btnOwnLooks;
         if(_loc2_ !== param1)
         {
            this._875169718btnOwnLooks = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnOwnLooks",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btn_Share() : MSP_ClickImage
      {
         return this._906431516btn_Share;
      }
      
      public function set btn_Share(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._906431516btn_Share;
         if(_loc2_ !== param1)
         {
            this._906431516btn_Share = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btn_Share",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get byOthers() : MyLooks
      {
         return this._1382514330byOthers;
      }
      
      public function set byOthers(param1:MyLooks) : void
      {
         var _loc2_:Object = this._1382514330byOthers;
         if(_loc2_ !== param1)
         {
            this._1382514330byOthers = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"byOthers",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get content() : Canvas
      {
         return this._951530617content;
      }
      
      public function set content(param1:Canvas) : void
      {
         var _loc2_:Object = this._951530617content;
         if(_loc2_ !== param1)
         {
            this._951530617content = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"content",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get forOthers() : MyLooks
      {
         return this._969892236forOthers;
      }
      
      public function set forOthers(param1:MyLooks) : void
      {
         var _loc2_:Object = this._969892236forOthers;
         if(_loc2_ !== param1)
         {
            this._969892236forOthers = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"forOthers",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ownLooks() : MyLooks
      {
         return this._1639985614ownLooks;
      }
      
      public function set ownLooks(param1:MyLooks) : void
      {
         var _loc2_:Object = this._1639985614ownLooks;
         if(_loc2_ !== param1)
         {
            this._1639985614ownLooks = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ownLooks",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get viewStack() : ViewStack
      {
         return this._1584105757viewStack;
      }
      
      public function set viewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1584105757viewStack;
         if(_loc2_ !== param1)
         {
            this._1584105757viewStack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"viewStack",_loc2_,param1));
            }
         }
      }
   }
}

