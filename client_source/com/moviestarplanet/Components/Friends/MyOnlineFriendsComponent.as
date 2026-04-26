package com.moviestarplanet.Components.Friends
{
   import com.moviestarplanet.Components.InviteNewUsers;
   import com.moviestarplanet.Forms.ActorOnlineStatusEvent;
   import com.moviestarplanet.anchorCharacters.AnchorCharacters;
   import com.moviestarplanet.friends.FriendsManager;
   import com.moviestarplanet.model.friends.IFriend;
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
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.List;
   import mx.controls.Text;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   import mx.utils.ObjectUtil;
   
   use namespace mx_internal;
   
   public class MyOnlineFriendsComponent extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private var _2049440364btn_Invite:Button;
      
      private var _1758880056labelNoFriendsYet:Text;
      
      private var _240266733labelNoOnlineFriends:Text;
      
      private var _3322014list:List;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _MyOnlineFriendsComponent_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function MyOnlineFriendsComponent()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___MyOnlineFriendsComponent_Canvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.backgroundColor = 0;
               this.backgroundAlpha = 0;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "center";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":0,
                        "bottom":5,
                        "right":10,
                        "left":10,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "id":"btn_Invite",
                           "events":{"click":"__btn_Invite_click"},
                           "stylesFactory":function():void
                           {
                              this.textAlign = "center";
                              this.color = 65793;
                              this.fillAlphas = [1,1];
                              this.fillColors = [16379731,14462267];
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "height":30,
                                 "visible":true,
                                 "enabled":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":List,
                           "id":"list",
                           "stylesFactory":function():void
                           {
                              this.rollOverColor = 6710886;
                              this.selectionColor = 8750469;
                              this.borderThickness = 0;
                              this.backgroundColor = 0;
                              this.backgroundAlpha = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"MOFList",
                                 "verticalScrollPolicy":"auto",
                                 "horizontalScrollPolicy":"off",
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "itemRenderer":_MyOnlineFriendsComponent_ClassFactory1_c()
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Text,
                  "id":"labelNoOnlineFriends",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":40,
                        "left":10,
                        "visible":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Text,
                  "id":"labelNoFriendsYet",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "top":40,
                        "left":10,
                        "visible":false
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
         bindings = this._MyOnlineFriendsComponent_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_Components_Friends_MyOnlineFriendsComponentWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return MyOnlineFriendsComponent[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___MyOnlineFriendsComponent_Canvas1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         MyOnlineFriendsComponent._watcherSetupUtil = param1;
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
            this.backgroundColor = 0;
            this.backgroundAlpha = 0;
         };
         mx_internal::_MyOnlineFriendsComponent_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function btn_Invite_ClickHandler() : void
      {
         InviteNewUsers.show();
      }
      
      private function creationCompleteHandler() : void
      {
         FriendsManager.getInstance().addListener(ActorOnlineStatusEvent.ON_ACTOR_ONLINE,this.actorOnlineHandler);
         FriendsManager.getInstance().addListener(ActorOnlineStatusEvent.ON_ACTOR_OFFLINE,this.actorOfflineHandler);
         this.populate();
      }
      
      protected function actorOnlineHandler(param1:ActorOnlineStatusEvent) : void
      {
         var _loc7_:String = null;
         this.labelNoFriendsYet.visible = false;
         this.labelNoOnlineFriends.visible = false;
         var _loc2_:Number = Number(this.list.verticalScrollPosition);
         var _loc3_:int = int(this.list.dataProvider.length);
         var _loc4_:String = param1.friend.name;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         while(_loc6_ < this.list.dataProvider.length && !_loc5_)
         {
            _loc7_ = IFriend(this.list.dataProvider[_loc6_]).name;
            if(ObjectUtil.stringCompare(_loc7_,_loc4_,true) > 0)
            {
               _loc5_ = true;
               _loc3_ = _loc6_;
            }
            _loc6_++;
         }
         this.list.dataProvider.addItemAt(param1.friend,_loc3_);
         this.list.verticalScrollPosition = _loc2_;
      }
      
      protected function actorOfflineHandler(param1:ActorOnlineStatusEvent) : void
      {
         var _loc2_:IFriend = null;
         try
         {
            for each(_loc2_ in this.list.dataProvider)
            {
               if(_loc2_.userId == param1.friend.userId)
               {
                  this.list.dataProvider.removeItemAt(this.list.dataProvider.getItemIndex(_loc2_.userId));
                  break;
               }
            }
         }
         catch(error:Error)
         {
         }
         if(this.list.dataProvider.length == 0)
         {
            this.labelNoFriendsYet.visible = false;
            this.labelNoOnlineFriends.visible = true;
         }
      }
      
      protected function populate() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:IFriend = null;
         this.list.dataProvider = new Array();
         if(FriendsManager.getInstance().getNumFriends() == 0)
         {
            this.labelNoFriendsYet.visible = true;
            this.labelNoOnlineFriends.visible = false;
         }
         else if(FriendsManager.getInstance().numFriendsOnline == 0 && FriendsManager.getInstance().getNumFriends() != 0)
         {
            this.labelNoFriendsYet.visible = false;
            this.labelNoOnlineFriends.visible = true;
         }
         else
         {
            this.labelNoFriendsYet.visible = false;
            this.labelNoOnlineFriends.visible = false;
            _loc1_ = Number(this.list.verticalScrollPosition);
            for each(_loc2_ in FriendsManager.getInstance().getOnlineFriends())
            {
               if(this.isAllowed(_loc2_))
               {
                  this.list.dataProvider.addItem(_loc2_);
               }
            }
            this.list.verticalScrollPosition = _loc1_;
         }
      }
      
      private function isAllowed(param1:IFriend) : Boolean
      {
         return !AnchorCharacters.isSpecialCharacter(param1.userId);
      }
      
      public function ___MyOnlineFriendsComponent_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.creationCompleteHandler();
      }
      
      public function __btn_Invite_click(param1:MouseEvent) : void
      {
         this.btn_Invite_ClickHandler();
      }
      
      private function _MyOnlineFriendsComponent_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = MyOnlineFriendsComponentInnerClass0;
         _loc1_.properties = {"outerDocument":this};
         return _loc1_;
      }
      
      private function _MyOnlineFriendsComponent_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("INVITE_FRIENDS_TO_JOIN");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btn_Invite.toolTip");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("INVITE_FRIENDS");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btn_Invite.label");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("NO_FRIENDS_ONLINE");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"labelNoOnlineFriends.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = MSPLocaleManagerWeb.getInstance().getString("NO_FRIENDS_YET");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"labelNoFriendsYet.text");
         return result;
      }
      
      mx_internal function _MyOnlineFriendsComponent_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         var conditions:Array = null;
         var condition:CSSCondition = null;
         var selector:CSSSelector = null;
         if(mx_internal::_MyOnlineFriendsComponent_StylesInit_done)
         {
            return;
         }
         mx_internal::_MyOnlineFriendsComponent_StylesInit_done = true;
         selector = null;
         conditions = null;
         conditions = [];
         condition = new CSSCondition("class","MOFList");
         conditions.push(condition);
         selector = new CSSSelector("",conditions,selector);
         style = styleManager.getStyleDeclaration(".MOFList");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.paddingBottom = 1;
               this.paddingTop = 0;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btn_Invite() : Button
      {
         return this._2049440364btn_Invite;
      }
      
      public function set btn_Invite(param1:Button) : void
      {
         var _loc2_:Object = this._2049440364btn_Invite;
         if(_loc2_ !== param1)
         {
            this._2049440364btn_Invite = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btn_Invite",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get labelNoFriendsYet() : Text
      {
         return this._1758880056labelNoFriendsYet;
      }
      
      public function set labelNoFriendsYet(param1:Text) : void
      {
         var _loc2_:Object = this._1758880056labelNoFriendsYet;
         if(_loc2_ !== param1)
         {
            this._1758880056labelNoFriendsYet = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"labelNoFriendsYet",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get labelNoOnlineFriends() : Text
      {
         return this._240266733labelNoOnlineFriends;
      }
      
      public function set labelNoOnlineFriends(param1:Text) : void
      {
         var _loc2_:Object = this._240266733labelNoOnlineFriends;
         if(_loc2_ !== param1)
         {
            this._240266733labelNoOnlineFriends = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"labelNoOnlineFriends",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get list() : List
      {
         return this._3322014list;
      }
      
      public function set list(param1:List) : void
      {
         var _loc2_:Object = this._3322014list;
         if(_loc2_ !== param1)
         {
            this._3322014list = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"list",_loc2_,param1));
            }
         }
      }
   }
}

