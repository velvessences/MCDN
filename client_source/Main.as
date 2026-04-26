package
{
   import com.moviestarplanet.core.controller.commands.startupcommands.ExecuteApplicationCompleteSetupCommands;
   import com.moviestarplanet.initialization.ConfigPreInitialize;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.mainview.MainCanvas;
   import com.moviestarplanet.services.userservice.valueObjects.LoginStatus;
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
   import mx.core.Application;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class Main extends Application implements IBindingClient
   {
      
      private static var _619772085Instance:Main;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private static var _staticBindingEventDispatcher:EventDispatcher = new EventDispatcher();
      
      private var _10782607mainCanvas:MainCanvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      [Inject]
      public var webEventDispatcher:IEventDispatcher;
      
      public var loginStatus:LoginStatus;
      
      mx_internal var _Main_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function Main()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Application,
            "events":{
               "applicationComplete":"___Main_Application1_applicationComplete",
               "preinitialize":"___Main_Application1_preinitialize"
            },
            "stylesFactory":function():void
            {
               this.color = 16777215;
               this.modalTransparencyBlur = 0;
               this.modalTransparencyColor = 3355443;
               this.backgroundColor = 0;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":MainCanvas,
                  "id":"mainCanvas",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":1240,
                        "height":720,
                        "horizontalCenter":0,
                        "horizontalScrollPolicy":"off",
                        "verticalCenter":0,
                        "verticalScrollPolicy":"off"
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
         bindings = this._Main_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_MainWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return Main[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.historyManagementEnabled = false;
         this.horizontalScrollPolicy = "off";
         this.layout = "absolute";
         this.verticalScrollPolicy = "off";
         this.addEventListener("applicationComplete",this.___Main_Application1_applicationComplete);
         this.addEventListener("preinitialize",this.___Main_Application1_preinitialize);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         Main._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public static function get Instance() : Main
      {
         return Main._619772085Instance;
      }
      
      public static function set Instance(param1:Main) : void
      {
         var _loc3_:IEventDispatcher = null;
         var _loc2_:Object = Main._619772085Instance;
         if(_loc2_ !== param1)
         {
            Main._619772085Instance = param1;
            _loc3_ = Main.staticEventDispatcher;
            if(_loc3_ !== null)
            {
               _loc3_.dispatchEvent(PropertyChangeEvent.createUpdateEvent(Main,"Instance",_loc2_,param1));
            }
         }
      }
      
      public static function get staticEventDispatcher() : IEventDispatcher
      {
         return _staticBindingEventDispatcher;
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
            this.color = 16777215;
            this.modalTransparencyBlur = 0;
            this.modalTransparencyColor = 3355443;
            this.backgroundColor = 0;
         };
         mx_internal::_Main_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onPreInitialize() : void
      {
         Instance = this;
         ConfigPreInitialize.execute();
      }
      
      private function onApplicationComplete() : void
      {
         InjectionManager.manager().injectMe(this);
         addEventListener(ResizeEvent.RESIZE,this.resize);
         new ExecuteApplicationCompleteSetupCommands().execute(this.sitemapsLoaded);
      }
      
      private function resize(param1:Event = null) : void
      {
         var _loc2_:Number = stage.stageWidth / 1240;
         var _loc3_:Number = stage.stageHeight / 720;
         this.mainCanvas.scaleX = Math.min(_loc2_,_loc3_);
         this.mainCanvas.scaleY = Math.min(_loc2_,_loc3_);
      }
      
      private function sitemapsLoaded() : void
      {
         this.mainCanvas.applicationViewStack.showFrontPage();
         this.resize();
      }
      
      public function ___Main_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.onApplicationComplete();
      }
      
      public function ___Main_Application1_preinitialize(param1:FlexEvent) : void
      {
         this.onPreInitialize();
      }
      
      private function _Main_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Class
         {
            return null;
         },function(param1:Class):void
         {
            this.setStyle("borderSkin",param1);
         },"this.borderSkin");
         result[1] = new Binding(this,function():Object
         {
            return null;
         },function(param1:Object):void
         {
            this.setStyle("backgroundImage",param1);
         },"this.backgroundImage");
         return result;
      }
      
      mx_internal function _Main_StylesInit() : void
      {
         var _loc1_:CSSStyleDeclaration = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:CSSCondition = null;
         var _loc5_:CSSSelector = null;
         if(mx_internal::_Main_StylesInit_done)
         {
            return;
         }
         mx_internal::_Main_StylesInit_done = true;
         styleManager.initProtoChainRoots();
      }
      
      [Bindable(event="propertyChange")]
      public function get mainCanvas() : MainCanvas
      {
         return this._10782607mainCanvas;
      }
      
      public function set mainCanvas(param1:MainCanvas) : void
      {
         var _loc2_:Object = this._10782607mainCanvas;
         if(_loc2_ !== param1)
         {
            this._10782607mainCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainCanvas",_loc2_,param1));
            }
         }
      }
   }
}

