package com.moviestarplanet.utils
{
   import com.moviestarplanet.loader.ILoaderUrl;
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import mx.controls.SWFLoader;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class MSP_SWFLoader extends SWFLoader implements IMSP_Loader
   {
      
      private var _url:String;
      
      private var _LoadCallBack:Function;
      
      private var _LoadFailCallBack:Function;
      
      private var _isDeletable:Boolean;
      
      private var doContentManage:Boolean;
      
      public function MSP_SWFLoader(param1:Boolean = true, param2:Boolean = true)
      {
         super();
         this.doContentManage = param1;
         this.loaderContext = new LoaderContext(true,null,SecurityDomain.currentDomain);
         this.loaderContext.allowCodeImport = param2;
         autoLoad = false;
      }
      
      public static function RequestLoad(param1:ILoaderUrl, param2:Function, param3:int = 2, param4:Boolean = true, param5:Boolean = true) : MSP_SWFLoader
      {
         if(param1 == null)
         {
            trace("RequestLoad: url == null");
         }
         var _loc6_:MSP_SWFLoader = new MSP_SWFLoader(param5,param1.allowCodeImport());
         _loc6_.sourceUrl = param1.toString();
         _loc6_.LoadCallBack = param2;
         _loc6_.isDeletable = param4;
         MSP_LoaderManager.RequestLoadForLoader(_loc6_,param3,param4);
         return _loc6_;
      }
      
      public function get LoadCallBack() : Function
      {
         return this._LoadCallBack;
      }
      
      public function set LoadCallBack(param1:Function) : void
      {
         this._LoadCallBack = param1;
      }
      
      public function get LoadFailCallBack() : Function
      {
         return this._LoadFailCallBack;
      }
      
      public function set LoadFailCallBack(param1:Function) : void
      {
         this._LoadFailCallBack = param1;
      }
      
      public function get sourceUrl() : String
      {
         if(this._url != null && this._url.length > 0)
         {
            return this._url;
         }
         return source.toString();
      }
      
      public function set sourceUrl(param1:String) : void
      {
         this._url = param1.toString();
      }
      
      public function get isDeletable() : Boolean
      {
         return this._isDeletable;
      }
      
      public function set isDeletable(param1:Boolean) : void
      {
         this._isDeletable = param1;
      }
      
      public function doLoad() : void
      {
         this.HookUpToLoadEvents();
         if(this.sourceUrl == null)
         {
            trace("source is null");
         }
         if(this.sourceUrl == "")
         {
            trace("source is empty");
         }
         var _loc1_:Boolean = Boolean(loaderContext.allowCodeImport);
         loaderContext = new LoaderContext(true,null,SecurityDomain.currentDomain);
         loaderContext.allowCodeImport = _loc1_;
         super.load(this.sourceUrl);
      }
      
      public function LoadUrl(param1:ILoaderUrl, param2:int = 2, param3:Boolean = true) : void
      {
         if(param1 == null)
         {
            trace("LoadUrl: url == null");
         }
         this.sourceUrl = param1.toString();
         loaderContext.allowCodeImport = param1.allowCodeImport();
         this.isDeletable = param3;
         MSP_LoaderManager.RequestLoadForLoader(this,param2,param3);
      }
      
      private function HookUpToLoadEvents() : void
      {
         addEventListener(Event.COMPLETE,this.OnLoadComplete,false,int.MAX_VALUE);
         addEventListener(IOErrorEvent.IO_ERROR,this.OnIOError);
      }
      
      private function UnhookFromLoadEvents() : void
      {
         removeEventListener(Event.COMPLETE,this.OnLoadComplete);
         removeEventListener(IOErrorEvent.IO_ERROR,this.OnIOError);
      }
      
      private function OnIOError(param1:IOErrorEvent) : void
      {
         this.UnhookFromLoadEvents();
      }
      
      protected function OnLoadComplete(param1:Event) : void
      {
         this.UnhookFromLoadEvents();
      }
      
      override public function load(param1:Object = null) : void
      {
         if(param1 == null || param1 == "")
         {
            super.load();
         }
         else if(param1 is String)
         {
            this._url = param1 as String;
            super.load();
         }
         else
         {
            this.LoadUrl(param1 as ILoaderUrl);
         }
      }
      
      override public function set source(param1:Object) : void
      {
         super.source = param1;
      }
      
      override mx_internal function contentLoaderInfo_completeEventHandler(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         if(_loc2_ == null || _loc2_.loader == null || _loc2_.loader != mx_internal::contentHolder)
         {
            return;
         }
         super.mx_internal::contentLoaderInfo_completeEventHandler(param1);
      }
      
      public function get loadedContents() : *
      {
         return content;
      }
      
      public function get contentLoaderInfo() : LoaderInfo
      {
         return loaderInfo;
      }
      
      public function destroy() : void
      {
         this.dispose();
      }
      
      public function dispose() : void
      {
         this.UnhookFromLoadEvents();
         this._LoadCallBack = null;
         this._LoadFailCallBack = null;
         loaderContext = null;
      }
   }
}

