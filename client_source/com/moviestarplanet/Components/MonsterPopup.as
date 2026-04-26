package com.moviestarplanet.Components
{
   import com.moviestarplanet.Components.ClickItems.FoodSelector;
   import com.moviestarplanet.Components.ClickItems.Monster;
   import com.moviestarplanet.Components.ClickItems.Pet;
   import com.moviestarplanet.Components.ClickItems.PointsPopup;
   import com.moviestarplanet.Components.ClickItems.TrickSelector;
   import com.moviestarplanet.actorutils.ActorValueType;
   import com.moviestarplanet.admin.module.AdminModuleManager;
   import com.moviestarplanet.analytics.AnalyticsReceiveCurrencyCommand;
   import com.moviestarplanet.analytics.constants.AnalyticsConstants;
   import com.moviestarplanet.analytics.constants.AnalyticsStarcoinsAmount;
   import com.moviestarplanet.award.visualization.AwardVisualizationController;
   import com.moviestarplanet.award.visualization.AwardVisualizationType;
   import com.moviestarplanet.chatCommunicator.chatHelpers.configuration.InputLocations;
   import com.moviestarplanet.clickitems.ClickItemCatalog;
   import com.moviestarplanet.clientcensor.Censor;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.controls.flex.text.TextInputRestricted;
   import com.moviestarplanet.core.model.actor.reload.ActorReload;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.flash.components.popups.viponly.VIPOnlyPopUp;
   import com.moviestarplanet.mangroveanalytics.MangroveAnalytics;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.msg.events.QuestEvent;
   import com.moviestarplanet.pet.service.PetAMFService;
   import com.moviestarplanet.popup.OldPopupHandler;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.userbehavior.UserBehaviorResult;
   import com.moviestarplanet.userbehavior.utils.chatfilter.userbehaviorcontrol.UserBehaviorControl;
   import com.moviestarplanet.utils.DateUtils;
   import com.moviestarplanet.utils.DisplayUtils;
   import com.moviestarplanet.utils.Utils;
   import com.moviestarplanet.utils.actorvalues.ActorValueManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
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
   import mx.binding.utils.BindingUtils;
   import mx.containers.Canvas;
   import mx.containers.ViewStack;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.LinkButton;
   import mx.core.Container;
   import mx.core.IFlexModuleFactory;
   import mx.core.INavigatorContent;
   import mx.core.IToolTip;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.CloseEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.ToolTipManager;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class MonsterPopup extends GradientCanvas implements IBindingClient
   {
      
      private static var _currentlyShownMonsterPopup:MonsterPopup;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private static const MS_PER_HOUR:int = 1000 * 60 * 60;
      
      private static const MS_PER_MIN:int = 1000 * 60;
      
      private static var SIZE_SMALL:int = 0;
      
      private static var SIZE_MEDIUM:int = 1;
      
      private static var SIZE_BIG:int = 2;
      
      private static var friendPettingCache:Array = new Array();
      
      private static var txtUserNameErrorTip:IToolTip = null;
      
      private var _1528250798btnDeleteName:MSP_ClickImage;
      
      private var _205802010btnFeed:MSP_ClickImage;
      
      private var _1825453403btnFriendPet:MSP_ClickImage;
      
      private var _492485267btnHarvest:Button;
      
      private var _2086637380btnHatch:Button;
      
      private var _248736369btnMedicin:Button;
      
      private var _206036743btnName:LinkButton;
      
      private var _1378824925btnPet:MSP_ClickImage;
      
      private var _206106544btnPlay:MSP_ClickImage;
      
      private var _206185977btnSave:Button;
      
      private var _620171516btnTricks:MSP_ClickImage;
      
      private var _73234521btnWaitEat:MSP_ClickImage;
      
      private var _73223826btnWaitPet:MSP_ClickImage;
      
      private var _2025034949btnWaitPlay:MSP_ClickImage;
      
      private var _558679249btnWaitTricks:MSP_ClickImage;
      
      private var _2025233456btnWaitWash:MSP_ClickImage;
      
      private var _206305051btnWash:MSP_ClickImage;
      
      private var _1804817334eggView:Canvas;
      
      private var _2132811722foodPointCanvas:Canvas;
      
      private var _1756611997friendView:Canvas;
      
      private var _57007280iconHarvest:Image;
      
      private var _1039259084iconSickMedicin:Image;
      
      private var _1159239369lblFoodPoints:Label;
      
      private var _808735890lblLevel:LinkButton;
      
      private var _26032799lblName:LinkButton;
      
      private var _547060980lblNameFriends:Label;
      
      private var _25876460lblSick:Label;
      
      private var _1255628756normalView:Canvas;
      
      private var _194100483sickView:Canvas;
      
      private var _2070227263statusBar:Canvas;
      
      private var _1870028133titleBar:Canvas;
      
      private var _878708453txtName:TextInputRestricted;
      
      private var _1584105757viewStack:ViewStack;
      
      private var _992043393waitLabel:Label;
      
      private var _245398970waitView:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var testView:String = "normal";
      
      private var _viewSize:int = -1;
      
      private var _monster:Monster;
      
      private var _pointsPopup:PointsPopup;
      
      private var _trickSelector:TrickSelector;
      
      private var _foodSelector:FoodSelector;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function MonsterPopup()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":GradientCanvas,
            "events":{
               "add":"___MonsterPopup_GradientCanvas1_add",
               "creationComplete":"___MonsterPopup_GradientCanvas1_creationComplete"
            },
            "stylesFactory":function():void
            {
               this.backgroundAlpha = 1;
               this.borderStyle = "solid";
               this.borderThickness = 0;
               this.borderColor = 14869218;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":384,
                  "height":183,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":ViewStack,
                     "id":"viewStack",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":37,
                           "percentWidth":100,
                           "height":136,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"normalView",
                              "events":{"creationComplete":"__normalView_creationComplete"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnFeed",
                                       "events":{"click":"__btnFeed_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":24,
                                             "y":20
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnPet",
                                       "events":{"click":"__btnPet_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":24,
                                             "y":91
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnPlay",
                                       "events":{"click":"__btnPlay_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":208,
                                             "y":85
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnWash",
                                       "events":{"click":"__btnWash_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":105,
                                             "y":79
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnTricks",
                                       "events":{"click":"__btnTricks_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":302,
                                             "y":79
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"friendView",
                              "events":{"creationComplete":"__friendView_creationComplete"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnFriendPet",
                                       "events":{"click":"__btnFriendPet_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":168,
                                             "y":34
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"waitView",
                              "events":{"creationComplete":"__waitView_creationComplete"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"waitLabel",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":87,
                                             "y":20
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnWaitEat",
                                       "events":{"click":"__btnWaitEat_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":24,
                                             "y":20
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnWaitPet",
                                       "events":{"click":"__btnWaitPet_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":24,
                                             "y":91
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnWaitPlay",
                                       "events":{"click":"__btnWaitPlay_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":208,
                                             "y":85
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnWaitWash",
                                       "events":{"click":"__btnWaitWash_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":105,
                                             "y":79
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":MSP_ClickImage,
                                       "id":"btnWaitTricks",
                                       "events":{"click":"__btnWaitTricks_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":302,
                                             "y":79
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Image,
                                       "id":"iconHarvest",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":185,
                                             "y":83,
                                             "scaleContent":true,
                                             "width":32,
                                             "height":32,
                                             "visible":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnHarvest",
                                       "events":{"click":"__btnHarvest_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":229,
                                             "y":85,
                                             "label":"Harvest",
                                             "width":90,
                                             "visible":false
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"sickView",
                              "events":{"creationComplete":"__sickView_creationComplete"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"lblSick",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":66,
                                             "y":48
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnMedicin",
                                       "events":{"click":"__btnMedicin_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":170,
                                             "y":46
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Image,
                                       "id":"iconSickMedicin",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":24,
                                             "y":39,
                                             "scaleContent":true,
                                             "width":32,
                                             "height":32
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"eggView",
                              "events":{"creationComplete":"__eggView_creationComplete"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnHatch",
                                       "events":{"click":"__btnHatch_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "y":39,
                                             "x":172
                                          };
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"statusBar",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 0;
                        this.backgroundAlpha = 0.15;
                        this.borderStyle = "solid";
                        this.borderThickness = 0;
                        this.cornerRadius = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":86,
                           "y":80,
                           "width":270,
                           "height":20,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"foodPointCanvas",
                              "stylesFactory":function():void
                              {
                                 this.backgroundColor = 65280;
                                 this.backgroundAlpha = 0.7;
                                 this.borderStyle = "solid";
                                 this.borderThickness = 0;
                                 this.cornerRadius = 5;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":5,
                                    "y":5,
                                    "width":0,
                                    "height":10
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"lblFoodPoints",
                              "stylesFactory":function():void
                              {
                                 this.color = 16777215;
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "text":"",
                                    "horizontalCenter":0,
                                    "verticalCenter":0
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"titleBar",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 0;
                        this.backgroundAlpha = 0.15;
                        this.borderStyle = "solid";
                        this.borderThickness = 0;
                        this.cornerRadius = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "height":45,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":MSP_ClickImage,
                              "id":"btnDeleteName",
                              "events":{"click":"__btnDeleteName_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "toolTip":"Delete pet name",
                                    "left":5,
                                    "top":15,
                                    "height":17,
                                    "width":12,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"lblNameFriends",
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                                 this.fontSize = 18;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":24,
                                    "y":10,
                                    "text":"Fluffy",
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"lblName",
                              "events":{"click":"__lblName_click"},
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                                 this.fontSize = 18;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":20,
                                    "y":7,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"btnName",
                              "events":{"click":"__btnName_click"},
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                                 this.fontSize = 18;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":20,
                                    "y":7,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TextInputRestricted,
                              "id":"txtName",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":24,
                                    "y":7,
                                    "width":180,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"btnSave",
                              "events":{"click":"__btnSave_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "y":5,
                                    "x":210,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":LinkButton,
                              "id":"lblLevel",
                              "events":{"click":"__lblLevel_click"},
                              "stylesFactory":function():void
                              {
                                 this.fontWeight = "bold";
                                 this.fontSize = 18;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":262,
                                    "y":7,
                                    "label":"Level 0",
                                    "visible":false
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":CloseButton,
                     "events":{"click":"___MonsterPopup_CloseButton1_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "right":10,
                           "top":10
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
         bindings = this._MonsterPopup_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_Components_MonsterPopupWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return MonsterPopup[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.width = 384;
         this.height = 183;
         this.styleName = "creamOverlay";
         this.addEventListener("add",this.___MonsterPopup_GradientCanvas1_add);
         this.addEventListener("creationComplete",this.___MonsterPopup_GradientCanvas1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function Show(param1:MonsterPopup, param2:Point, param3:Boolean = false) : void
      {
         closeCurrent();
         _currentlyShownMonsterPopup = param1;
         if(param3)
         {
            param1.styleName = "greenOverlay";
         }
         var _loc4_:Number = ApplicationReference.getApplicationSize().width + ApplicationReference.getApplicationSize().x - param1.width;
         if(param2.x > _loc4_)
         {
            param2.x = _loc4_;
         }
         WindowStack.showSpriteAsViewStackable(param1,param2.x,param2.y,WindowStack.Z_INFO);
         param1.onAdd();
      }
      
      public static function closeCurrent() : void
      {
         if(_currentlyShownMonsterPopup)
         {
            _currentlyShownMonsterPopup.close();
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         MonsterPopup._watcherSetupUtil = param1;
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
            this.backgroundAlpha = 1;
            this.borderStyle = "solid";
            this.borderThickness = 0;
            this.borderColor = 14869218;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function formatWaitMessage(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Number = this.monster.NextFeedTime.getTime() - DateUtils.nowUTC.getTime();
         if(_loc2_ > MS_PER_HOUR)
         {
            _loc5_ = int(int(_loc2_ / MS_PER_HOUR));
            _loc6_ = _loc2_ - _loc5_ * MS_PER_HOUR;
            _loc4_ = int(int(_loc6_ / MS_PER_MIN));
            _loc3_ = MSPLocaleManagerWeb.getInstance().getString("HOURS_AND_MINUTES",[_loc5_,_loc4_]);
         }
         else
         {
            if(_loc2_ > MS_PER_MIN)
            {
               _loc4_ = int(int(_loc2_ / MS_PER_MIN));
            }
            else
            {
               _loc4_ = 1;
            }
            _loc3_ = MSPLocaleManagerWeb.getInstance().getString("MINS",[_loc4_]);
         }
         if(this.monster.IS_PLANT)
         {
            return MSPLocaleManagerWeb.getInstance().getString("FERTILIZER_IN",[_loc3_]);
         }
         return MSPLocaleManagerWeb.getInstance().getString("HUNGRY_IN",[_loc3_]);
      }
      
      public function getView(param1:String) : Container
      {
         if(this.monster.clickItemData.ActorId != ActorSession.loggedInActor.ActorId)
         {
            this.setSmallSize();
            return this.friendView;
         }
         if(this.monster.clickItemData.Stage == 0)
         {
            this.setSmallSize();
            return this.eggView;
         }
         switch(param1)
         {
            case "normal":
               this.setBigSize();
               return this.normalView;
            case "sick":
               this.setMediumSize();
               return this.sickView;
            case "wait":
               this.setBigSize();
               if(this.btnHarvest)
               {
                  if(this.monster.IS_PLANT && this.monster.clickItemData.Stage == ClickItemCatalog.itemAt(this.monster.clickItemData.ClickItemId).MaxStage && this.monster.foodPoints == this.monster.FOODPOINTS_PER_STAGE)
                  {
                     this.btnHarvest.visible = true;
                     this.iconHarvest.visible = true;
                  }
                  else
                  {
                     this.btnHarvest.visible = false;
                     this.iconHarvest.visible = false;
                  }
               }
               return this.waitView;
            case "egg":
               this.setSmallSize();
               return this.eggView;
            default:
               throw new Error("Unexpected healthstatus : " + param1);
         }
      }
      
      public function close() : void
      {
         if(txtUserNameErrorTip != null)
         {
            ToolTipManager.destroyToolTip(txtUserNameErrorTip);
            txtUserNameErrorTip = null;
         }
         if(this.txtName.visible)
         {
            this.btnSave.visible = false;
            this.txtName.visible = false;
            this.lblName.label = this._monster.clickItemData.filteredName;
            this.lblName.visible = true;
         }
         WindowStack.removeSpriteViewStackable(this);
      }
      
      private function creationComplete() : void
      {
         if(this.monster != null)
         {
            this.updateMonster();
            this.createBindings();
         }
         else
         {
            this.viewStack.selectedChild = this.getView(this.testView);
         }
      }
      
      private function friendViewCreationComplete() : void
      {
         if(this.monster.IS_PLANT)
         {
            this.btnFriendPet.toolTip = MSPLocaleManagerWeb.getInstance().getString("PLANT_PET");
            this.btnFriendPet.source = Config.toAbsoluteURL("img/Used/icon_pet.png",Config.LOCAL_CDN_URL);
            this.lblLevel.visible = false;
         }
         else
         {
            this.btnFriendPet.toolTip = MSPLocaleManagerWeb.getInstance().getString("PET_VERB");
            this.btnFriendPet.source = Config.toAbsoluteURL("swf/games/icon_pet00.swf",Config.LOCAL_CDN_URL);
            this.lblLevel.visible = true;
         }
         this.setSmallSize();
         this.statusBar.visible = false;
         this.btnName.visible = false;
         this.lblName.visible = false;
         this.lblNameFriends.visible = true;
         invalidateSize();
      }
      
      private function waitViewCreationComplete() : void
      {
         if(this.monster.IS_PLANT)
         {
            this.btnWaitPet.toolTip = MSPLocaleManagerWeb.getInstance().getString("PLANT_PET");
            this.btnWaitPet.source = Config.toAbsoluteURL("img/Used/icon_pet.png",Config.LOCAL_CDN_URL);
            this.btnWaitEat.source = Config.toAbsoluteURL("swf/games/plant_eat.swf",Config.LOCAL_CDN_URL);
            this.btnWaitPlay.visible = false;
            this.btnWaitWash.visible = false;
            this.btnWaitTricks.visible = false;
            if(this.monster.clickItemData.Stage == ClickItemCatalog.itemAt(this.monster.clickItemData.ClickItemId).MaxStage && this.monster.foodPoints == this.monster.FOODPOINTS_PER_STAGE)
            {
               this.btnHarvest.visible = true;
               this.iconHarvest.visible = true;
            }
            else
            {
               this.btnHarvest.visible = false;
               this.iconHarvest.visible = false;
            }
            this.lblLevel.visible = false;
         }
         else
         {
            this.btnWaitPet.toolTip = MSPLocaleManagerWeb.getInstance().getString("PET_VERB");
            this.btnWaitPet.source = Config.toAbsoluteURL("swf/games/icon_pet00.swf",Config.LOCAL_CDN_URL);
            this.btnWaitEat.source = Config.toAbsoluteURL("swf/games/icon_eat00.swf",Config.LOCAL_CDN_URL);
            this.btnWaitPlay.visible = true;
            this.btnWaitWash.visible = true;
            this.btnWaitTricks.visible = true;
            this.btnWaitPlay.toolTip = MSPLocaleManagerWeb.getInstance().getString("PET_PLAY");
            this.btnWaitWash.toolTip = MSPLocaleManagerWeb.getInstance().getString("PET_WASH");
            this.btnWaitTricks.enabled = (this.monster as Pet).tricks.length > 0;
            this.btnWaitTricks.toolTip = MSPLocaleManagerWeb.getInstance().getString("PET_TRICKS");
            this.btnWaitEat.enabled = true;
            this.lblLevel.visible = true;
         }
         this.lblName.toolTip = MSPLocaleManagerWeb.getInstance().getString("CHANGE_NAME");
         this.lblName.enabled = true;
      }
      
      private function normalViewCreationComplete() : void
      {
         if(this.monster.IS_PLANT)
         {
            this.btnPet.toolTip = MSPLocaleManagerWeb.getInstance().getString("PLANT_PET");
            this.btnFeed.source = Config.toAbsoluteURL("swf/games/plant_eat.swf",Config.LOCAL_CDN_URL);
            this.btnPet.source = Config.toAbsoluteURL("img/Used/icon_pet.png",Config.LOCAL_CDN_URL);
            this.btnPlay.visible = false;
            this.btnWash.visible = false;
            this.btnTricks.visible = false;
            this.lblLevel.visible = false;
         }
         else
         {
            this.btnFeed.toolTip = MSPLocaleManagerWeb.getInstance().getString("PET_FEED");
            this.btnPet.toolTip = MSPLocaleManagerWeb.getInstance().getString("PET_VERB");
            this.btnFeed.source = Config.toAbsoluteURL("swf/games/icon_eat00.swf",Config.LOCAL_CDN_URL);
            this.btnPet.source = Config.toAbsoluteURL("swf/games/icon_pet00.swf",Config.LOCAL_CDN_URL);
            this.btnPlay.visible = true;
            this.btnWash.visible = true;
            this.btnTricks.visible = true;
            this.btnPlay.toolTip = MSPLocaleManagerWeb.getInstance().getString("PET_PLAY");
            this.btnWash.toolTip = MSPLocaleManagerWeb.getInstance().getString("PET_WASH");
            this.btnTricks.toolTip = MSPLocaleManagerWeb.getInstance().getString("PET_TRICKS");
            this.btnTricks.enabled = (this.monster as Pet).tricks.length > 0;
            this.lblLevel.visible = true;
         }
         this.statusBar.visible = true;
         this.lblName.toolTip = MSPLocaleManagerWeb.getInstance().getString("CHANGE_NAME");
         this.lblName.enabled = true;
      }
      
      private function sickViewCreationComplete() : void
      {
         if(this.monster.IS_PLANT)
         {
            this.lblSick.text = MSPLocaleManagerWeb.getInstance().getString("SICK");
            this.btnMedicin.label = MSPLocaleManagerWeb.getInstance().getString("GIVE_MEDICINE",[this.monster.MEDICINPRICE]);
            this.lblLevel.visible = false;
         }
         else
         {
            this.lblSick.text = MSPLocaleManagerWeb.getInstance().getString("SICK");
            this.btnMedicin.label = MSPLocaleManagerWeb.getInstance().getString("GIVE_MEDICINE",[this.monster.MEDICINPRICE]);
            this.lblLevel.visible = true;
         }
         this.statusBar.visible = false;
      }
      
      private function setBigSize() : void
      {
         if(this._viewSize == SIZE_BIG)
         {
            return;
         }
         this._viewSize = SIZE_BIG;
         width = 384;
         height = 183;
         if(this.statusBar)
         {
            this.statusBar.visible = true;
         }
         if(this.lblName)
         {
            this.lblName.visible = true;
         }
      }
      
      private function setMediumSize() : void
      {
         if(this._viewSize == SIZE_MEDIUM)
         {
            return;
         }
         this._viewSize = SIZE_MEDIUM;
         width = 384;
         height = 145;
         if(this.statusBar)
         {
            this.statusBar.visible = false;
         }
         if(this.lblName)
         {
            this.lblName.visible = true;
         }
      }
      
      private function setSmallSize() : void
      {
         if(this._viewSize == SIZE_SMALL)
         {
            return;
         }
         this._viewSize = SIZE_SMALL;
         width = 384;
         height = 145;
         this.titleBar.visible = false;
         if(this.statusBar)
         {
            this.statusBar.visible = false;
         }
         if(this.lblName)
         {
            this.lblName.visible = false;
         }
      }
      
      private function eggViewCreationComplete() : void
      {
         if(this.monster.IS_PLANT)
         {
            this.btnHatch.label = MSPLocaleManagerWeb.getInstance().getString("PLANT_HATCH");
         }
         else
         {
            this.btnHatch.label = MSPLocaleManagerWeb.getInstance().getString("HATCH");
         }
         this.setSmallSize();
         this.statusBar.visible = false;
         this.lblName.visible = false;
         invalidateSize();
      }
      
      private function onAdd() : void
      {
         if(this.monster)
         {
            this.monster.update();
            if(this.viewStack)
            {
               this.viewStack.selectedChild = this.getView(this.monster.healthStatus);
               if(this.viewStack.selectedChild == this.waitView)
               {
                  if(this.waitLabel)
                  {
                     this.waitLabel.text = this.formatWaitMessage(this.monster.healthStatus);
                  }
               }
            }
            if(initialized)
            {
               this.updateMonster();
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get monster() : Monster
      {
         return this._monster;
      }
      
      private function set _1236617178monster(param1:Monster) : void
      {
         this._monster = param1;
         if(initialized)
         {
            this.updateMonster();
            this.createBindings();
         }
         if(txtUserNameErrorTip != null)
         {
            ToolTipManager.destroyToolTip(txtUserNameErrorTip);
            txtUserNameErrorTip = null;
         }
      }
      
      public function updateMonster() : void
      {
         if(this.monster.clickItemData.ActorId == ActorSession.loggedInActor.ActorId && this._monster.clickItemData.Stage > 0)
         {
            if(this._monster.clickItemData.Name.length == 0)
            {
               this.lblName.visible = false;
               this.btnName.visible = true;
            }
            else
            {
               this.lblName.visible = true;
               this.lblName.label = this._monster.clickItemData.filteredName;
               this.btnName.visible = false;
            }
         }
         else if(this.monster.clickItemData.ActorId != ActorSession.loggedInActor.ActorId)
         {
            this.lblNameFriends.visible = true;
            this.lblNameFriends.text = this._monster.clickItemData.filteredName;
            this.lblName.visible = false;
            this.btnName.visible = false;
         }
         if(!this.monster.IS_PLANT)
         {
            this.lblLevel.label = MSPLocaleManagerWeb.getInstance().getString("PLAY_LEVEL",[(this._monster as Pet).playLevel]);
         }
         if(ActorSession.isModerator())
         {
            this.btnDeleteName.visible = true;
         }
      }
      
      private function createBindings() : void
      {
         BindingUtils.bindSetter(this.updateFoodPoints,this.monster,"foodPoints");
      }
      
      private function updateFoodPoints(param1:Number) : void
      {
         if(!initialized)
         {
            return;
         }
         var _loc2_:Number = param1 / this.monster.FOODPOINTS_PER_STAGE;
         this.foodPointCanvas.width = _loc2_ * (this.foodPointCanvas.parent.width - 10);
         if(this.monster.IS_PLANT)
         {
            this.lblFoodPoints.text = param1.toString() + " / " + this.monster.FOODPOINTS_PER_STAGE + " " + MSPLocaleManagerWeb.getInstance().getString("FERTILIZER_POINTS");
         }
         else
         {
            this.lblFoodPoints.text = param1.toString() + " / " + this.monster.FOODPOINTS_PER_STAGE + " " + MSPLocaleManagerWeb.getInstance().getString("FOOD_POINTS");
         }
      }
      
      private function get pointsPopup() : PointsPopup
      {
         if(this._pointsPopup == null)
         {
            this._pointsPopup = new PointsPopup();
            this._pointsPopup.nextLevel = (this.monster as Pet).nextPlayLevelPoints;
            this._pointsPopup.lastLevel = (this.monster as Pet).currentPlayLevelPoints;
            this._pointsPopup.currPoints = this.monster.clickItemData.PlayPoints;
         }
         else if(this._pointsPopup.initialized)
         {
            this._pointsPopup.update(this.monster.clickItemData.PlayPoints,(this.monster as Pet).nextPlayLevelPoints,(this.monster as Pet).currentPlayLevelPoints);
         }
         return this._pointsPopup;
      }
      
      private function get trickSelector() : TrickSelector
      {
         if(this._trickSelector == null)
         {
            this._trickSelector = new TrickSelector();
            this._trickSelector.selectedCallback = this.trickSelected;
         }
         return this._trickSelector;
      }
      
      public function get foodSelector() : FoodSelector
      {
         this._foodSelector = new FoodSelector();
         if(this.monster.IS_PLANT)
         {
            this._foodSelector.init(this.monster,MSPLocaleManagerWeb.getInstance().getString("PLANT_HUNGRY",[this.monster.FOODPRICE]),MSPLocaleManagerWeb.getInstance().getString("PLANT_FEED1"),MSPLocaleManagerWeb.getInstance().getString("PLANT_FEED2"),this.onBtnFoodClick,this.onBtnVIPFoodClick,Config.toAbsoluteURL("swf/games/plant_eat.swf",Config.LOCAL_CDN_URL),Config.toAbsoluteURL("swf/games/plant_eat_vip.swf",Config.LOCAL_CDN_URL));
         }
         else
         {
            this._foodSelector.init(this.monster,MSPLocaleManagerWeb.getInstance().getString("HUNGRY",[this.monster.FOODPRICE]),MSPLocaleManagerWeb.getInstance().getString("FEED1"),MSPLocaleManagerWeb.getInstance().getString("FEED2"),this.onBtnFoodClick,this.onBtnVIPFoodClick,Config.toAbsoluteURL("swf/games/icon_eat00.swf",Config.LOCAL_CDN_URL),Config.toAbsoluteURL("swf/games/icon_eat01.swf",Config.LOCAL_CDN_URL));
         }
         return this._foodSelector;
      }
      
      private function onBtnFeedClick() : void
      {
         if(this.btnFeed != null)
         {
            OldPopupHandler.getInstance().showFakePopup(this.foodSelector,this.btnFeed.x,this.btnFeed.y,false,false,this);
         }
         else
         {
            OldPopupHandler.getInstance().showFakePopup(this.foodSelector,this.btnWaitEat.x,this.btnWaitEat.y,false,false,this);
         }
      }
      
      public function onBtnFoodClick() : void
      {
         if(ActorSession.loggedInActor.Money < this.monster.FOODPRICE)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NOT_ENOUGH_STARCOINS"));
            return;
         }
         this.feedMonster(1);
      }
      
      public function onBtnVIPFoodClick() : void
      {
         if(ActorSession.isVip)
         {
            if(ActorSession.loggedInActor.Money < this.monster.FOODPRICE)
            {
               Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NOT_ENOUGH_STARCOINS"));
               return;
            }
            this.feedMonster(2);
         }
         else if(this.monster.IS_PLANT)
         {
            VIPOnlyPopUp.Show(MSPLocaleManagerWeb.getInstance().getString("ONLY_VIP_FERTILIZER"));
         }
         else
         {
            VIPOnlyPopUp.Show(MSPLocaleManagerWeb.getInstance().getString("ONLY_VIP_FOOD"));
         }
      }
      
      private function onBtnPetBoonie() : void
      {
         this.monster.pet();
         closeCurrent();
      }
      
      private function onBtnPlay() : void
      {
         (this.monster as Pet).playBall();
         closeCurrent();
      }
      
      private function onBtnWash() : void
      {
         (this.monster as Pet).wash();
         closeCurrent();
      }
      
      private function onLevelClick() : void
      {
         if(this.monster is Pet)
         {
            OldPopupHandler.getInstance().showFakePopup(this.pointsPopup,this.width - this._pointsPopup.width,this.lblLevel.y,false,false,this);
         }
      }
      
      private function onBtnTricks(param1:MSP_ClickImage) : void
      {
         var _loc3_:Rectangle = null;
         var _loc4_:Number = NaN;
         var _loc2_:Array = (this.monster as Pet).tricks;
         if(_loc2_.length > 0)
         {
            _loc3_ = this.getBounds(parent);
            _loc4_ = _loc3_.x + _loc3_.width - this.trickSelector.width;
            OldPopupHandler.getInstance().showFakePopup(this.trickSelector,_loc4_,this.y + param1.y,false,true,this.parent as UIComponent);
            this.trickSelector.update((this.monster as Pet).tricks);
         }
      }
      
      public function trickSelected(param1:int) : void
      {
         (this.monster as Pet).broadcastTrick(param1);
         closeCurrent();
      }
      
      private function onBtnFriendPetBoonie() : void
      {
         var done:Function = null;
         done = function(param1:int):void
         {
            MangroveAnalytics.registerPetGive(0,param1);
            if(param1 > 0)
            {
               MessageCommunicator.send(new QuestEvent(QuestEvent.SPECIAL_QUEST_UPDATE,{
                  "action":QuestEvent.ACTION_LOVE_PET,
                  "increment":1
               }));
               AnalyticsReceiveCurrencyCommand.execute(AnalyticsConstants.EARN_SC_SOCIAL_PET_OTHERS_OLDPETS,param1);
               ActorReload.getInstance().requestReload();
               DisplayUtils.showMoneyImage(param1.toString(),monster);
            }
         };
         this.monster.pet();
         closeCurrent();
         new PetAMFService().PetFriendPet(ActorSession.loggedInActor.ActorId,this.monster.clickItemData.ActorClickItemRelId,done);
      }
      
      private function onBtnMedicinClick() : void
      {
         var done:Function = null;
         done = function():void
         {
            btnMedicin.enabled = true;
         };
         if(ActorSession.loggedInActor.Money < this.monster.MEDICINPRICE)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NOT_ENOUGH_STARCOINS"));
            return;
         }
         this.btnMedicin.enabled = false;
         this.monster.curePet(done);
      }
      
      private function onBtnHatchClick() : void
      {
         this.monster.hatch();
         this.close();
      }
      
      private function onHarvest() : void
      {
         var closeHandler:Function = null;
         closeHandler = function(param1:PromptEvent):void
         {
            var done:Function;
            var event:PromptEvent = param1;
            if(event.detail == Prompt.YES)
            {
               done = function(param1:int):void
               {
                  AnalyticsReceiveCurrencyCommand.execute(AnalyticsConstants.EARN_SC_SINGLE_HARVEST_PLANT,AnalyticsStarcoinsAmount.HARVEST_PLANT);
                  MessageCommunicator.sendMessage(EditMyRoom.E_CLICKITEM_LIST_CHANGED,null);
                  ActorReload.getInstance().requestReload();
               };
               close();
               monster.parent.removeChild(monster);
               new PetAMFService().HarvestPlant(ActorSession.getActorId(),monster.clickItemData.ActorClickItemRelId,done);
            }
         };
         Prompt.show(MSPLocaleManagerWeb.getInstance().getString("HARVEST",["800"]),"",Prompt.YES | Prompt.CANCEL,null,closeHandler,null,Prompt.CANCEL);
      }
      
      private function feedMonster(param1:int) : void
      {
         var done:Function = null;
         var foodpoints:int = param1;
         done = function(param1:int):void
         {
            ActorValueManager.getInstance().addValue(ActorValueType.STARCOINS,-monster.FOODPRICE);
            btnFeed.enabled = true;
            if(param1 > 0)
            {
               AwardVisualizationController.spawnAwardsFromType(AwardVisualizationType.SCREEN_CENTER,0,param1,0);
            }
         };
         this.btnFeed.enabled = false;
         this.monster.feed(foodpoints,done);
         closeCurrent();
      }
      
      private function giveName() : void
      {
         this.btnName.visible = false;
         this.txtName.visible = true;
         this.txtName.text = this.lblName.label;
         this.btnSave.visible = true;
         this.lblName.visible = false;
         this.lblLevel.visible = false;
         this.txtName.setFocus();
      }
      
      private function saveName() : void
      {
         if(!this.btnSave.visible)
         {
            return;
         }
         if(this.txtName.text.length <= 0)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("PLEASE_ENTER_NAME"));
            return;
         }
         if(this.txtName.text.length > 58)
         {
            Prompt.show(MSPLocaleManagerWeb.getInstance().getString("NAME_LESS_THAN_X",["58"]));
            return;
         }
         if(txtUserNameErrorTip != null)
         {
            ToolTipManager.destroyToolTip(txtUserNameErrorTip);
            txtUserNameErrorTip = null;
         }
         UserBehaviorControl.getInstance().inputUserBehaviorFilterAndLog(this.txtName,this.inputUserBehaviorFilterCallback,ActorSession.getActorId(),String(0),InputLocations.LOC_PETNAME,false);
      }
      
      private function inputUserBehaviorFilterCallback(param1:UserBehaviorResult) : void
      {
         if(!param1.isSafe)
         {
            txtUserNameErrorTip = Utils.ShowErrorTip(this.txtName,MSPLocaleManagerWeb.getInstance().getString("NAME_NOT_ALLOWED"));
            return;
         }
         Censor.logInput(this.txtName.text,InputLocations.LOC_CONTENT_NAME,"pet");
         var _loc2_:String = UserBehaviorMessageFormatter.getInstance().embedFilteredMessages2(this.txtName.text,param1);
         new PetAMFService().SaveClickItemName(this._monster.clickItemData.ActorClickItemRelId,_loc2_);
         this._monster.clickItemData.Name = _loc2_;
         this.btnSave.visible = false;
         this.txtName.visible = false;
         this.lblName.label = this._monster.clickItemData.filteredName;
         this.lblName.visible = true;
         if(!this.monster.IS_PLANT)
         {
            this.lblLevel.visible = true;
         }
      }
      
      private function clickDeleteName() : void
      {
         var doDelete:Function = null;
         doDelete = function(param1:CloseEvent):void
         {
            var done:Function;
            var event:CloseEvent = param1;
            if(event.detail == Alert.YES)
            {
               done = function(param1:int):void
               {
                  if(param1 == 0)
                  {
                     Alert.show("Delete successful.","Delete Pet Name",4);
                     AdminModuleManager.getInstance().giveAutoWarning(_monster.clickItemData.ActorId,MSPLocaleManagerWeb.getInstance().getString("VIOLATED_RULES_PETNAME"),InputLocations.LOC_PETNAME);
                  }
                  else
                  {
                     Alert.show("Delete failed.","Delete Pet Name",4);
                  }
               };
               new PetAMFService().deletePetName(_monster.clickItemData.ActorClickItemRelId,ActorSession.loggedInActor.Name,ActorSession.actorPassword,done);
            }
         };
         Alert.show("Are you sure you want to delete the pet name: " + this._monster.clickItemData.filteredName,"Delete Pet Name",Alert.YES | Alert.NO,null,doDelete,null,0);
      }
      
      public function ___MonsterPopup_GradientCanvas1_add(param1:FlexEvent) : void
      {
         this.onAdd();
      }
      
      public function ___MonsterPopup_GradientCanvas1_creationComplete(param1:FlexEvent) : void
      {
         this.creationComplete();
      }
      
      public function __normalView_creationComplete(param1:FlexEvent) : void
      {
         this.normalViewCreationComplete();
      }
      
      public function __btnFeed_click(param1:MouseEvent) : void
      {
         this.onBtnFeedClick();
      }
      
      public function __btnPet_click(param1:MouseEvent) : void
      {
         this.onBtnPetBoonie();
      }
      
      public function __btnPlay_click(param1:MouseEvent) : void
      {
         this.onBtnPlay();
      }
      
      public function __btnWash_click(param1:MouseEvent) : void
      {
         this.onBtnWash();
      }
      
      public function __btnTricks_click(param1:MouseEvent) : void
      {
         this.onBtnTricks(this.btnTricks);
      }
      
      public function __friendView_creationComplete(param1:FlexEvent) : void
      {
         this.friendViewCreationComplete();
      }
      
      public function __btnFriendPet_click(param1:MouseEvent) : void
      {
         this.onBtnFriendPetBoonie();
      }
      
      public function __waitView_creationComplete(param1:FlexEvent) : void
      {
         this.waitViewCreationComplete();
      }
      
      public function __btnWaitEat_click(param1:MouseEvent) : void
      {
         this.onBtnFeedClick();
      }
      
      public function __btnWaitPet_click(param1:MouseEvent) : void
      {
         this.onBtnPetBoonie();
      }
      
      public function __btnWaitPlay_click(param1:MouseEvent) : void
      {
         this.onBtnPlay();
      }
      
      public function __btnWaitWash_click(param1:MouseEvent) : void
      {
         this.onBtnWash();
      }
      
      public function __btnWaitTricks_click(param1:MouseEvent) : void
      {
         this.onBtnTricks(this.btnWaitTricks);
      }
      
      public function __btnHarvest_click(param1:MouseEvent) : void
      {
         this.onHarvest();
      }
      
      public function __sickView_creationComplete(param1:FlexEvent) : void
      {
         this.sickViewCreationComplete();
      }
      
      public function __btnMedicin_click(param1:MouseEvent) : void
      {
         this.onBtnMedicinClick();
      }
      
      public function __eggView_creationComplete(param1:FlexEvent) : void
      {
         this.eggViewCreationComplete();
      }
      
      public function __btnHatch_click(param1:MouseEvent) : void
      {
         this.onBtnHatchClick();
      }
      
      public function __btnDeleteName_click(param1:MouseEvent) : void
      {
         this.clickDeleteName();
      }
      
      public function __lblName_click(param1:MouseEvent) : void
      {
         this.giveName();
      }
      
      public function __btnName_click(param1:MouseEvent) : void
      {
         this.giveName();
      }
      
      public function __btnSave_click(param1:MouseEvent) : void
      {
         this.saveName();
      }
      
      public function __lblLevel_click(param1:MouseEvent) : void
      {
         this.onLevelClick();
      }
      
      public function ___MonsterPopup_CloseButton1_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function _MonsterPopup_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():INavigatorContent
         {
            return getView(monster.healthStatus);
         },null,"viewStack.selectedChild");
         result[1] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_eat00.swf",Config.LOCAL_CDN_URL);
         },null,"btnFeed.source");
         result[2] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_pet00.swf",Config.LOCAL_CDN_URL);
         },null,"btnPet.source");
         result[3] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_play00.swf",Config.LOCAL_CDN_URL);
         },null,"btnPlay.source");
         result[4] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_wash00.swf",Config.LOCAL_CDN_URL);
         },null,"btnWash.source");
         result[5] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_tricks00.swf",Config.LOCAL_CDN_URL);
         },null,"btnTricks.source");
         result[6] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_pet00.swf",Config.LOCAL_CDN_URL);
         },null,"btnFriendPet.source");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = formatWaitMessage(monster.healthStatus);
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"waitLabel.text");
         result[8] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_eat00.swf",Config.LOCAL_CDN_URL);
         },null,"btnWaitEat.source");
         result[9] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_pet00.swf",Config.LOCAL_CDN_URL);
         },null,"btnWaitPet.source");
         result[10] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_play00.swf",Config.LOCAL_CDN_URL);
         },null,"btnWaitPlay.source");
         result[11] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_wash00.swf",Config.LOCAL_CDN_URL);
         },null,"btnWaitWash.source");
         result[12] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_tricks00.swf",Config.LOCAL_CDN_URL);
         },null,"btnWaitTricks.source");
         result[13] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("img/Used/icon_havest.png",Config.LOCAL_CDN_URL);
         },null,"iconHarvest.source");
         result[14] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("swf/games/icon_getmedicine00.swf",Config.LOCAL_CDN_URL);
         },null,"iconSickMedicin.source");
         result[15] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("img/icons/garbage can.png",Config.LOCAL_CDN_URL);
         },null,"btnDeleteName.source");
         result[16] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("GIVE_NAME");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnName.label");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("SAVE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnSave.label");
         result[18] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("TOOLTIP_PET_LEVEL");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"lblLevel.toolTip");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnDeleteName() : MSP_ClickImage
      {
         return this._1528250798btnDeleteName;
      }
      
      public function set btnDeleteName(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._1528250798btnDeleteName;
         if(_loc2_ !== param1)
         {
            this._1528250798btnDeleteName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnDeleteName",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnFeed() : MSP_ClickImage
      {
         return this._205802010btnFeed;
      }
      
      public function set btnFeed(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._205802010btnFeed;
         if(_loc2_ !== param1)
         {
            this._205802010btnFeed = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnFeed",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnFriendPet() : MSP_ClickImage
      {
         return this._1825453403btnFriendPet;
      }
      
      public function set btnFriendPet(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._1825453403btnFriendPet;
         if(_loc2_ !== param1)
         {
            this._1825453403btnFriendPet = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnFriendPet",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnHarvest() : Button
      {
         return this._492485267btnHarvest;
      }
      
      public function set btnHarvest(param1:Button) : void
      {
         var _loc2_:Object = this._492485267btnHarvest;
         if(_loc2_ !== param1)
         {
            this._492485267btnHarvest = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnHarvest",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnHatch() : Button
      {
         return this._2086637380btnHatch;
      }
      
      public function set btnHatch(param1:Button) : void
      {
         var _loc2_:Object = this._2086637380btnHatch;
         if(_loc2_ !== param1)
         {
            this._2086637380btnHatch = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnHatch",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnMedicin() : Button
      {
         return this._248736369btnMedicin;
      }
      
      public function set btnMedicin(param1:Button) : void
      {
         var _loc2_:Object = this._248736369btnMedicin;
         if(_loc2_ !== param1)
         {
            this._248736369btnMedicin = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnMedicin",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnName() : LinkButton
      {
         return this._206036743btnName;
      }
      
      public function set btnName(param1:LinkButton) : void
      {
         var _loc2_:Object = this._206036743btnName;
         if(_loc2_ !== param1)
         {
            this._206036743btnName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnName",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnPet() : MSP_ClickImage
      {
         return this._1378824925btnPet;
      }
      
      public function set btnPet(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._1378824925btnPet;
         if(_loc2_ !== param1)
         {
            this._1378824925btnPet = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnPet",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnPlay() : MSP_ClickImage
      {
         return this._206106544btnPlay;
      }
      
      public function set btnPlay(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._206106544btnPlay;
         if(_loc2_ !== param1)
         {
            this._206106544btnPlay = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnPlay",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSave() : Button
      {
         return this._206185977btnSave;
      }
      
      public function set btnSave(param1:Button) : void
      {
         var _loc2_:Object = this._206185977btnSave;
         if(_loc2_ !== param1)
         {
            this._206185977btnSave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSave",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnTricks() : MSP_ClickImage
      {
         return this._620171516btnTricks;
      }
      
      public function set btnTricks(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._620171516btnTricks;
         if(_loc2_ !== param1)
         {
            this._620171516btnTricks = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnTricks",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnWaitEat() : MSP_ClickImage
      {
         return this._73234521btnWaitEat;
      }
      
      public function set btnWaitEat(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._73234521btnWaitEat;
         if(_loc2_ !== param1)
         {
            this._73234521btnWaitEat = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnWaitEat",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnWaitPet() : MSP_ClickImage
      {
         return this._73223826btnWaitPet;
      }
      
      public function set btnWaitPet(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._73223826btnWaitPet;
         if(_loc2_ !== param1)
         {
            this._73223826btnWaitPet = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnWaitPet",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnWaitPlay() : MSP_ClickImage
      {
         return this._2025034949btnWaitPlay;
      }
      
      public function set btnWaitPlay(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._2025034949btnWaitPlay;
         if(_loc2_ !== param1)
         {
            this._2025034949btnWaitPlay = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnWaitPlay",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnWaitTricks() : MSP_ClickImage
      {
         return this._558679249btnWaitTricks;
      }
      
      public function set btnWaitTricks(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._558679249btnWaitTricks;
         if(_loc2_ !== param1)
         {
            this._558679249btnWaitTricks = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnWaitTricks",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnWaitWash() : MSP_ClickImage
      {
         return this._2025233456btnWaitWash;
      }
      
      public function set btnWaitWash(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._2025233456btnWaitWash;
         if(_loc2_ !== param1)
         {
            this._2025233456btnWaitWash = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnWaitWash",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnWash() : MSP_ClickImage
      {
         return this._206305051btnWash;
      }
      
      public function set btnWash(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._206305051btnWash;
         if(_loc2_ !== param1)
         {
            this._206305051btnWash = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnWash",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get eggView() : Canvas
      {
         return this._1804817334eggView;
      }
      
      public function set eggView(param1:Canvas) : void
      {
         var _loc2_:Object = this._1804817334eggView;
         if(_loc2_ !== param1)
         {
            this._1804817334eggView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"eggView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get foodPointCanvas() : Canvas
      {
         return this._2132811722foodPointCanvas;
      }
      
      public function set foodPointCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._2132811722foodPointCanvas;
         if(_loc2_ !== param1)
         {
            this._2132811722foodPointCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"foodPointCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get friendView() : Canvas
      {
         return this._1756611997friendView;
      }
      
      public function set friendView(param1:Canvas) : void
      {
         var _loc2_:Object = this._1756611997friendView;
         if(_loc2_ !== param1)
         {
            this._1756611997friendView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"friendView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconHarvest() : Image
      {
         return this._57007280iconHarvest;
      }
      
      public function set iconHarvest(param1:Image) : void
      {
         var _loc2_:Object = this._57007280iconHarvest;
         if(_loc2_ !== param1)
         {
            this._57007280iconHarvest = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconHarvest",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconSickMedicin() : Image
      {
         return this._1039259084iconSickMedicin;
      }
      
      public function set iconSickMedicin(param1:Image) : void
      {
         var _loc2_:Object = this._1039259084iconSickMedicin;
         if(_loc2_ !== param1)
         {
            this._1039259084iconSickMedicin = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconSickMedicin",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblFoodPoints() : Label
      {
         return this._1159239369lblFoodPoints;
      }
      
      public function set lblFoodPoints(param1:Label) : void
      {
         var _loc2_:Object = this._1159239369lblFoodPoints;
         if(_loc2_ !== param1)
         {
            this._1159239369lblFoodPoints = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblFoodPoints",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblLevel() : LinkButton
      {
         return this._808735890lblLevel;
      }
      
      public function set lblLevel(param1:LinkButton) : void
      {
         var _loc2_:Object = this._808735890lblLevel;
         if(_loc2_ !== param1)
         {
            this._808735890lblLevel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblLevel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblName() : LinkButton
      {
         return this._26032799lblName;
      }
      
      public function set lblName(param1:LinkButton) : void
      {
         var _loc2_:Object = this._26032799lblName;
         if(_loc2_ !== param1)
         {
            this._26032799lblName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblName",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblNameFriends() : Label
      {
         return this._547060980lblNameFriends;
      }
      
      public function set lblNameFriends(param1:Label) : void
      {
         var _loc2_:Object = this._547060980lblNameFriends;
         if(_loc2_ !== param1)
         {
            this._547060980lblNameFriends = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblNameFriends",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lblSick() : Label
      {
         return this._25876460lblSick;
      }
      
      public function set lblSick(param1:Label) : void
      {
         var _loc2_:Object = this._25876460lblSick;
         if(_loc2_ !== param1)
         {
            this._25876460lblSick = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lblSick",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get normalView() : Canvas
      {
         return this._1255628756normalView;
      }
      
      public function set normalView(param1:Canvas) : void
      {
         var _loc2_:Object = this._1255628756normalView;
         if(_loc2_ !== param1)
         {
            this._1255628756normalView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"normalView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sickView() : Canvas
      {
         return this._194100483sickView;
      }
      
      public function set sickView(param1:Canvas) : void
      {
         var _loc2_:Object = this._194100483sickView;
         if(_loc2_ !== param1)
         {
            this._194100483sickView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sickView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get statusBar() : Canvas
      {
         return this._2070227263statusBar;
      }
      
      public function set statusBar(param1:Canvas) : void
      {
         var _loc2_:Object = this._2070227263statusBar;
         if(_loc2_ !== param1)
         {
            this._2070227263statusBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statusBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleBar() : Canvas
      {
         return this._1870028133titleBar;
      }
      
      public function set titleBar(param1:Canvas) : void
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
      public function get txtName() : TextInputRestricted
      {
         return this._878708453txtName;
      }
      
      public function set txtName(param1:TextInputRestricted) : void
      {
         var _loc2_:Object = this._878708453txtName;
         if(_loc2_ !== param1)
         {
            this._878708453txtName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtName",_loc2_,param1));
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
      
      [Bindable(event="propertyChange")]
      public function get waitLabel() : Label
      {
         return this._992043393waitLabel;
      }
      
      public function set waitLabel(param1:Label) : void
      {
         var _loc2_:Object = this._992043393waitLabel;
         if(_loc2_ !== param1)
         {
            this._992043393waitLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"waitLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get waitView() : Canvas
      {
         return this._245398970waitView;
      }
      
      public function set waitView(param1:Canvas) : void
      {
         var _loc2_:Object = this._245398970waitView;
         if(_loc2_ !== param1)
         {
            this._245398970waitView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"waitView",_loc2_,param1));
            }
         }
      }
      
      public function set monster(param1:Monster) : void
      {
         var _loc2_:Object = this.monster;
         if(_loc2_ !== param1)
         {
            this._1236617178monster = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"monster",_loc2_,param1));
            }
         }
      }
   }
}

