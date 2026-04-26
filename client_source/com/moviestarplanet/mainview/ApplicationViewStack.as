package com.moviestarplanet.mainview
{
   import com.moviestarplanet.Components.ViewComponent.ViewComponentViewStack;
   import com.moviestarplanet.frontpage.FrontPage2;
   import com.moviestarplanet.frontpage.RegisterNewUserComponent;
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
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class ApplicationViewStack extends ViewComponentViewStack implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private var _1849726211FrontPageView:FrontPage2;
      
      private var _1117517837RegisterNewUserView:RegisterNewUserComponent;
      
      private var _1145420499loadLocaleResourceView:Canvas;
      
      private var _498667697logoutView:Canvas;
      
      private var _8376322mainView:MainView;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function ApplicationViewStack()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":ViewComponentViewStack,
            "propertiesFactory":function():Object
            {
               return {
                  "width":1240,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"loadLocaleResourceView",
                     "propertiesFactory":function():Object
                     {
                        return {"clipContent":true};
                     }
                  }),new UIComponentDescriptor({
                     "type":FrontPage2,
                     "id":"FrontPageView",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":MainView,
                     "id":"mainView"
                  }),new UIComponentDescriptor({
                     "type":RegisterNewUserComponent,
                     "id":"RegisterNewUserView"
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"logoutView",
                     "stylesFactory":function():void
                     {
                        this.backgroundAlpha = 0.5;
                        this.backgroundColor = 16777215;
                        this.borderStyle = "solid";
                        this.borderThickness = 0;
                        this.cornerRadius = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "label":"logoutView",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Label,
                              "stylesFactory":function():void
                              {
                                 this.color = 0;
                                 this.fontSize = 60;
                                 this.fontWeight = "bold";
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "left":0,
                                    "right":0,
                                    "top":100,
                                    "text":"Logging out..."
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
         bindings = this._ApplicationViewStack_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_moviestarplanet_mainview_ApplicationViewStackWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return ApplicationViewStack[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.y = 0;
         this.clipContent = true;
         this.horizontalCenter = 0;
         this.width = 1240;
         this.percentHeight = 100;
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         ApplicationViewStack._watcherSetupUtil = param1;
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
      
      public function unLoadAndHideFrontPage() : void
      {
         if(this.FrontPageView != null)
         {
            if(this.FrontPageView.parent != null)
            {
               this.FrontPageView.parent.removeChild(this.FrontPageView);
            }
            this.FrontPageView.loggedInNow();
            this.FrontPageView = null;
         }
      }
      
      public function showRegisterNewUser() : void
      {
         selectedChild = this.RegisterNewUserView;
      }
      
      public function showFrontPage() : void
      {
         selectedChild = this.FrontPageView;
      }
      
      private function _ApplicationViewStack_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Object
         {
            return null;
         },function(param1:Object):void
         {
            FrontPageView.setStyle("backgroundImage",param1);
         },"FrontPageView.backgroundImage");
         result[1] = new Binding(this,function():Class
         {
            return null;
         },function(param1:Class):void
         {
            FrontPageView.setStyle("borderSkin",param1);
         },"FrontPageView.borderSkin");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get FrontPageView() : FrontPage2
      {
         return this._1849726211FrontPageView;
      }
      
      public function set FrontPageView(param1:FrontPage2) : void
      {
         var _loc2_:Object = this._1849726211FrontPageView;
         if(_loc2_ !== param1)
         {
            this._1849726211FrontPageView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"FrontPageView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get RegisterNewUserView() : RegisterNewUserComponent
      {
         return this._1117517837RegisterNewUserView;
      }
      
      public function set RegisterNewUserView(param1:RegisterNewUserComponent) : void
      {
         var _loc2_:Object = this._1117517837RegisterNewUserView;
         if(_loc2_ !== param1)
         {
            this._1117517837RegisterNewUserView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"RegisterNewUserView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loadLocaleResourceView() : Canvas
      {
         return this._1145420499loadLocaleResourceView;
      }
      
      public function set loadLocaleResourceView(param1:Canvas) : void
      {
         var _loc2_:Object = this._1145420499loadLocaleResourceView;
         if(_loc2_ !== param1)
         {
            this._1145420499loadLocaleResourceView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loadLocaleResourceView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoutView() : Canvas
      {
         return this._498667697logoutView;
      }
      
      public function set logoutView(param1:Canvas) : void
      {
         var _loc2_:Object = this._498667697logoutView;
         if(_loc2_ !== param1)
         {
            this._498667697logoutView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoutView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mainView() : MainView
      {
         return this._8376322mainView;
      }
      
      public function set mainView(param1:MainView) : void
      {
         var _loc2_:Object = this._8376322mainView;
         if(_loc2_ !== param1)
         {
            this._8376322mainView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainView",_loc2_,param1));
            }
         }
      }
   }
}

