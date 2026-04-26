package
{
   import flash.display.LoaderInfo;
   import flash.system.ApplicationDomain;
   import flash.system.Security;
   import flash.utils.Dictionary;
   import flashx.textLayout.compose.ISWFContext;
   import mx.core.EmbeddedFontRegistry;
   import mx.core.IFlexModule;
   import mx.core.IFlexModuleFactory;
   import mx.core.RSLData;
   import mx.core.Singleton;
   import mx.events.RSLEvent;
   import mx.managers.SystemManager;
   
   public class _Main_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory, ISWFContext
   {
      
      private var _info:Object;
      
      private var _preloadedRSLs:Dictionary;
      
      private var _allowDomainParameters:Vector.<Array>;
      
      private var _allowInsecureDomainParameters:Vector.<Array>;
      
      public function _Main_mx_managers_SystemManager()
      {
         super();
      }
      
      override public function callInContext(param1:Function, param2:Object, param3:Array, param4:Boolean = true) : *
      {
         if(param4)
         {
            return param1.apply(param2,param3);
         }
         param1.apply(param2,param3);
      }
      
      override public function create(... rest) : Object
      {
         if(rest.length > 0 && !(rest[0] is String))
         {
            return super.create.apply(this,rest);
         }
         var _loc2_:String = rest.length == 0 ? "Main" : String(rest[0]);
         var _loc3_:Class = Class(getDefinitionByName(_loc2_));
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:Object = new _loc3_();
         if(_loc4_ is IFlexModule)
         {
            IFlexModule(_loc4_).moduleFactory = this;
         }
         if(rest.length == 0)
         {
            Singleton.registerClass("mx.core::IEmbeddedFontRegistry",Class(getDefinitionByName("mx.core::EmbeddedFontRegistry")));
            EmbeddedFontRegistry.registerFonts(this.info()["fonts"],this);
         }
         return _loc4_;
      }
      
      override public function info() : Object
      {
         if(!this._info)
         {
            this._info = {
               "applicationComplete":"onApplicationComplete()",
               "backgroundColor":"0x0",
               "backgroundImage":"{null}",
               "borderSkin":"{null}",
               "cdRsls":[[new RSLData("sdk/framework_4.6.0.23201.swz","","abd49354324081cebb8f60184cf5fee81f0f9298e64dbec968c96d68fe16c437","SHA-256",true,true,"default")],[new RSLData("sdk/rpc_4.6.0.23201.swz","","98eeca3e014a0fa3c4c613006bdcea12da3beace6a8c9eccdde2e07cb486bab5","SHA-256",true,true,"default")],[new RSLData("sdk/textLayout_2.0.0.232.swz","","8f903698240fe799f61eeda8595181137b996156bb176da70ad6f41645c64c74","SHA-256",true,true,"default")],[new RSLData("sdk/mx_4.6.0.23201.swz","","d888aee0ce49f58a35c32eb138edd00f0d6b9fae68b78d7eb83932c09ef0b6f1","SHA-256",true,true,"default")]],
               "color":"0xffffff",
               "compiledLocales":[],
               "compiledResourceBundleNames":["SharedResources","collections","containers","controls","core","effects","fiber","formatters","logging","messaging","rpc","skins","styles","utils","validators"],
               "currentDomain":ApplicationDomain.currentDomain,
               "fonts":{
                  "Arezzo-Rounde3":{
                     "regular":true,
                     "bold":false,
                     "italic":false,
                     "boldItalic":false
                  },
                  "Arezzo-Rounde3-Bold":{
                     "regular":true,
                     "bold":false,
                     "italic":false,
                     "boldItalic":false
                  },
                  "Aria3":{
                     "regular":true,
                     "bold":true,
                     "italic":true,
                     "boldItalic":true
                  },
                  "Aria4":{
                     "regular":true,
                     "bold":true,
                     "italic":true,
                     "boldItalic":true
                  },
                  "BadaBoo3 Pro BB":{
                     "regular":true,
                     "bold":false,
                     "italic":true,
                     "boldItalic":false
                  },
                  "Blue Highwa3":{
                     "regular":true,
                     "bold":true,
                     "italic":false,
                     "boldItalic":false
                  },
                  "Embed Foo":{
                     "regular":true,
                     "bold":false,
                     "italic":false,
                     "boldItalic":false
                  },
                  "Embed Lobster":{
                     "regular":true,
                     "bold":false,
                     "italic":false,
                     "boldItalic":false
                  },
                  "Embed Segoe Print":{
                     "regular":true,
                     "bold":false,
                     "italic":false,
                     "boldItalic":false
                  },
                  "Fo3":{
                     "regular":true,
                     "bold":false,
                     "italic":false,
                     "boldItalic":false
                  },
                  "Lobste3 1.4":{
                     "regular":true,
                     "bold":false,
                     "italic":false,
                     "boldItalic":false
                  },
                  "PF Ronda Seven":{
                     "regular":true,
                     "bold":false,
                     "italic":false,
                     "boldItalic":false
                  },
                  "Sego3 Print":{
                     "regular":true,
                     "bold":false,
                     "italic":false,
                     "boldItalic":false
                  }
               },
               "frameRate":"24",
               "historyManagementEnabled":"false",
               "horizontalScrollPolicy":"off",
               "layout":"absolute",
               "mainClassName":"Main",
               "mixins":["_Main_FlexInit","_Main_Styles","mx.managers.systemClasses.ActiveWindowManager","mx.messaging.config.LoaderConfig","com.moviestarplanet.logging.UncaughtErrorHandler"],
               "modalTransparencyBlur":"0",
               "modalTransparencyColor":"0x333333",
               "pageTitle":"MovieStarPlanet - Fame, Fortune and Friends",
               "placeholderRsls":[],
               "preinitialize":"onPreInitialize();",
               "preloader":Preloader,
               "verticalScrollPolicy":"off"
            };
         }
         return this._info;
      }
      
      override public function get preloadedRSLs() : Dictionary
      {
         if(this._preloadedRSLs == null)
         {
            this._preloadedRSLs = new Dictionary(true);
         }
         return this._preloadedRSLs;
      }
      
      override public function allowDomain(... rest) : void
      {
         var _loc2_:Object = null;
         Security.allowDomain.apply(null,rest);
         for(_loc2_ in this._preloadedRSLs)
         {
            if(Boolean(_loc2_.content) && "allowDomainInRSL" in _loc2_.content)
            {
               _loc2_.content["allowDomainInRSL"].apply(null,rest);
            }
         }
         if(!this._allowDomainParameters)
         {
            this._allowDomainParameters = new Vector.<Array>();
         }
         this._allowDomainParameters.push(rest);
         addEventListener(RSLEvent.RSL_ADD_PRELOADED,this.addPreloadedRSLHandler,false,50);
      }
      
      override public function allowInsecureDomain(... rest) : void
      {
         var _loc2_:Object = null;
         Security.allowInsecureDomain.apply(null,rest);
         for(_loc2_ in this._preloadedRSLs)
         {
            if(Boolean(_loc2_.content) && "allowInsecureDomainInRSL" in _loc2_.content)
            {
               _loc2_.content["allowInsecureDomainInRSL"].apply(null,rest);
            }
         }
         if(!this._allowInsecureDomainParameters)
         {
            this._allowInsecureDomainParameters = new Vector.<Array>();
         }
         this._allowInsecureDomainParameters.push(rest);
         addEventListener(RSLEvent.RSL_ADD_PRELOADED,this.addPreloadedRSLHandler,false,50);
      }
      
      private function addPreloadedRSLHandler(param1:RSLEvent) : void
      {
         var _loc3_:Array = null;
         var _loc2_:LoaderInfo = param1.loaderInfo;
         if(!_loc2_ || !_loc2_.content)
         {
            return;
         }
         if(allowDomainsInNewRSLs && Boolean(this._allowDomainParameters))
         {
            for each(_loc3_ in this._allowDomainParameters)
            {
               if("allowDomainInRSL" in _loc2_.content)
               {
                  _loc2_.content["allowDomainInRSL"].apply(null,_loc3_);
               }
            }
         }
         if(allowInsecureDomainsInNewRSLs && Boolean(this._allowInsecureDomainParameters))
         {
            for each(_loc3_ in this._allowInsecureDomainParameters)
            {
               if("allowInsecureDomainInRSL" in _loc2_.content)
               {
                  _loc2_.content["allowInsecureDomainInRSL"].apply(null,_loc3_);
               }
            }
         }
      }
   }
}

