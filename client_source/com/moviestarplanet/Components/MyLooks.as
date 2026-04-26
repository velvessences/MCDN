package com.moviestarplanet.Components
{
   import com.moviestarplanet.dressing.DressingModuleManager;
   import com.moviestarplanet.look.service.LookAMFService;
   import com.moviestarplanet.look.valueobjects.LookItem;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import com.moviestarplanet.utils.translation.MSPLocaleManagerWeb;
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
   import mx.containers.VBox;
   import mx.controls.Label;
   import mx.controls.LinkButton;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class MyLooks extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      public static var usingSnapShotsSinceId:Number = 100000;
      
      public var _MyLooks_Label1:Label;
      
      private var _1108221639btnCreateNewLook:MSP_ClickCanvas;
      
      private var _602415628comments:CommentsComponent;
      
      private var _1139249195lnkbtnNextPage:LinkButton;
      
      private var _456910613lnkbtnPrevPage:LinkButton;
      
      private var _1143315189myLooksEditor:MyLooksEditor;
      
      private var _1154332222pagerButtons:HBox;
      
      private var _3613077vbox:VBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      protected var pager:Pager;
      
      public var pageSize:Number = 3;
      
      public var _actorId:Number = -1;
      
      public var actorName:String = "";
      
      public var _lookOrderBy:String = "id";
      
      public var _startLookId:Number = -1;
      
      private var _looks:Array;
      
      private var _currentLook:LookItem;
      
      public var serverCall:Function;
      
      public var exitCall:Function;
      
      public var createNewLookClickCall:Function;
      
      public var creatorMode:Boolean = false;
      
      private var loading:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function MyLooks()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "creationComplete":"___MyLooks_Canvas1_creationComplete",
               "hide":"___MyLooks_Canvas1_hide",
               "show":"___MyLooks_Canvas1_show"
            },
            "stylesFactory":function():void
            {
               this.backgroundAlpha = 0;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "bottom":36,
                        "top":19,
                        "left":5,
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "width":288,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.cornerRadius = 0;
                              this.borderStyle = "none";
                              this.horizontalGap = -10;
                              this.horizontalAlign = "right";
                              this.verticalAlign = "middle";
                              this.textDecoration = "none";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "left":10,
                                 "width":288,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"pagerButtons",
                                    "stylesFactory":function():void
                                    {
                                       this.cornerRadius = 0;
                                       this.borderStyle = "none";
                                       this.horizontalGap = -10;
                                       this.horizontalAlign = "right";
                                       this.verticalAlign = "middle";
                                       this.textDecoration = "none";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":20,
                                          "left":10,
                                          "width":49,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":LinkButton,
                                             "id":"lnkbtnPrevPage",
                                             "events":{"click":"__lnkbtnPrevPage_click"},
                                             "stylesFactory":function():void
                                             {
                                                this.textDecoration = "none";
                                                this.paddingRight = 0;
                                                this.paddingLeft = 0;
                                                this.fontSize = 10;
                                                this.fontWeight = "bold";
                                                this.color = 16777215;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "enabled":false,
                                                   "label":"<",
                                                   "width":30
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":LinkButton,
                                             "id":"lnkbtnNextPage",
                                             "events":{"click":"__lnkbtnNextPage_click"},
                                             "stylesFactory":function():void
                                             {
                                                this.textDecoration = "none";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.fontSize = 10;
                                                this.fontWeight = "bold";
                                                this.color = 16777215;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "enabled":false,
                                                   "label":">",
                                                   "width":26
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"vbox",
                           "stylesFactory":function():void
                           {
                              this.verticalGap = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentHeight":100,
                                 "percentWidth":100,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":MSP_ClickCanvas,
                  "id":"btnCreateNewLook",
                  "events":{"click":"__btnCreateNewLook_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "height":30,
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "CanvasBackGroundColor":"0xAB407E",
                        "CanvasBackGroundAlpha":0.9,
                        "buttonMode":true,
                        "useHandCursor":true,
                        "bottom":5,
                        "left":5,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.cornerRadius = 0;
                              this.borderStyle = "none";
                              this.horizontalAlign = "center";
                              this.verticalAlign = "middle";
                              this.paddingLeft = 5;
                              this.paddingRight = 5;
                              this.paddingTop = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MyLooks_Label1",
                                    "stylesFactory":function():void
                                    {
                                       this.fontFamily = "EmbedBADABB";
                                       this.fontSize = 20;
                                       this.color = 16777215;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "visible":true,
                                          "includeInLayout":true,
                                          "percentWidth":100,
                                          "buttonMode":true,
                                          "useHandCursor":true,
                                          "mouseChildren":false
                                       };
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":MyLooksEditor,
                  "id":"myLooksEditor",
                  "events":{
                     "creationComplete":"__myLooksEditor_creationComplete",
                     "hide":"__myLooksEditor_hide",
                     "show":"__myLooksEditor_show"
                  },
                  "stylesFactory":function():void
                  {
                     this.borderColor = 12040892;
                     this.borderStyle = "solid";
                     this.borderThickness = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":280,
                        "visible":true,
                        "horizontalCenter":0,
                        "bottom":2,
                        "top":5
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":CommentsComponent,
                  "id":"comments",
                  "stylesFactory":function():void
                  {
                     this.borderStyle = "none";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"",
                        "ChatLogRoomId":14,
                        "ItemHeight":133,
                        "ItemWidth":288,
                        "top":10,
                        "bottom":5,
                        "right":5,
                        "width":288,
                        "verticalScrollPolicy":"off",
                        "horizontalScrollPolicy":"off",
                        "ItemType":"mylooks"
                     };
                  }
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         bindings = this._MyLooks_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_Components_MyLooksWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return MyLooks[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___MyLooks_Canvas1_creationComplete);
         this.addEventListener("hide",this.___MyLooks_Canvas1_hide);
         this.addEventListener("show",this.___MyLooks_Canvas1_show);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         MyLooks._watcherSetupUtil = param1;
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
      
      private function OnCreationComplete(param1:Event) : void
      {
         if(this.actorId < 0)
         {
            this.actorId = ActorSession.getActorId();
         }
         this.comments.isDeleteVisible = this.actorId == ActorSession.getActorId() || ActorSession.isModerator();
         this.update();
      }
      
      private function enter() : void
      {
      }
      
      private function onHide() : void
      {
         MSP_LoaderManager.Reset(false);
      }
      
      public function CreateNewLook() : void
      {
         this.myLooksEditor.ActorId = this.actorId;
         this.myLooksEditor.Look = null;
         this.comments.Exit();
         this.comments.canCreateComments = false;
         this.myLooksEditor.creatorId = ActorSession.getActorId();
         this.myLooksEditor.visible = true;
         this._currentLook = this.myLooksEditor._look;
         this.openDressingRoom();
      }
      
      private function openDressingRoom() : void
      {
         var closed:Function = null;
         closed = function(param1:Array):void
         {
            if(param1 != null)
            {
               myLooksEditor.setMovieStarClothes(param1);
               myLooksEditor.txtHeadline.setFocus();
            }
            else
            {
               myLooksEditor.restoreMyLook();
            }
         };
         var comingFromLooksOverview:Boolean = true;
         DressingModuleManager.getInstance().openDressingRoom(this.actorId,closed,comingFromLooksOverview);
      }
      
      public function set actorId(param1:Number) : void
      {
         if(param1 != this._actorId)
         {
            this._actorId = param1;
         }
      }
      
      public function get actorId() : Number
      {
         return this._actorId;
      }
      
      public function set startLookId(param1:Number) : void
      {
         if(param1 != this._startLookId)
         {
            this._startLookId = param1;
            if(initialized)
            {
               this.updateStartLook();
            }
         }
      }
      
      public function get startLookId() : Number
      {
         return this._startLookId;
      }
      
      public function updateStartLook() : void
      {
         var done:Function;
         var params:Array = null;
         if(this._startLookId > 0)
         {
            done = function(param1:LookItem):void
            {
               if(param1 != null)
               {
                  _currentLook = param1;
                  myLooksEditor.ActorId = _currentLook.ActorId;
                  myLooksEditor.Look = _currentLook;
                  myLooksEditor.ManageVisible();
               }
               loading = false;
            };
            this.loading = true;
            params = new Array();
            params.push("look",this._startLookId);
            this.comments.Params = params;
            this.comments.Refresh();
            new LookAMFService().GetLookById(this._startLookId,done);
         }
      }
      
      public function update() : void
      {
         var _loc1_:Array = null;
         if(initialized)
         {
            if(this._startLookId > 0)
            {
               _loc1_ = new Array();
               _loc1_.push("look",this._startLookId);
               this.comments.Params = _loc1_;
               this.comments.Refresh();
               new LookAMFService().GetLookById(this._startLookId,this.updateLookPages);
            }
            else
            {
               this.updateLookPages(null);
            }
         }
      }
      
      public function updateLookPages(param1:LookItem) : void
      {
         if(param1 != null && this._currentLook == null)
         {
            this._currentLook = param1;
         }
         var _loc2_:Array = new Array();
         _loc2_.push(this._actorId,this._lookOrderBy);
         this.pager = new Pager(this.pageSize,this.serverCall,_loc2_);
         this.pager.FirstPage(this.UpdateData);
      }
      
      protected function UpdateData(param1:Array) : void
      {
         var _loc2_:LookListItemComponent = null;
         var _loc3_:LookItem = null;
         var _loc4_:LookListItemComponent = null;
         var _loc5_:Array = null;
         this.vbox.removeAllChildren();
         this._looks = param1;
         if(this._looks != null && this._looks.length > 0)
         {
            for each(_loc3_ in param1)
            {
               _loc4_ = new LookListItemComponent();
               _loc4_.clickListener = this.LookItemClicked;
               _loc4_.look = _loc3_;
               _loc4_.name = "lookitem" + _loc3_.LookId.toString();
               _loc4_.myLooks = this;
               _loc4_.creatorMode = this.creatorMode;
               this.vbox.addChild(_loc4_);
               _loc2_ = _loc4_;
            }
            _loc2_.hrule.visible = false;
            if(this._currentLook == null && !this.loading)
            {
               this._currentLook = this._looks[0];
               _loc5_ = new Array();
               _loc5_.push("look",this._currentLook.LookId);
               this.comments.Params = _loc5_;
               this.comments.Refresh();
            }
            if(this._currentLook != null && (this.myLooksEditor._look == null || this._currentLook.LookId != this.myLooksEditor._look.LookId))
            {
               this.myLooksEditor.ActorId = this._currentLook.ActorId;
               this.myLooksEditor.Look = this._currentLook;
               this.myLooksEditor.ManageVisible();
            }
            this.UpdateButtons();
         }
         else
         {
            if(this.creatorMode)
            {
               this.myLooksEditor.visible = false;
               if(this.actorId == ActorSession.loggedInActor.ActorId)
               {
                  Prompt.showFriendly(MSPLocaleManagerWeb.getInstance().getString("LOOKS_HOW_TO_CREATE_FOR_OTHERS"));
               }
               else
               {
                  Prompt.show(MSPLocaleManagerWeb.getInstance().getString("LOOKS_NO_LOOKS_OF_FRIENDS",[this.actorName]));
               }
            }
            else
            {
               this.myLooksEditor.ActorId = this.actorId;
               if(this._currentLook == null)
               {
                  this.myLooksEditor.Look = null;
               }
               this.myLooksEditor.ManageVisible();
            }
            if(this._currentLook == null)
            {
               this.myLooksEditor.visible = false;
            }
            this.UpdateButtons();
         }
      }
      
      public function RefreshData(param1:LookItem) : void
      {
         if(param1 != null)
         {
            this._currentLook = param1;
         }
         var _loc2_:Array = new Array();
         _loc2_.push(this._actorId,this._lookOrderBy);
         this.pager = new Pager(this.pageSize,this.serverCall,_loc2_);
         this.pager.FirstPage(this.UpdateData);
         if(this._currentLook != null && this._currentLook.LookId > 0)
         {
            this.comments.canCreateComments = true;
            this.comments.Params = ["look",this._currentLook.LookId];
            this.comments.Refresh();
         }
         else
         {
            this.comments.Exit();
            this.comments.canCreateComments = false;
         }
      }
      
      public function RefreshLookItem(param1:LookItem) : void
      {
         var _loc2_:LookListItemComponent = this.vbox.getChildByName("lookitem" + param1.LookId.toString()) as LookListItemComponent;
         if(_loc2_ != null)
         {
            _loc2_.look = param1;
         }
      }
      
      private function LookItemClicked(param1:MouseEvent) : void
      {
         var _loc2_:LookListItemComponent = null;
         if(param1.currentTarget as MSP_ClickImage)
         {
            _loc2_ = (param1.currentTarget as MSP_ClickImage).parent as LookListItemComponent;
         }
         if(param1.currentTarget as LinkButton)
         {
            _loc2_ = (param1.currentTarget as LinkButton).parent as LookListItemComponent;
         }
         this._currentLook = _loc2_.look;
         var _loc3_:Array = new Array();
         _loc3_.push("look",this._currentLook.LookId);
         this.comments.Params = _loc3_;
         this.comments.Refresh();
         this.myLooksEditor.ActorId = this._currentLook.ActorId;
         this.myLooksEditor.Look = this._currentLook;
         this.myLooksEditor.ManageVisible();
      }
      
      private function UpdateButtons() : void
      {
         this.lnkbtnPrevPage.enabled = this.pager.IsAtFirstPage == false;
         this.lnkbtnNextPage.enabled = this.pager.IsAtLastPage == false;
      }
      
      private function GoToNextPage() : void
      {
         this.pager.NextPage(this.UpdateData);
      }
      
      private function GoToPrevPage() : void
      {
         this.pager.PrevPage(this.UpdateData);
      }
      
      public function ___MyLooks_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.OnCreationComplete(param1);
      }
      
      public function ___MyLooks_Canvas1_hide(param1:FlexEvent) : void
      {
         this.onHide();
      }
      
      public function ___MyLooks_Canvas1_show(param1:FlexEvent) : void
      {
         this.enter();
      }
      
      public function __lnkbtnPrevPage_click(param1:MouseEvent) : void
      {
         this.GoToPrevPage();
      }
      
      public function __lnkbtnNextPage_click(param1:MouseEvent) : void
      {
         this.GoToNextPage();
      }
      
      public function __btnCreateNewLook_click(param1:MouseEvent) : void
      {
         this.createNewLookClickCall();
      }
      
      public function __myLooksEditor_creationComplete(param1:FlexEvent) : void
      {
         this.OnCreationComplete(param1);
      }
      
      public function __myLooksEditor_hide(param1:FlexEvent) : void
      {
         this.onHide();
      }
      
      public function __myLooksEditor_show(param1:FlexEvent) : void
      {
         this.enter();
      }
      
      private function _MyLooks_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("CREATE_NEW_LOOK");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MyLooks_Label1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("ADD_COMMENT_TO_LOOK");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"comments.TitleText");
         result[2] = new Binding(this,function():Boolean
         {
            return ActorSession.isModerator();
         },null,"comments.isDeleteVisible");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnCreateNewLook() : MSP_ClickCanvas
      {
         return this._1108221639btnCreateNewLook;
      }
      
      public function set btnCreateNewLook(param1:MSP_ClickCanvas) : void
      {
         var _loc2_:Object = this._1108221639btnCreateNewLook;
         if(_loc2_ !== param1)
         {
            this._1108221639btnCreateNewLook = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnCreateNewLook",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get comments() : CommentsComponent
      {
         return this._602415628comments;
      }
      
      public function set comments(param1:CommentsComponent) : void
      {
         var _loc2_:Object = this._602415628comments;
         if(_loc2_ !== param1)
         {
            this._602415628comments = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"comments",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lnkbtnNextPage() : LinkButton
      {
         return this._1139249195lnkbtnNextPage;
      }
      
      public function set lnkbtnNextPage(param1:LinkButton) : void
      {
         var _loc2_:Object = this._1139249195lnkbtnNextPage;
         if(_loc2_ !== param1)
         {
            this._1139249195lnkbtnNextPage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lnkbtnNextPage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lnkbtnPrevPage() : LinkButton
      {
         return this._456910613lnkbtnPrevPage;
      }
      
      public function set lnkbtnPrevPage(param1:LinkButton) : void
      {
         var _loc2_:Object = this._456910613lnkbtnPrevPage;
         if(_loc2_ !== param1)
         {
            this._456910613lnkbtnPrevPage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lnkbtnPrevPage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get myLooksEditor() : MyLooksEditor
      {
         return this._1143315189myLooksEditor;
      }
      
      public function set myLooksEditor(param1:MyLooksEditor) : void
      {
         var _loc2_:Object = this._1143315189myLooksEditor;
         if(_loc2_ !== param1)
         {
            this._1143315189myLooksEditor = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"myLooksEditor",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get pagerButtons() : HBox
      {
         return this._1154332222pagerButtons;
      }
      
      public function set pagerButtons(param1:HBox) : void
      {
         var _loc2_:Object = this._1154332222pagerButtons;
         if(_loc2_ !== param1)
         {
            this._1154332222pagerButtons = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pagerButtons",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get vbox() : VBox
      {
         return this._3613077vbox;
      }
      
      public function set vbox(param1:VBox) : void
      {
         var _loc2_:Object = this._3613077vbox;
         if(_loc2_ !== param1)
         {
            this._3613077vbox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"vbox",_loc2_,param1));
            }
         }
      }
   }
}

