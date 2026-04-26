package com.moviestarplanet.assetManager.loaders
{
   import avmplus.getQualifiedClassName;
   import com.moviestarplanet.assetManager.AssetManager;
   import com.moviestarplanet.assetManager.AssetManagerStats;
   import com.moviestarplanet.assetManager.IAssetUrl;
   import com.moviestarplanet.assetManager.UnionRep;
   import com.moviestarplanet.assetManager.cache.MemoryCacheManager;
   import com.moviestarplanet.assetManager.externalHelpers.CallManager;
   import com.moviestarplanet.chatCommunicator.logging.AssetErrorLogger;
   import com.moviestarplanet.constants.ConstantsPlatform;
   import com.moviestarplanet.minimalCompsWrapper.MinimalCompsWrapper;
   import flash.display.AVM1Movie;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class AssetLoader
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      private static var memoryCacheManager:MemoryCacheManager;
      
      public static const DEFAULT_MEMORY_CACHE_TIMEOUT:int = 20 * 1000;
      
      private static const HTTP_STATUS_EVENT_TYPE:String = HTTPStatusEvent.HTTP_STATUS;
      
      public var autoDisposeLoader:Boolean = true;
      
      public var isWrapper:Boolean = false;
      
      public var forceLoad:Boolean = false;
      
      public var returnByteArray:Boolean = false;
      
      protected var _urlRootRelativePath:String;
      
      protected var _urlFullPath:String;
      
      public var payload:*;
      
      public var _onSuccess:Function;
      
      public var _onFail:Function;
      
      private var _logOnFail:Boolean;
      
      public var _onSuccessForAssetBundle:Function;
      
      public var _onFailForAssetBundle:Function;
      
      protected var _smartUrl:IAssetUrl;
      
      private var _loadAttempts:int = 0;
      
      private var _urlLoader:URLLoader;
      
      private var _urlLoaderIsLoading:Boolean = false;
      
      private var _loaderIsLoading:Boolean = false;
      
      protected var loader:Loader;
      
      protected var urlReq:URLRequest = new URLRequest();
      
      private var loaderContext:LoaderContext;
      
      public var assetKey:String = "";
      
      protected var assetKeyModifier:String;
      
      protected var doneLoading:Boolean = false;
      
      public var isDisposed:Boolean = false;
      
      public var type:String = "";
      
      private var payloadByteData:ByteArray;
      
      public function AssetLoader(param1:UnionRep, param2:IAssetUrl, param3:Function = null, param4:Function = null, param5:Boolean = true)
      {
         super();
         if(param1 == null)
         {
            throw new Error("AssetLoader can only be instantiated from AssetManager");
         }
         if(param3 != null && param3.length != 1 || param4 != null && param4.length != 1)
         {
            throw new Error("Wrong usage of AssetLoader. onSuccess and onFail callbacks must expect a single parameter AssetLoader as args[0]");
         }
         if(!memoryCacheManager)
         {
            memoryCacheManager = new MemoryCacheManager();
         }
         if(this.type == "")
         {
            this.type = getQualifiedClassName(this);
         }
         this._logOnFail = param5;
         this._smartUrl = param2;
         this._urlRootRelativePath = this._smartUrl.getRootRelativePath();
         this._urlFullPath = this._smartUrl.getAbsolutePath();
         if(this.assetKey == "")
         {
            this.assetKey = this._urlFullPath;
         }
         if(this.assetKeyModifier != null)
         {
            this.assetKey += this.assetKeyModifier;
         }
         MinimalCompsWrapper.addPercentage(AssetManagerStats.debugCreatedPanel,this.assetKey,this);
         this._onSuccess = param3;
         this._onFail = param4;
         this.initLoaderContext();
      }
      
      public function clone() : AssetLoader
      {
         return AssetManager.createLoaderForUnknown(this._smartUrl,this._onSuccess,this._onFail);
      }
      
      private function initLoaderContext() : void
      {
         if(ConstantsPlatform.isIOS)
         {
            this.loaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         }
         else
         {
            this.loaderContext = new LoaderContext(false,null);
         }
      }
      
      public function load() : void
      {
         if(AssetManagerStats.gatherStats)
         {
            ++AssetManagerStats.loadsStarted;
         }
         CallManager.loaderRequestedLoad(this);
      }
      
      public function doLoad() : void
      {
         var _loc1_:ByteArray = null;
         if(this.isDisposed)
         {
            throw new Error("AssetLoader can not doLOAD() after it has been disposed, this is a serious crime");
         }
         ++this._loadAttempts;
         if(this.payloadByteData)
         {
            this.payloadByteData.clear();
            this.payloadByteData = null;
         }
         else
         {
            _loc1_ = memoryCacheManager.getCopy(this._urlFullPath);
         }
         if(_loc1_)
         {
            this.handleLoadedBytes(_loc1_);
         }
         else
         {
            this.loadFromUrl(this._urlFullPath);
         }
      }
      
      private function startStreaming(param1:Event) : void
      {
         this.loader.contentLoaderInfo.removeEventListener(Event.OPEN,this.startStreaming);
         this._loaderIsLoading = true;
      }
      
      private function loadFromUrl(param1:String) : void
      {
         AssetManagerStats.addFileLoadToLoadRequestList("________________LOAD_FROM_URL_LOADER_STARTED");
         this.cleanUrlLoader();
         this.urlReq.url = param1;
         this._urlLoader = new URLLoader();
         this._urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         this._urlLoader.addEventListener(Event.COMPLETE,this.onBytesLoaded);
         this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOErrorFail);
         this._urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityError);
         this._urlLoader.addEventListener(ProgressEvent.PROGRESS,this.progressOnUrlLoader);
         this._urlLoader.addEventListener(HTTP_STATUS_EVENT_TYPE,this.onResponseStatus);
         this._urlLoader.load(this.urlReq);
         this._urlLoaderIsLoading = true;
      }
      
      protected function onResponseStatus(param1:HTTPStatusEvent) : void
      {
      }
      
      private function progressOnUrlLoader(param1:ProgressEvent) : void
      {
         MinimalCompsWrapper.updatePercentage(this.assetKey,0,param1.bytesTotal,param1.bytesLoaded);
      }
      
      private function securityError(param1:SecurityError) : void
      {
         AssetManagerStats.addFileLoadToLoadRequestList("________________LOAD_FROM_URL_LOADER_SECURITY_ERROR");
         this._urlLoaderIsLoading = false;
         this._loaderIsLoading = false;
         this.triggerOnFail();
      }
      
      §§namespace("AssetManager") function CallManagerSaysYouHaveLoaded() : void
      {
         this.onBytesLoaded(null);
      }
      
      private function onBytesLoaded(param1:Event) : void
      {
         AssetManagerStats.addFileLoadToLoadRequestList("________________LOAD_FROM_URL_LOADER_SUCCESS");
         this._urlLoaderIsLoading = false;
         var _loc2_:ByteArray = memoryCacheManager.getCopy(this._urlFullPath);
         if(_loc2_ == null)
         {
            if(!this._urlLoader || !this._urlLoader.data || this._urlLoader.data.length <= 0)
            {
               this.triggerOnFail();
               return;
            }
            _loc2_ = this._urlLoader.data;
            memoryCacheManager.storeCopy(_loc2_,this._urlFullPath,DEFAULT_MEMORY_CACHE_TIMEOUT);
            this.cleanUrlLoader();
         }
         this.handleLoadedBytes(_loc2_);
      }
      
      private function handleLoadedBytes(param1:ByteArray) : void
      {
         if(param1.length == 0)
         {
            this.triggerOnFail();
            return;
         }
         if(this.returnByteArray)
         {
            this.payload = param1;
            this.triggerOnSuccess();
         }
         else
         {
            this.payloadByteData = param1;
            param1.position = 0;
            this.loaderContext.allowCodeImport = true;
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaded);
            this.loader.contentLoaderInfo.addEventListener(Event.OPEN,this.startStreaming);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOErrorFail);
            this.loader.loadBytes(param1,this.loaderContext);
            AssetManagerStats.addFileLoadToLoadRequestList("________________LOAD_FROM_BYTEARRAY");
         }
      }
      
      protected function onLoaded(param1:Event) : void
      {
         AssetManagerStats.addFileLoadToLoadRequestList("________________LOAD_FROM_BYTEARRAY SUCCESS");
         if(this.payloadByteData)
         {
            this.payloadByteData.clear();
            this.payloadByteData = null;
         }
         this._loaderIsLoading = false;
         this.payload = this.loader.content;
         if(this.payload is AVM1Movie)
         {
            this.payload = this.loader;
         }
         this.triggerOnSuccess();
      }
      
      protected function triggerOnSuccess() : void
      {
         this.doneLoading = true;
         if(this._onSuccess != null)
         {
            this._onSuccess(this);
         }
         if(this._onSuccessForAssetBundle != null)
         {
            this._onSuccessForAssetBundle(this);
         }
         CallManager.loaderSucceeded(this);
         if(this.autoDisposeLoader)
         {
            this.dispose();
         }
      }
      
      protected function onIOErrorFail(param1:IOErrorEvent) : void
      {
         AssetManagerStats.addFileLoadToLoadRequestList("________________LOAD_FROM_URL_LOADER_IOErrorEvent");
         this._urlLoaderIsLoading = false;
         this._loaderIsLoading = false;
         if(this._loadAttempts >= 4)
         {
            this.triggerOnFail();
         }
         else
         {
            this.doLoad();
         }
      }
      
      protected function triggerOnFail() : void
      {
         this.doneLoading = true;
         if(this.isDisposed)
         {
            throw new Error("AssetLoader triggerOnFail should not happen if its been disposed... fix this");
         }
         if(this._onFail != null)
         {
            this._onFail(this);
         }
         if(this._onFailForAssetBundle != null)
         {
            this._onFailForAssetBundle(this);
         }
         if(this.autoDisposeLoader)
         {
            this.dispose();
         }
         if(this._logOnFail)
         {
            AssetErrorLogger.sendErrorEventToLoggly(this.assetKey);
         }
         CallManager.loaderFailed(this);
      }
      
      protected function cleanUrlLoader() : void
      {
         if(this._urlLoader != null)
         {
            if(this._urlLoaderIsLoading)
            {
               this._urlLoader.close();
               this._urlLoaderIsLoading = false;
            }
            this._urlLoader.removeEventListener(Event.COMPLETE,this.onBytesLoaded);
            this._urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOErrorFail);
            this._urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityError);
            this._urlLoader.removeEventListener(ProgressEvent.PROGRESS,this.progressOnUrlLoader);
            this._urlLoader.removeEventListener(HTTP_STATUS_EVENT_TYPE,this.onResponseStatus);
            this._urlLoader = null;
         }
      }
      
      protected function cleanLoader() : void
      {
         if(this.loader != null)
         {
            if(this._loaderIsLoading)
            {
               this.loader.close();
               this.loader.unloadAndStop();
               this._loaderIsLoading = false;
            }
            if(this.loader.contentLoaderInfo != null)
            {
               this.loader.contentLoaderInfo.removeEventListener(Event.OPEN,this.startStreaming);
               this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaded);
               this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOErrorFail);
            }
            this.loader = null;
         }
      }
      
      public function bequeath(param1:AssetLoader) : void
      {
         param1._urlLoader = this._urlLoader;
         if(this._urlLoader != null)
         {
            this._urlLoader.removeEventListener(Event.COMPLETE,this.onBytesLoaded);
            this._urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOErrorFail);
            this._urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityError);
            this._urlLoader.removeEventListener(ProgressEvent.PROGRESS,this.progressOnUrlLoader);
            this._urlLoader.removeEventListener(HTTP_STATUS_EVENT_TYPE,this.onResponseStatus);
            this._urlLoader.addEventListener(Event.COMPLETE,param1.onBytesLoaded);
            this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR,param1.onIOErrorFail);
            this._urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,param1.securityError);
            this._urlLoader.addEventListener(ProgressEvent.PROGRESS,param1.progressOnUrlLoader);
            this._urlLoader.addEventListener(HTTP_STATUS_EVENT_TYPE,param1.onResponseStatus);
            this._urlLoader = null;
         }
         param1.loader = this.loader;
         if(this.loader != null)
         {
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaded);
            this.loader.contentLoaderInfo.removeEventListener(Event.OPEN,this.startStreaming);
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,param1.onLoaded);
            this.loader.contentLoaderInfo.addEventListener(Event.OPEN,param1.startStreaming);
            this.loader = null;
         }
      }
      
      public function dispose() : void
      {
         if(this.payloadByteData)
         {
            this.payloadByteData.clear();
            this.payloadByteData = null;
         }
         CallManager.loaderDisposed(this);
         this.cleanUrlLoader();
         this.cleanLoader();
         this._smartUrl = null;
         this.urlReq = null;
         this._onFail = null;
         this._onFailForAssetBundle = null;
         this._onSuccess = null;
         this._onSuccessForAssetBundle = null;
         this.isDisposed = true;
         MinimalCompsWrapper.removePercentage(this.assetKey);
      }
   }
}

