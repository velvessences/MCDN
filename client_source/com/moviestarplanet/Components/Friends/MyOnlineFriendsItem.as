package com.moviestarplanet.Components.Friends
{
   import com.moviestarplanet.Components.Character.CharacterContainer;
   import com.moviestarplanet.Components.MSP_ClickImage;
   import com.moviestarplanet.Components.MSP_Image;
   import com.moviestarplanet.configurations.Config;
   import com.moviestarplanet.globalsharedutils.SnapshotUrl;
   import com.moviestarplanet.messaging.ChatViewManager;
   import com.moviestarplanet.model.friends.IFriend;
   import com.moviestarplanet.utils.EntityTypeType;
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
   import mx.controls.HRule;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class MyOnlineFriendsItem extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private var _2078819916cnv_SnapshotAndText:Canvas;
      
      private var _2113764320img_ChatBubble:MSP_ClickImage;
      
      private var _251404576img_Snapshot:MSP_Image;
      
      private var _791894124lbl_Name:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function MyOnlineFriendsItem()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "stylesFactory":function():void
            {
               this.borderThickness = 0;
               this.borderStyle = "solid";
               this.cornerRadius = 0;
               this.backgroundColor = 8421504;
               this.backgroundAlpha = 0.4;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "height":30,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"cnv_SnapshotAndText",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "left":0,
                           "top":0,
                           "bottom":0,
                           "right":29,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":MSP_Image,
                              "id":"img_Snapshot",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "left":2,
                                    "top":2,
                                    "bottom":2,
                                    "width":28
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"lbl_Name",
                              "stylesFactory":function():void
                              {
                                 this.fontFamily = "Verdana";
                                 this.fontSize = 12;
                                 this.color = 16777215;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "text":"",
                                    "truncateToFit":true,
                                    "top":0,
                                    "bottom":10,
                                    "left":35,
                                    "buttonMode":true,
                                    "useHandCursor":true,
                                    "mouseChildren":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":HRule,
                              "stylesFactory":function():void
                              {
                                 this.strokeWidth = 1;
                                 this.strokeColor = 8421504;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "alpha":0.25,
                                    "y":20,
                                    "left":38,
                                    "right":5
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":MSP_ClickImage,
                     "id":"img_ChatBubble",
                     "events":{"click":"__img_ChatBubble_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":1,
                           "right":1,
                           "height":28,
                           "width":28
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
         bindings = this._MyOnlineFriendsItem_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_Components_Friends_MyOnlineFriendsItemWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return MyOnlineFriendsItem[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.left = 0;
         this.right = 0;
         this.height = 30;
         this.percentWidth = 100;
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         MyOnlineFriendsItem._watcherSetupUtil = param1;
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
            this.borderThickness = 0;
            this.borderStyle = "solid";
            this.cornerRadius = 0;
            this.backgroundColor = 8421504;
            this.backgroundAlpha = 0.4;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1 != null)
         {
            super.data = param1;
            if(data is IFriend)
            {
               this.lbl_Name.text = (data as IFriend).name;
               this.cnv_SnapshotAndText.addEventListener(MouseEvent.CLICK,this.cnv_SnapshotAndText_ClickHandler);
               this.img_Snapshot.source = new SnapshotUrl((data as IFriend).userId,EntityTypeType.MOVIESTAR,"moviestar").toString();
               this.lbl_Name.explicitWidth = this.width - this.img_ChatBubble.width - 2;
               addEventListener(ResizeEvent.RESIZE,this.onResize);
            }
         }
      }
      
      private function onResize(param1:ResizeEvent) : void
      {
         this.lbl_Name.explicitWidth = this.width - this.img_ChatBubble.width - 2;
      }
      
      protected function cnv_SnapshotAndText_ClickHandler(param1:MouseEvent) : void
      {
         CharacterContainer.showMyPopUp((data as IFriend).userId);
      }
      
      protected function img_ChatBubble_ClickHandler() : void
      {
         var _loc1_:Point = this.parent.localToGlobal(new Point(this.x + this.width,this.y));
         _loc1_ = Main.Instance.mainCanvas.globalToLocal(_loc1_);
         ChatViewManager.getInstance().showChatForm(_loc1_.x,_loc1_.y,null,data.actorId);
      }
      
      public function __img_ChatBubble_click(param1:MouseEvent) : void
      {
         this.img_ChatBubble_ClickHandler();
      }
      
      private function _MyOnlineFriendsItem_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Object
         {
            return Config.toAbsoluteURL("img/32x32/messages.png",Config.LOCAL_CDN_URL);
         },null,"img_ChatBubble.source");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get cnv_SnapshotAndText() : Canvas
      {
         return this._2078819916cnv_SnapshotAndText;
      }
      
      public function set cnv_SnapshotAndText(param1:Canvas) : void
      {
         var _loc2_:Object = this._2078819916cnv_SnapshotAndText;
         if(_loc2_ !== param1)
         {
            this._2078819916cnv_SnapshotAndText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cnv_SnapshotAndText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get img_ChatBubble() : MSP_ClickImage
      {
         return this._2113764320img_ChatBubble;
      }
      
      public function set img_ChatBubble(param1:MSP_ClickImage) : void
      {
         var _loc2_:Object = this._2113764320img_ChatBubble;
         if(_loc2_ !== param1)
         {
            this._2113764320img_ChatBubble = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"img_ChatBubble",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get img_Snapshot() : MSP_Image
      {
         return this._251404576img_Snapshot;
      }
      
      public function set img_Snapshot(param1:MSP_Image) : void
      {
         var _loc2_:Object = this._251404576img_Snapshot;
         if(_loc2_ !== param1)
         {
            this._251404576img_Snapshot = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"img_Snapshot",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lbl_Name() : Label
      {
         return this._791894124lbl_Name;
      }
      
      public function set lbl_Name(param1:Label) : void
      {
         var _loc2_:Object = this._791894124lbl_Name;
         if(_loc2_ !== param1)
         {
            this._791894124lbl_Name = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lbl_Name",_loc2_,param1));
            }
         }
      }
   }
}

