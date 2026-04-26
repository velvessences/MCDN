package com.moviestarplanet.Components
{
   import com.moviestarplanet.Components.Buttons.SaveButton;
   import com.moviestarplanet.Components.Friends.FriendshipManager;
   import com.moviestarplanet.Components.Wrapper.BonsterClickItemWrapper;
   import com.moviestarplanet.Components.Wrapper.BonsterListItemWrapper;
   import com.moviestarplanet.Forms.ChatRoom;
   import com.moviestarplanet.Forms.MSP_ComboBox;
   import com.moviestarplanet.Forms.StuffView;
   import com.moviestarplanet.Forms.VisitStuffShops;
   import com.moviestarplanet.activities.OldActivityCreator;
   import com.moviestarplanet.analytics.IAnalytics;
   import com.moviestarplanet.analytics.IFeatureUsage;
   import com.moviestarplanet.analytics.timer.AnalyticsTimer;
   import com.moviestarplanet.body.Body;
   import com.moviestarplanet.bonster.service.BonsterAMFService;
   import com.moviestarplanet.bonster.valueobjects.ActorBonsterRelItem;
   import com.moviestarplanet.chat.ChatRoomController;
   import com.moviestarplanet.chatCommunicator.chatHelpers.com.MSPEvent;
   import com.moviestarplanet.chatutils.chatroom.ChatroomConstants;
   import com.moviestarplanet.clickitems.ClickItem;
   import com.moviestarplanet.constants.analytics.FeatureUsage;
   import com.moviestarplanet.constants.analytics.TimeSpentConstants;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.model.notification.NotificationType;
   import com.moviestarplanet.moviestar.MovieStar;
   import com.moviestarplanet.moviestar.utils.ActorCache;
   import com.moviestarplanet.moviestar.valueObjects.Actor;
   import com.moviestarplanet.moviestar.valueObjects.ActorClothesRel;
   import com.moviestarplanet.moviestar.valueObjects.Cloth;
   import com.moviestarplanet.msg.events.QuestEvent;
   import com.moviestarplanet.pet.service.PetAMFService;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.services.actorservice.valueObjects.ActorRoom;
   import com.moviestarplanet.services.actorservice.valueObjects.ActorRoomInfo;
   import com.moviestarplanet.services.upload.AMFUploadService;
   import com.moviestarplanet.services.wrappers.ProfileService;
   import com.moviestarplanet.utils.EntityTypeType;
   import com.moviestarplanet.utils.MyRoomItem;
   import com.moviestarplanet.utils.SnapshotUtils;
   import com.moviestarplanet.utils.loader.AssetUrl;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
   import com.moviestarplanet.valueObjects.Wallpaper;
   import com.moviestarplanet.window.stack.WindowStack;
   import com.moviestarplanet.windowpopup.popup.Prompt;
   import com.moviestarplanet.windowpopup.popup.PromptEvent;
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
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class EditMyRoom extends GradientCanvas implements IAnalytics, IFeatureUsage, IBindingClient
   {
      
      public static var _instance:EditMyRoom;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      public static const E_CLICKITEM_LIST_CHANGED:String = "E_CLICKITEM_LIST_CHANGED";
      
      private static const SWF_URL_BG:String = new AssetUrl("moviestudio/bg_icon.swf",AssetUrl.SWF).toString();
      
      private static const SWF_URL_ITEM:String = new AssetUrl("moviestudio/item_icon.swf",AssetUrl.SWF).toString();
      
      public var _EditMyRoom_TitleBar1:TitleBar;
      
      public var _EditMyRoom_TitleBar2:TitleBar;
      
      private var _1233296422backgroundCanvas:Canvas;
      
      private var _205678947btnBack:MSP_ClickImage;
      
      private var _1378837878btnBuy:Button;
      
      private var _2082343164btnClose:CloseButton;
      
      private var _232561585btnGarden:Button;
      
      private var _1894624856btnKitchen:Button;
      
      private var _616419508btnModeratorMode:Button;
      
      private var _94069080btnOk:SaveButton;
      
      private var _2094024170btnParty:Button;
      
      private var _206169431btnRoom:Button;
      
      private var _206192505btnShow:MSP_ClickImage;
      
      private var _1559968542floorCombo:MSP_ComboBox;
      
      private var _1552084408floorLabel:Label;
      
      private var _1203734216itemsCanvas:Canvas;
      
      private var _1915510087stuffView:StuffView;
      
      private var _821223289stuffViewItems:MSP_ItemContainer;
      
      private var _1870028133titleBar:CenteredTitleBar;
      
      private var _1992058452visitStuffShops:VisitStuffShops;
      
      private var _164790476wallPaperCombo:MSP_ComboBox;
      
      private var _1820790254wallpaperLabel:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var actorRoom:ActorRoom;
      
      private var movieStar:MovieStar;
      
      private var _itemEditor:MyRoomItemEditor;
      
      private var changedItems:Dictionary;
      
      private var items:Array;
      
      private var hasUnsavedChanges:Boolean;
      
      private var openPublicProfileTimer:Timer;
      
      private var _highlightGlow:GlowFilter;
      
      private var isInModeratorMode:Boolean;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function EditMyRoom()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":GradientCanvas,
            "events":{
               "creationComplete":"___EditMyRoom_GradientCanvas1_creationComplete",
               "add":"___EditMyRoom_GradientCanvas1_add",
               "remove":"___EditMyRoom_GradientCanvas1_remove",
               "show":"___EditMyRoom_GradientCanvas1_show",
               "hide":"___EditMyRoom_GradientCanvas1_hide"
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":980,
                  "height":500,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "stylesFactory":function():void
                     {
                        this.backgroundAlpha = 0.5;
                        this.borderStyle = "solid";
                        this.cornerRadius = 6;
                        this.backgroundColor = 0;
                        this.borderThickness = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "clipContent":false,
                           "height":480,
                           "y":10,
                           "width":960,
                           "x":10,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":StuffView,
                              "id":"stuffView",
                              "stylesFactory":function():void
                              {
                                 this.borderStyle = "none";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "allowDrag":true,
                                    "label":"Room",
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "x":0
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"btnModeratorMode",
                              "events":{"click":"__btnModeratorMode_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":453,
                                    "y":26,
                                    "label":"Moderator Mode",
                                    "visible":false
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":CenteredTitleBar,
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
                     "type":Canvas,
                     "id":"itemsCanvas",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 0;
                        this.backgroundAlpha = 0.8;
                        this.cornerRadius = 10;
                        this.borderStyle = "solid";
                        this.borderThickness = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":true,
                           "x":605,
                           "y":40,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":TitleBar,
                              "id":"_EditMyRoom_TitleBar1",
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
                              "events":{"click":"___EditMyRoom_CloseButton1_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "right":5,
                                    "top":5
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":MSP_ItemContainer,
                              "id":"stuffViewItems",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "VerticalGap":5,
                                    "HorizontalGap":10,
                                    "PageSize":16,
                                    "width":345,
                                    "height":374,
                                    "visible":true,
                                    "x":0,
                                    "y":40
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VisitStuffShops,
                     "id":"visitStuffShops",
                     "stylesFactory":function():void
                     {
                        this.borderColor = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "y":40,
                           "x":605,
                           "width":345,
                           "height":264
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"backgroundCanvas",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 0;
                        this.backgroundAlpha = 0.8;
                        this.cornerRadius = 10;
                        this.borderStyle = "solid";
                        this.borderThickness = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "width":345,
                           "height":129,
                           "x":605,
                           "y":40,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":TitleBar,
                              "id":"_EditMyRoom_TitleBar2",
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
                              "events":{"click":"___EditMyRoom_CloseButton2_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "right":5,
                                    "top":5
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"wallpaperLabel",
                              "stylesFactory":function():void
                              {
                                 this.paddingLeft = 0;
                                 this.textAlign = "left";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":85,
                                    "x":20,
                                    "y":52
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":MSP_ComboBox,
                              "id":"wallPaperCombo",
                              "events":{"change":"__wallPaperCombo_change"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "labelField":"Name",
                                    "width":222,
                                    "height":23,
                                    "x":103,
                                    "y":49.5
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"floorLabel",
                              "stylesFactory":function():void
                              {
                                 this.textAlign = "left";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":85,
                                    "x":20,
                                    "y":83
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":MSP_ComboBox,
                              "id":"floorCombo",
                              "events":{"change":"__floorCombo_change"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "labelField":"Name",
                                    "width":222,
                                    "height":23,
                                    "x":103,
                                    "y":80.5
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnRoom",
                     "events":{"click":"__btnRoom_click"},
                     "stylesFactory":function():void
                     {
                        this.fillAlphas = [1,1];
                        this.fillColors = [14293570,14293570];
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":true,
                           "y":35,
                           "x":15,
                           "height":23,
                           "width":110
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnGarden",
                     "events":{"click":"__btnGarden_click"},
                     "stylesFactory":function():void
                     {
                        this.fillAlphas = [1,1];
                        this.fillColors = [4381210,4381210];
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":true,
                           "y":35,
                           "x":130,
                           "height":23,
                           "width":110
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnKitchen",
                     "events":{"click":"__btnKitchen_click"},
                     "stylesFactory":function():void
                     {
                        this.fillAlphas = [1,1];
                        this.fillColors = [2798817,2798817];
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":true,
                           "y":35,
                           "x":245,
                           "height":23,
                           "width":110
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnParty",
                     "events":{"click":"__btnParty_click"},
                     "stylesFactory":function():void
                     {
                        this.fillAlphas = [1,1];
                        this.fillColors = [6687603,6687603];
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":true,
                           "y":35,
                           "x":360,
                           "height":23,
                           "width":110
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnBuy",
                     "events":{"click":"__btnBuy_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "top":4,
                           "right":148,
                           "height":23,
                           "width":160
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "right":5,
                           "top":5,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":MSP_ClickImage,
                              "id":"btnBack",
                              "events":{"click":"__btnBack_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "isRectangularHitbox":true,
                                    "visible":true,
                                    "scaleX":0.7,
                                    "scaleY":0.7
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":MSP_ClickImage,
                              "id":"btnShow",
                              "events":{"click":"__btnShow_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "isRectangularHitbox":true,
                                    "visible":true,
                                    "scaleX":0.7,
                                    "scaleY":0.7
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":SaveButton,
                              "id":"btnOk",
                              "events":{"click":"__btnOk_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "scaleX":0.9,
                                    "scaleY":0.9
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":CloseButton,
                              "id":"btnClose",
                              "events":{"click":"__btnClose_click"}
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 0;
                        this.backgroundAlpha = 1;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":5,
                           "y":455,
                           "width":970,
                           "height":40
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
         bindings = this._EditMyRoom_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_Components_EditMyRoomWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return EditMyRoom[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.styleName = "blackOverlay";
         this.width = 980;
         this.height = 500;
         this.addEventListener("creationComplete",this.___EditMyRoom_GradientCanvas1_creationComplete);
         this.addEventListener("add",this.___EditMyRoom_GradientCanvas1_add);
         this.addEventListener("remove",this.___EditMyRoom_GradientCanvas1_remove);
         this.addEventListener("show",this.___EditMyRoom_GradientCanvas1_show);
         this.addEventListener("hide",this.___EditMyRoom_GradientCanvas1_hide);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function get instance() : EditMyRoom
      {
         if(_instance == null)
         {
            _instance = new EditMyRoom();
         }
         return _instance;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         EditMyRoom._watcherSetupUtil = param1;
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
      
      public function enter(param1:Event = null) : void
      {
         var done:Function;
         var e:Event = param1;
         MessageCommunicator.subscribe(MSPEvent.CHATROOM_CLOSED,this.exit);
         this.stuffView.addEventListener(StuffView.MYROOMITEMSLOADED,this.onMyRoomItemsLoaded);
         this.stuffView.addEventListener(StuffView.E_ITEMMOVED,this.onItemMoved);
         MessageCommunicator.subscribe(E_CLICKITEM_LIST_CHANGED,this.clickItemsChanged);
         if(initialized)
         {
            done = function(param1:ActorRoomInfo):void
            {
               actorRoom = param1.actorRoom;
               loadMovieStar();
               changedItems = new Dictionary();
               setWallPaperAndFloor();
               btnOk.enabled = true;
               MessageCommunicator.subscribe(ActorEvent.ACTORCLOTHESCOLLECTIONCHANGED,actorClothesCollectionChangedHandler);
               MessageCommunicator.subscribe(ActorEvent.ACTORCHANGED,actorChangedHandler);
            };
            ProfileService.LoadActorRoom(ActorSession.loggedInActor.ActorId,done);
         }
      }
      
      public function get itemEditor() : MyRoomItemEditor
      {
         if(this._itemEditor == null)
         {
            this._itemEditor = new MyRoomItemEditor();
            this._itemEditor.addEventListener(MyRoomItemEditor.E_ITEMSAVED,this.itemEdited);
         }
         return this._itemEditor;
      }
      
      public function set itemEditor(param1:MyRoomItemEditor) : void
      {
         this._itemEditor = param1;
      }
      
      public function getAnalyticsNames() : Array
      {
         return [TimeSpentConstants.FEATURE_MYROOM_EDITOR];
      }
      
      public function getFeatureNames() : Array
      {
         return [FeatureUsage.FEATURE_MY_ROOM,FeatureUsage.FEATURE_SUB1_EDITOR];
      }
      
      private function creationComplete() : void
      {
         this.changedItems = new Dictionary();
         addEventListener(Event.ADDED_TO_STAGE,this.enter);
         this.enter();
      }
      
      private function clickItemsChanged(param1:Event) : void
      {
         if(Boolean(this.movieStar) && Boolean(this.movieStar.actor))
         {
            this.populateStuffViewItems(this.movieStar.actor);
         }
      }
      
      private function onItemMoved(param1:Event) : void
      {
         this.hasUnsavedChanges = true;
      }
      
      private function onMyRoomItemsLoaded(param1:Event) : void
      {
         this.btnShow.visible = true;
         this.btnBack.visible = true;
         this.btnModeratorMode.visible = ActorSession.isAdmin();
      }
      
      private function exit(param1:MsgEvent = null) : void
      {
         var saveAlertClosed:Function = null;
         var event:MsgEvent = param1;
         saveAlertClosed = function(param1:PromptEvent):void
         {
            var _loc2_:Object = null;
            var _loc3_:MyRoomItem = null;
            var _loc4_:Point = null;
            if(param1.detail == Prompt.YES)
            {
               stuffView.saveRoom(saveDone);
            }
            else if(param1.detail == Prompt.NO)
            {
               for(_loc2_ in changedItems)
               {
                  _loc3_ = _loc2_ as MyRoomItem;
                  _loc4_ = changedItems[_loc2_].originalPosition;
                  if(_loc3_.clickItem)
                  {
                     _loc3_.clickItem.clickItemData.x = _loc4_.x;
                     _loc3_.clickItem.clickItemData.y = _loc4_.y;
                  }
                  else
                  {
                     _loc3_.rel.x = _loc4_.x;
                     _loc3_.rel.y = _loc4_.y;
                  }
                  updateItemStatus(_loc3_);
               }
               btnExitClicked();
            }
         };
         MonsterPopup.closeCurrent();
         this.stuffView.removeEventListener(StuffView.MYROOMITEMSLOADED,this.onMyRoomItemsLoaded);
         this.stuffView.removeEventListener(StuffView.E_ITEMMOVED,this.onItemMoved);
         MessageCommunicator.unscribe(E_CLICKITEM_LIST_CHANGED,this.clickItemsChanged);
         MessageCommunicator.unscribe(MSPEvent.CHATROOM_CLOSED,this.exit);
         MessageCommunicator.unscribe(ActorEvent.ACTORCLOTHESCOLLECTIONCHANGED,this.actorClothesCollectionChangedHandler);
         MessageCommunicator.unscribe(ActorEvent.ACTORCHANGED,this.actorChangedHandler);
         MSP_LoaderManager.Reset(false);
         this.btnShow.visible = false;
         this.btnBack.visible = false;
         this.btnModeratorMode.visible = false;
         if(this.hasUnsavedChanges)
         {
            this.hasUnsavedChanges = false;
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("SAVE_ROOM"),"",Prompt.YES | Prompt.NO,null,saveAlertClosed,null,Prompt.YES);
         }
         else
         {
            this.btnExitClicked();
         }
      }
      
      private function actorClothesCollectionChangedHandler(param1:MsgEvent) : void
      {
         if(param1.data == ActorSession.getActorId())
         {
            this.loadMovieStar();
         }
      }
      
      private function actorChangedHandler(param1:MsgEvent) : void
      {
         if(param1.data == ActorSession.getActorId())
         {
            this.loadMovieStar();
         }
      }
      
      private function loadMovieStar() : void
      {
         this.btnShow.visible = false;
         this.btnBack.visible = false;
         this.btnModeratorMode.visible = false;
         var _loc1_:MovieStar = new MovieStar(Body.MODE_NOCLICK);
         _loc1_.Load(ActorSession.getActorId(),this.movieStarLoadDone,1,false,true,false);
      }
      
      private function movieStarLoadDone(param1:MovieStar) : void
      {
         if(this.movieStar != null)
         {
            this.movieStar.destroy();
         }
         this.movieStar = param1;
         this.movieStar.scale = 0.4;
         this.movieStar.x = 250 + StuffView.SPACE_BETWEEN_ROOMS * ChatRoomController.currentRoomSection;
         this.movieStar.y = 250;
         this.populateStuffViewItems(this.movieStar.actor);
         this.stuffView.addMovieStarToCanvas(this.movieStar);
         this.stuffView.actorRoom = this.actorRoom;
      }
      
      private function populateStuffViewItems(param1:Actor) : void
      {
         var oldPetsResult:Function = null;
         var newPetsResult:Function = null;
         var LoadActorClothes:Function = null;
         var actor:Actor = param1;
         oldPetsResult = function(param1:Array):void
         {
            var _loc2_:ActorClickItemRel = null;
            var _loc3_:MyRoomItem = null;
            for each(_loc2_ in param1)
            {
               _loc3_ = new MyRoomItem(null,null,false,_loc2_,60,true);
               _loc3_.addEventListener(MouseEvent.CLICK,itemClicked);
               updateItemStatus(_loc3_);
               items.push(_loc3_);
            }
            new BonsterAMFService().GetBonsterListByActor(actor.ActorId,false,newPetsResult,null,true);
         };
         newPetsResult = function(param1:Array):void
         {
            var _loc2_:ActorBonsterRelItem = null;
            var _loc3_:BonsterListItemWrapper = null;
            for each(_loc2_ in param1)
            {
               _loc3_ = new BonsterListItemWrapper(_loc2_);
               _loc3_.addEventListener(MouseEvent.CLICK,bonsterClicked);
               updateBonsterStatus(_loc3_);
               items.push(_loc3_);
            }
            ActorCache.getInstance().getActorClothItems(ActorSession.getActorId(),LoadActorClothes);
         };
         LoadActorClothes = function(param1:Array):void
         {
            var _loc3_:ActorClothesRel = null;
            var _loc4_:Cloth = null;
            var _loc5_:Array = null;
            var _loc6_:MyRoomItem = null;
            movieStar.actor.ActorClothesRels = param1;
            var _loc2_:* = int(movieStar.actor.ActorClothesRels.length - 1);
            while(_loc2_ >= 0)
            {
               _loc3_ = movieStar.actor.ActorClothesRels[_loc2_];
               _loc4_ = _loc3_.Cloth;
               _loc5_ = GetTargetArray(_loc4_);
               if(_loc5_ != null)
               {
                  _loc6_ = new MyRoomItem(_loc4_,_loc3_,false,null,60,true);
                  _loc6_.addEventListener(MouseEvent.CLICK,itemClicked);
                  updateItemStatus(_loc6_);
                  _loc5_.push(_loc6_);
               }
               _loc2_--;
            }
            stuffViewItems.PagedItems = items;
         };
         this.items = [];
         new PetAMFService().GetClickItemsForActor(actor.ActorId,oldPetsResult);
      }
      
      private function onBtnModeratorModeClick() : void
      {
         this.isInModeratorMode = true;
         this.btnModeratorMode.visible = false;
         this.getAllStuffForModeratorMode();
      }
      
      private function getAllStuffForModeratorMode() : void
      {
         var done:Function = null;
         done = function(param1:Array):void
         {
            var _loc3_:Cloth = null;
            var _loc4_:ActorClothesRel = null;
            var _loc5_:Array = null;
            var _loc6_:MyRoomItem = null;
            items = [];
            var _loc2_:* = int(param1.length - 1);
            while(_loc2_ >= 0)
            {
               _loc3_ = param1[_loc2_] as Cloth;
               _loc4_ = new ActorClothesRel();
               _loc4_.Cloth = _loc3_;
               _loc4_.x = 0;
               _loc4_.y = 0;
               _loc5_ = GetTargetArray(_loc3_);
               if(_loc5_ != null)
               {
                  _loc6_ = new MyRoomItem(_loc3_,_loc4_,false,null,60,true);
                  _loc6_.addEventListener(MouseEvent.CLICK,itemClicked);
                  updateItemStatus(_loc6_);
                  _loc5_.push(_loc6_);
               }
               _loc2_--;
            }
            stuffViewItems.PagedItems = items;
            cursorManager.removeBusyCursor();
            if(!itemsCanvas.visible)
            {
               btnShowClick();
            }
         };
         cursorManager.setBusyCursor();
         new AMFUploadService().getAllStuffForModeratorMode(done);
      }
      
      private function get highlightGlow() : GlowFilter
      {
         if(this._highlightGlow == null)
         {
            this._highlightGlow = new GlowFilter(16777215,1,8,8,3,1);
         }
         return this._highlightGlow;
      }
      
      private function updateItemStatus(param1:MyRoomItem) : void
      {
         var _loc2_:Boolean = false;
         if(param1.clickItem)
         {
            _loc2_ = param1.clickItem.clickItemData.x != 0 || param1.clickItem.clickItemData.y != 0;
         }
         else
         {
            _loc2_ = param1.rel.x != 0 || param1.rel.y != 0;
         }
         if(_loc2_)
         {
            param1.filters = [this.highlightGlow];
         }
         else
         {
            param1.filters = [];
         }
      }
      
      private function updateBonsterStatus(param1:BonsterListItemWrapper) : void
      {
         if(param1.IsInMyRoom)
         {
            param1.filters = [this.highlightGlow];
         }
         else
         {
            param1.filters = [];
         }
      }
      
      private function bonsterClicked(param1:Event) : void
      {
         var _loc2_:BonsterListItemWrapper = param1.currentTarget as BonsterListItemWrapper;
         if(_loc2_.IsInMyRoom)
         {
            this.stuffView.removeBonsterFromRoom(_loc2_);
         }
         else
         {
            if(this.hasTooManyPets())
            {
               return;
            }
            this.stuffView.addBonsterToRoom(_loc2_,ChatRoomController.currentRoomSection * StuffView.SPACE_BETWEEN_ROOMS + 150,300);
         }
         this.updateBonsterStatus(_loc2_);
         this.hasUnsavedChanges = true;
      }
      
      private function itemClicked(param1:Event) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc2_:MyRoomItem = MyRoomItem(param1.currentTarget);
         if(this.isInModeratorMode)
         {
            this.stuffView.removeModeratorItemFromRoom();
            this.stuffView.addItemToRoom(_loc2_.rel,100,300,true);
            this.showItemEditor(_loc2_);
         }
         else
         {
            if(_loc2_.clickItem)
            {
               this.changedItems[_loc2_] = {"originalPosition":new Point(_loc2_.clickItem.clickItemData.x,_loc2_.clickItem.clickItemData.y)};
            }
            else
            {
               this.changedItems[_loc2_] = {"originalPosition":new Point(_loc2_.rel.x,_loc2_.rel.y)};
            }
            if(_loc2_.clickItem)
            {
               _loc3_ = _loc2_.clickItem.clickItemData.x != 0 || _loc2_.clickItem.clickItemData.y != 0;
               if(_loc3_)
               {
                  this.stuffView.removeClickItemFromRoom(_loc2_.clickItem);
                  _loc2_.clickItem.clickItemData.x = 0;
                  _loc2_.clickItem.clickItemData.y = 0;
               }
               else
               {
                  if(this.hasTooManyPets(_loc2_.clickItem.IS_PLANT))
                  {
                     return;
                  }
                  if(_loc2_.clickItem.IS_PLANT && ChatRoomController.currentRoomSection != 1)
                  {
                     this.btnRoomViewClick(1);
                  }
                  this.stuffView.addClickItemToRoom(_loc2_.clickItem,ChatRoomController.currentRoomSection * StuffView.SPACE_BETWEEN_ROOMS + 200,300);
               }
            }
            else
            {
               _loc4_ = _loc2_.rel.x != 0 || _loc2_.rel.y != 0;
               if(_loc4_)
               {
                  this.stuffView.removeItemFromRoom(_loc2_.rel);
                  _loc2_.rel.x = 0;
                  _loc2_.rel.y = 0;
               }
               else
               {
                  if(this.stuffView.arrayOfStuffInMyRoom.length >= 100)
                  {
                     Alert.show(MSPLocaleManagerWeb.getInstance().getString("MAX_50_ITEMS"));
                     return;
                  }
                  this.stuffView.addItemToRoom(_loc2_.rel,150 + ChatRoomController.currentRoomSection * StuffView.SPACE_BETWEEN_ROOMS,300);
               }
            }
            this.updateItemStatus(_loc2_);
            this.hasUnsavedChanges = true;
         }
      }
      
      private function itemEdited(param1:Event) : void
      {
         var _loc2_:MyRoomItemEditor = param1.currentTarget as MyRoomItemEditor;
         this.stuffView.updateModeratorItemScale(_loc2_.item.rel.Cloth.Scale);
      }
      
      private function showItemEditor(param1:MyRoomItem) : void
      {
         this.itemEditor.item = param1;
         if(!this.itemEditor.isPopUp)
         {
            this.itemEditor.y = 600;
            PopUpManager.addPopUp(this.itemEditor,this);
         }
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
            case 33:
            case 46:
               return this.items;
            default:
               return null;
         }
      }
      
      private function btnSaveClicked(param1:MouseEvent) : void
      {
         if(this.btnOk.enabled)
         {
            this.btnOk.enabled = false;
            if(this.hasUnsavedChanges && !this.isInModeratorMode)
            {
               this.stuffView.saveRoom(this.saveDone);
            }
            else
            {
               callLater(this.btnExitClicked);
            }
         }
      }
      
      private function saveDone() : void
      {
         MessageCommunicator.send(new QuestEvent(QuestEvent.SPECIAL_QUEST_UPDATE,{
            "action":QuestEvent.ACTION_SAVE_ROOM,
            "increment":1
         }));
         this.saveRoomSnapshots();
         this.hasUnsavedChanges = false;
         callLater(this.btnExitClicked);
      }
      
      private function saveRoomSnapshots() : void
      {
         this.hideComponentsBeforeSnapshot();
         this.movieStar.visible = false;
         var _loc1_:ByteArray = ChatRoom.generateChatRoomSnapshotByteArray(ChatroomConstants.PROFILE_SNAPSHOT_WIDTH,ChatroomConstants.PROFILE_SNAPSHOT_HEIGHT,this.stuffView,[this.stuffView]);
         this.movieStar.visible = true;
         var _loc2_:ByteArray = ChatRoom.generateChatRoomSnapshotByteArray(ChatroomConstants.MEDIUM_SNAPSHOT_WIDTH,ChatroomConstants.MEDIUM_SNAPSHOT_HEIGHT,this.stuffView,[this.stuffView]);
         var _loc3_:ByteArray = ChatRoom.generateChatRoomSnapshotByteArray(ChatroomConstants.SMALL_SNAPSHOT_WIDTH,ChatroomConstants.SMALL_SNAPSHOT_HEIGHT,this.stuffView,[this.stuffView]);
         this.showComponentsAfterSnapshot();
         SnapshotUtils.saveSnapshotNew(ActorSession.getActorId(),EntityTypeType.EntityTypeAsString(EntityTypeType.ROOM),[ActorSession.getActorId()],_loc3_,"jpg");
         SnapshotUtils.saveSnapshotNew(ActorSession.getActorId(),EntityTypeType.EntityTypeAsString(EntityTypeType.ROOM_MEDIUM),[ActorSession.getActorId()],_loc2_,"jpg");
         SnapshotUtils.saveSnapshotNew(ActorSession.getActorId(),EntityTypeType.EntityTypeAsString(EntityTypeType.ROOM_PROFILE),[ActorSession.getActorId()],_loc1_,"jpg");
      }
      
      private function hideComponentsBeforeSnapshot() : void
      {
         this.titleBar.visible = false;
         this.btnRoom.visible = false;
         this.btnGarden.visible = false;
         this.btnKitchen.visible = false;
         this.btnParty.visible = false;
         this.btnShow.visible = false;
         this.btnBuy.visible = false;
         this.btnBack.visible = false;
         this.btnClose.visible = false;
         this.btnOk.visible = false;
         this.visitStuffShops.visible = false;
         this.itemsCanvas.visible = false;
         this.btnModeratorMode.visible = false;
         this.backgroundCanvas.visible = false;
      }
      
      private function showComponentsAfterSnapshot() : void
      {
         this.titleBar.visible = true;
         this.btnRoom.visible = true;
         this.btnGarden.visible = true;
         this.btnKitchen.visible = true;
         this.btnParty.visible = true;
         this.btnShow.visible = true;
         this.btnBack.visible = true;
         this.btnClose.visible = true;
         this.btnOk.visible = true;
         this.btnModeratorMode.visible = ActorSession.isModerator();
      }
      
      private function smallMyRoomSnapshotSaved(param1:*) : void
      {
         FriendshipManager.getInstance().sendBasicEventToFriends(NotificationType.MYROOM.type);
         OldActivityCreator.getInstance().createActivity(5,0,0,0,0);
      }
      
      private function setWallPaperAndFloor() : void
      {
         var done:Function = null;
         var done2:Function = null;
         done = function(param1:ArrayCollection):void
         {
            var _loc3_:Wallpaper = null;
            wallPaperCombo.dataProvider = param1;
            wallPaperCombo.dropdown.dataProvider = param1;
            var _loc2_:Array = actorRoom.Wallpaper.split(":");
            if(_loc2_.length < StuffView.MAX_ROOMS)
            {
               if(_loc2_.length == 1)
               {
                  _loc2_.push(StuffView.DEFAULT_WALLPAPER_ROOM1);
               }
               if(_loc2_.length == 2)
               {
                  _loc2_.push(StuffView.DEFAULT_WALLPAPER_KITCHEN);
               }
               if(_loc2_.length == 3)
               {
                  _loc2_.push(StuffView.DEFAULT_WALLPAPER_PARTY);
               }
            }
            for each(_loc3_ in wallPaperCombo.dataProvider)
            {
               if(_loc3_.FilePath == _loc2_[ChatRoomController.currentRoomSection])
               {
                  wallPaperCombo.selectedItem = _loc3_;
                  break;
               }
            }
         };
         done2 = function(param1:ArrayCollection):void
         {
            var _loc3_:Wallpaper = null;
            floorCombo.dataProvider = param1;
            floorCombo.dropdown.dataProvider = param1;
            var _loc2_:Array = actorRoom.Floor.split(":");
            if(_loc2_.length < StuffView.MAX_ROOMS)
            {
               if(_loc2_.length == 1)
               {
                  _loc2_.push(StuffView.DEFAULT_FLOOR_ROOM1);
               }
               if(_loc2_.length == 2)
               {
                  _loc2_.push(StuffView.DEFAULT_FLOOR_KITCHEN);
               }
               if(_loc2_.length == 3)
               {
                  _loc2_.push(StuffView.DEFAULT_FLOOR_PARTY);
               }
            }
            for each(_loc3_ in floorCombo.dataProvider)
            {
               if(_loc3_.FilePath == _loc2_[ChatRoomController.currentRoomSection])
               {
                  floorCombo.selectedItem = _loc3_;
                  break;
               }
            }
         };
         ProfileService.getWallpapers(1,ChatRoomController.currentRoomSection,done);
         ProfileService.getWallpapers(2,ChatRoomController.currentRoomSection,done2);
      }
      
      private function wallPaperSelected() : void
      {
         this.hasUnsavedChanges = true;
         this.dowallPaperSelected();
      }
      
      private function dowallPaperSelected() : void
      {
         if(this.wallPaperCombo.selectedItem != null)
         {
            this.stuffView.ChangeWallpaper(Wallpaper(this.wallPaperCombo.selectedItem).FilePath);
         }
      }
      
      private function floorSelected() : void
      {
         this.hasUnsavedChanges = true;
         this.dofloorSelected();
      }
      
      private function dofloorSelected() : void
      {
         if(this.floorCombo.selectedItem != null)
         {
            this.stuffView.ChangeFloor(Wallpaper(this.floorCombo.selectedItem).FilePath);
         }
      }
      
      private function disposeBonsterFromItems() : void
      {
         var _loc1_:* = 0;
         var _loc2_:Object = null;
         var _loc3_:BonsterListItemWrapper = null;
         if(this.items)
         {
            _loc1_ = int(this.items.length - 1);
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
         }
      }
      
      private function btnExitClicked() : void
      {
         AnalyticsTimer.myroomEditorWasOpened = true;
         this.stuffView.exit();
         this.stuffViewItems.disposeBonsters();
         this.disposeBonsterFromItems();
         WindowStack.removeSpriteViewStackable(this);
         this.openPublicProfileTimer = new Timer(1000,1);
         this.openPublicProfileTimer.addEventListener(TimerEvent.TIMER,this.openPublicProfile);
         this.openPublicProfileTimer.start();
      }
      
      private function openPublicProfile(param1:Event) : void
      {
         callLater(ChatRoomController.showPublicProfile,[ActorSession.getActorId(),ActorSession.actorName,ChatRoomController.currentRoomSection,ChatRoomController.currentRoomCloseHandler,ChatRoomController.currentRoomCompetition]);
      }
      
      private function btnShowClick() : void
      {
         if(this.itemsCanvas.visible)
         {
            this.itemsCanvas.visible = false;
         }
         else
         {
            if(this.visitStuffShops.visible)
            {
               this.btnBuyClick();
            }
            this.backgroundCanvas.visible = false;
            this.itemsCanvas.visible = true;
         }
      }
      
      private function btnBackClick() : void
      {
         if(this.backgroundCanvas.visible)
         {
            this.backgroundCanvas.visible = false;
         }
         else
         {
            if(this.visitStuffShops.visible)
            {
               this.btnBuyClick();
            }
            if(this.itemsCanvas.visible)
            {
               this.btnShowClick();
            }
            this.backgroundCanvas.visible = true;
         }
      }
      
      private function btnBuyClick() : void
      {
         if(this.visitStuffShops.visible)
         {
            this.visitStuffShops.visible = false;
         }
         else
         {
            if(this.itemsCanvas.visible)
            {
               this.btnShowClick();
            }
            if(this.hasUnsavedChanges)
            {
               this.stuffView.saveRoom(null);
            }
            this.backgroundCanvas.visible = false;
            this.visitStuffShops.visible = true;
         }
      }
      
      private function btnRoomViewClick(param1:int) : void
      {
         var _loc2_:Wallpaper = null;
         var _loc3_:Wallpaper = null;
         if(ChatRoomController.currentRoomSection != param1)
         {
            this.stuffView.setRoomNumber(param1);
            this.movieStar.x = 250 + this.stuffView.horizontalScrollPosition;
            this.wallpaperLabel.text = MSPLocaleManagerWeb.getInstance().getString("WALLPAPER");
            this.floorLabel.text = MSPLocaleManagerWeb.getInstance().getString("FLOOR");
            this.setWallPaperAndFloor();
            for each(_loc2_ in this.wallPaperCombo.dataProvider)
            {
               if(_loc2_.FilePath == this.stuffView.wallArr[ChatRoomController.currentRoomSection])
               {
                  this.wallPaperCombo.selectedItem = _loc2_;
                  break;
               }
            }
            for each(_loc3_ in this.floorCombo.dataProvider)
            {
               if(_loc3_.FilePath == this.stuffView.floorArr[ChatRoomController.currentRoomSection])
               {
                  this.floorCombo.selectedItem = _loc3_;
                  break;
               }
            }
         }
      }
      
      private function hasTooManyPets(param1:Boolean = false) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = 0;
         while(_loc4_ < this.stuffView.arrayOfStuffInMyRoom.length)
         {
            if(this.stuffView.arrayOfStuffInMyRoom[_loc4_] is ClickItem)
            {
               if((this.stuffView.arrayOfStuffInMyRoom[_loc4_] as ClickItem).IS_PLANT)
               {
                  _loc3_++;
               }
               else
               {
                  _loc2_++;
               }
            }
            else if(this.stuffView.arrayOfStuffInMyRoom[_loc4_] is BonsterClickItemWrapper)
            {
               _loc2_++;
            }
            _loc4_++;
         }
         if(param1)
         {
            if(_loc3_ >= 10)
            {
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("MAX_10_PLANTS"));
               return true;
            }
         }
         else if(_loc2_ >= 10)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("MAX_10_PETS"));
            return true;
         }
         return false;
      }
      
      public function ___EditMyRoom_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.creationComplete();
      }
      
      public function ___EditMyRoom_GradientCanvas1_add(param1:FlexEvent) : void
      {
         this.enter();
      }
      
      public function ___EditMyRoom_GradientCanvas1_remove(param1:FlexEvent) : void
      {
         this.exit();
      }
      
      public function ___EditMyRoom_GradientCanvas1_show(param1:FlexEvent) : void
      {
         this.enter();
      }
      
      public function ___EditMyRoom_GradientCanvas1_hide(param1:FlexEvent) : void
      {
         this.exit();
      }
      
      public function __btnModeratorMode_click(param1:MouseEvent) : void
      {
         this.onBtnModeratorModeClick();
      }
      
      public function ___EditMyRoom_CloseButton1_click(param1:MouseEvent) : void
      {
         this.itemsCanvas.visible = false;
      }
      
      public function ___EditMyRoom_CloseButton2_click(param1:MouseEvent) : void
      {
         this.backgroundCanvas.visible = false;
      }
      
      public function __wallPaperCombo_change(param1:ListEvent) : void
      {
         this.wallPaperSelected();
      }
      
      public function __floorCombo_change(param1:ListEvent) : void
      {
         this.floorSelected();
      }
      
      public function __btnRoom_click(param1:MouseEvent) : void
      {
         this.btnRoomViewClick(0);
      }
      
      public function __btnGarden_click(param1:MouseEvent) : void
      {
         this.btnRoomViewClick(1);
      }
      
      public function __btnKitchen_click(param1:MouseEvent) : void
      {
         this.btnRoomViewClick(2);
      }
      
      public function __btnParty_click(param1:MouseEvent) : void
      {
         this.btnRoomViewClick(3);
      }
      
      public function __btnBuy_click(param1:MouseEvent) : void
      {
         this.btnBuyClick();
      }
      
      public function __btnBack_click(param1:MouseEvent) : void
      {
         this.btnBackClick();
      }
      
      public function __btnShow_click(param1:MouseEvent) : void
      {
         this.btnShowClick();
      }
      
      public function __btnOk_click(param1:MouseEvent) : void
      {
         this.btnSaveClicked(param1);
      }
      
      public function __btnClose_click(param1:MouseEvent) : void
      {
         this.exit();
      }
      
      private function _EditMyRoom_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("EDIT_ROOM");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"titleBar.label");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ITEMS_CLICK_ROOM");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_EditMyRoom_TitleBar1.label");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("BACKGROUND_SELECT");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_EditMyRoom_TitleBar2.label");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("WALLPAPER");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"wallpaperLabel.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("FLOOR");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"floorLabel.text");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("LIVINGROOM");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnRoom.label");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("GARDEN");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnGarden.label");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("KITCHEN");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnKitchen.label");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("PARTY_ROOM");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnParty.label");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SHOPS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnBuy.label");
         result[10] = new Binding(this,function():Object
         {
            return EditMyRoom.SWF_URL_BG;
         },null,"btnBack.source");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SELECT_BACKGROUND");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnBack.toolTip");
         result[12] = new Binding(this,function():Object
         {
            return EditMyRoom.SWF_URL_ITEM;
         },null,"btnShow.source");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("MY_ITEMS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnShow.toolTip");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get backgroundCanvas() : Canvas
      {
         return this._1233296422backgroundCanvas;
      }
      
      public function set backgroundCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1233296422backgroundCanvas;
         if(_loc2_ !== param1)
         {
            this._1233296422backgroundCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"backgroundCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnBack() : MSP_ClickImage
      {
         return this._205678947btnBack;
      }
      
      public function set btnBack(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._205678947btnBack;
         if(_loc2_ !== param1)
         {
            this._205678947btnBack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnBack",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnBuy() : Button
      {
         return this._1378837878btnBuy;
      }
      
      public function set btnBuy(param1:Button) : void
      {
         var _loc2_:Object = this._1378837878btnBuy;
         if(_loc2_ !== param1)
         {
            this._1378837878btnBuy = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnBuy",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnClose() : CloseButton
      {
         return this._2082343164btnClose;
      }
      
      public function set btnClose(param1:CloseButton) : void
      {
         var _loc2_:Object = this._2082343164btnClose;
         if(_loc2_ !== param1)
         {
            this._2082343164btnClose = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnClose",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnGarden() : Button
      {
         return this._232561585btnGarden;
      }
      
      public function set btnGarden(param1:Button) : void
      {
         var _loc2_:Object = this._232561585btnGarden;
         if(_loc2_ !== param1)
         {
            this._232561585btnGarden = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnGarden",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnKitchen() : Button
      {
         return this._1894624856btnKitchen;
      }
      
      public function set btnKitchen(param1:Button) : void
      {
         var _loc2_:Object = this._1894624856btnKitchen;
         if(_loc2_ !== param1)
         {
            this._1894624856btnKitchen = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnKitchen",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnModeratorMode() : Button
      {
         return this._616419508btnModeratorMode;
      }
      
      public function set btnModeratorMode(param1:Button) : void
      {
         var _loc2_:Object = this._616419508btnModeratorMode;
         if(_loc2_ !== param1)
         {
            this._616419508btnModeratorMode = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnModeratorMode",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnOk() : SaveButton
      {
         return this._94069080btnOk;
      }
      
      public function set btnOk(param1:SaveButton) : void
      {
         var _loc2_:Object = this._94069080btnOk;
         if(_loc2_ !== param1)
         {
            this._94069080btnOk = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnOk",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnParty() : Button
      {
         return this._2094024170btnParty;
      }
      
      public function set btnParty(param1:Button) : void
      {
         var _loc2_:Object = this._2094024170btnParty;
         if(_loc2_ !== param1)
         {
            this._2094024170btnParty = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnParty",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRoom() : Button
      {
         return this._206169431btnRoom;
      }
      
      public function set btnRoom(param1:Button) : void
      {
         var _loc2_:Object = this._206169431btnRoom;
         if(_loc2_ !== param1)
         {
            this._206169431btnRoom = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRoom",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnShow() : MSP_ClickImage
      {
         return this._206192505btnShow;
      }
      
      public function set btnShow(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._206192505btnShow;
         if(_loc2_ !== param1)
         {
            this._206192505btnShow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnShow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get floorCombo() : MSP_ComboBox
      {
         return this._1559968542floorCombo;
      }
      
      public function set floorCombo(param1:MSP_ComboBox) : void
      {
         var _loc2_:Object = this._1559968542floorCombo;
         if(_loc2_ !== param1)
         {
            this._1559968542floorCombo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"floorCombo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get floorLabel() : Label
      {
         return this._1552084408floorLabel;
      }
      
      public function set floorLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1552084408floorLabel;
         if(_loc2_ !== param1)
         {
            this._1552084408floorLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"floorLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemsCanvas() : Canvas
      {
         return this._1203734216itemsCanvas;
      }
      
      public function set itemsCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1203734216itemsCanvas;
         if(_loc2_ !== param1)
         {
            this._1203734216itemsCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemsCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stuffView() : StuffView
      {
         return this._1915510087stuffView;
      }
      
      public function set stuffView(param1:StuffView) : void
      {
         var _loc2_:Object = this._1915510087stuffView;
         if(_loc2_ !== param1)
         {
            this._1915510087stuffView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stuffView",_loc2_,param1));
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
      public function get titleBar() : CenteredTitleBar
      {
         return this._1870028133titleBar;
      }
      
      public function set titleBar(param1:CenteredTitleBar) : void
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
      
      [Bindable(event="propertyChange")]
      public function get visitStuffShops() : VisitStuffShops
      {
         return this._1992058452visitStuffShops;
      }
      
      public function set visitStuffShops(param1:VisitStuffShops) : void
      {
         var _loc2_:Object = this._1992058452visitStuffShops;
         if(_loc2_ !== param1)
         {
            this._1992058452visitStuffShops = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"visitStuffShops",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wallPaperCombo() : MSP_ComboBox
      {
         return this._164790476wallPaperCombo;
      }
      
      public function set wallPaperCombo(param1:MSP_ComboBox) : void
      {
         var _loc2_:Object = this._164790476wallPaperCombo;
         if(_loc2_ !== param1)
         {
            this._164790476wallPaperCombo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wallPaperCombo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wallpaperLabel() : Label
      {
         return this._1820790254wallpaperLabel;
      }
      
      public function set wallpaperLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1820790254wallpaperLabel;
         if(_loc2_ !== param1)
         {
            this._1820790254wallpaperLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wallpaperLabel",_loc2_,param1));
            }
         }
      }
   }
}

