package com.moviestarplanet.mainview
{
   import com.moviestarplanet.core.controller.commands.startupcommands.MoviestarInfoUpdatedHandler;
   import com.moviestarplanet.events.MessageCommunicator;
   import com.moviestarplanet.frame.GlowableVBox;
   import com.moviestarplanet.membership.UserTypeDeterminator;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.payment.PaymentModuleExternalManager;
   import com.moviestarplanet.payment.timedOffer.SpecialOffer;
   import com.moviestarplanet.utils.DisplayUtils;
   import com.moviestarplanet.utils.ui.BuySc;
   import com.moviestarplanet.utils.ui.BuyVip;
   import com.moviestarplanet.utils.ui.SpecialOfferIcon;
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
   import mx.containers.ViewStack;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class CornerAdGlowBox extends GlowableVBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private var _481486542buySCCornerAd:Canvas;
      
      private var _516139986buySCCornerAdOffer:Canvas;
      
      private var _422375983buyVipCornerAd:Canvas;
      
      private var _1938346333buyVipOfferCornerAd:Canvas;
      
      private var _1220562928cornerAdStack:ViewStack;
      
      private var _707393797emptyCanvas:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function CornerAdGlowBox()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":GlowableVBox,
            "events":{"creationComplete":"___CornerAdGlowBox_GlowableVBox1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":ViewStack,
                  "id":"cornerAdStack",
                  "propertiesFactory":function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"emptyCanvas",
                        "propertiesFactory":function():Object
                        {
                           return {"visible":false};
                        }
                     }),new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"buyVipOfferCornerAd",
                        "propertiesFactory":function():Object
                        {
                           return {
                              "visible":false,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":SpecialOfferIcon,
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":80,
                                       "height":80,
                                       "swf":"swf/world/frameIcons/buy_VIP_Offer.swf"
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"buyVipCornerAd",
                        "propertiesFactory":function():Object
                        {
                           return {
                              "visible":false,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":BuyVip,
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":80,
                                       "height":80
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"buySCCornerAd",
                        "propertiesFactory":function():Object
                        {
                           return {
                              "visible":false,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":BuySc,
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":80,
                                       "height":80
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"buySCCornerAdOffer",
                        "propertiesFactory":function():Object
                        {
                           return {
                              "visible":false,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":SpecialOfferIcon,
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":80,
                                       "height":80,
                                       "swf":"swf/world/frameIcons/buystarcoinsicon_Offer.swf"
                                    };
                                 }
                              })]
                           };
                        }
                     })]};
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
         bindings = this._CornerAdGlowBox_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_mainview_CornerAdGlowBoxWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return CornerAdGlowBox[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.x = 1165;
         this.y = 53;
         this.mouseEnabled = false;
         this.addEventListener("creationComplete",this.___CornerAdGlowBox_GlowableVBox1_creationComplete);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         CornerAdGlowBox._watcherSetupUtil = param1;
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
      
      private function onCreationComplete() : void
      {
         MessageCommunicator.subscribe(MoviestarInfoUpdatedHandler.UPDATE_MOVIESTAR_INFO,this.toggle);
         if(SpecialOffer.activeOffer != null)
         {
            SpecialOffer.activeOffer.addEventListener(SpecialOffer.EVENT_RESET_CORNER,this.toggle);
         }
      }
      
      private function toggle(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = UserTypeDeterminator.determineUserTypeByDaysLimit(ActorSession.loggedInActor.MembershipTimeoutDate);
         var _loc4_:int = 1;
         var _loc5_:int = 2;
         var _loc6_:int = 3;
         var _loc7_:int = 4;
         removeEventListener(MouseEvent.CLICK,this.clickCornerAd,false);
         var _loc8_:SpecialOffer = SpecialOffer.activeOffer;
         if(_loc8_ != null && _loc8_.SecondsRemaining > 0)
         {
            if(_loc8_.OfferId == SpecialOffer.RESALE)
            {
               this.cornerAdStack.selectedIndex = _loc4_;
            }
            else if(_loc8_.OfferId == SpecialOffer.TOP_UP)
            {
               this.cornerAdStack.selectedIndex = _loc7_;
            }
            else
            {
               this.cornerAdStack.selectedIndex = _loc5_;
            }
         }
         else if(_loc3_ == UserTypeDeterminator.IS_VIP)
         {
            this.cornerAdStack.selectedIndex = _loc6_;
         }
         else
         {
            this.cornerAdStack.selectedIndex = _loc5_;
         }
         addEventListener(MouseEvent.CLICK,this.clickCornerAd,false,0,true);
         mouseEnabled = visible = true;
         DisplayUtils.removeMouseFromChildren(this);
      }
      
      private function clickCornerAd(param1:Event) : void
      {
         PaymentModuleExternalManager.getInstance().openPurchaseFlow();
      }
      
      public function ___CornerAdGlowBox_GlowableVBox1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      private function _CornerAdGlowBox_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Class
         {
            return null;
         },function(param1:Class):void
         {
            this.setStyle("borderSkin",param1);
         },"this.borderSkin");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get buySCCornerAd() : Canvas
      {
         return this._481486542buySCCornerAd;
      }
      
      public function set buySCCornerAd(param1:Canvas) : void
      {
         var _loc2_:Object = this._481486542buySCCornerAd;
         if(_loc2_ !== param1)
         {
            this._481486542buySCCornerAd = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buySCCornerAd",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buySCCornerAdOffer() : Canvas
      {
         return this._516139986buySCCornerAdOffer;
      }
      
      public function set buySCCornerAdOffer(param1:Canvas) : void
      {
         var _loc2_:Object = this._516139986buySCCornerAdOffer;
         if(_loc2_ !== param1)
         {
            this._516139986buySCCornerAdOffer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buySCCornerAdOffer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buyVipCornerAd() : Canvas
      {
         return this._422375983buyVipCornerAd;
      }
      
      public function set buyVipCornerAd(param1:Canvas) : void
      {
         var _loc2_:Object = this._422375983buyVipCornerAd;
         if(_loc2_ !== param1)
         {
            this._422375983buyVipCornerAd = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buyVipCornerAd",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buyVipOfferCornerAd() : Canvas
      {
         return this._1938346333buyVipOfferCornerAd;
      }
      
      public function set buyVipOfferCornerAd(param1:Canvas) : void
      {
         var _loc2_:Object = this._1938346333buyVipOfferCornerAd;
         if(_loc2_ !== param1)
         {
            this._1938346333buyVipOfferCornerAd = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buyVipOfferCornerAd",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cornerAdStack() : ViewStack
      {
         return this._1220562928cornerAdStack;
      }
      
      public function set cornerAdStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1220562928cornerAdStack;
         if(_loc2_ !== param1)
         {
            this._1220562928cornerAdStack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cornerAdStack",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get emptyCanvas() : Canvas
      {
         return this._707393797emptyCanvas;
      }
      
      public function set emptyCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._707393797emptyCanvas;
         if(_loc2_ !== param1)
         {
            this._707393797emptyCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"emptyCanvas",_loc2_,param1));
            }
         }
      }
   }
}

