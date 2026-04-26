package com.moviestarplanet.utils.flash
{
   import com.moviestarplanet.loader.ILoaderUrl;
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   
   public class MSP_FlashLoader extends Loader implements IMSP_Loader
   {
      
      public static var securityDomain:SecurityDomain = SecurityDomain.currentDomain;
      
      protected var _url:String;
      
      protected var _LoadCallBack:Function;
      
      protected var _LoadFailCallBack:Function;
      
      protected var _params:Array;
      
      protected var _isDeletable:Boolean;
      
      private var doContentManage:Boolean;
      
      private var allowCodeImport:Boolean;
      
      public function MSP_FlashLoader(param1:Boolean = true, param2:Boolean = true)
      {
         super();
         this.doContentManage = param1;
         this.allowCodeImport = param2;
      }
      
      public static function RequestLoad(param1:ILoaderUrl, param2:Function, param3:int = 2, param4:Boolean = true, param5:Boolean = true, param6:Function = null, param7:Boolean = true) : MSP_FlashLoader
      {
         if(param1 == null)
         {
            trace("RequestLoad: url == null");
         }
         var _loc8_:MSP_FlashLoader = new MSP_FlashLoader(param5,param1.allowCodeImport());
         _loc8_._url = param1.toString();
         _loc8_.LoadCallBack = param2;
         _loc8_.LoadFailCallBack = param6;
         _loc8_.isDeletable = param4;
         MSP_LoaderManager.RequestLoadForLoader(_loc8_,param3,param4,param7);
         return _loc8_;
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
      
      public function get params() : Array
      {
         return this._params;
      }
      
      public function set params(param1:Array) : void
      {
         this._params = param1;
      }
      
      public function set sourceUrl(param1:String) : void
      {
         this._url = param1;
      }
      
      public function get sourceUrl() : String
      {
         return this._url;
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
         var _loc1_:LoaderContext = null;
         this.HookUpToLoadEvents();
         if(this._url == null)
         {
            trace("url is null");
         }
         _loc1_ = new LoaderContext(true,null,securityDomain);
         _loc1_.allowCodeImport = this.allowCodeImport;
         load(new URLRequest(this._url.toString()),_loc1_);
      }
      
      public function LoadUrl(param1:ILoaderUrl, param2:int = 2, param3:Boolean = true) : void
      {
         if(param1 == null)
         {
            trace("LoadUrl: url == null");
         }
         this._url = param1.toString();
         this.isDeletable = param3;
         MSP_LoaderManager.RequestLoadForLoader(this,param2,param3);
      }
      
      public function calcContentScaleAdjustments(param1:Number, param2:Number) : Number
      {
         var _loc7_:Number = NaN;
         if(content.width == param1 && content.height == param2)
         {
            return 1;
         }
         var _loc3_:Number = Number(contentLoaderInfo.width);
         var _loc4_:Number = Number(contentLoaderInfo.height);
         var _loc5_:Number = param1 / _loc3_;
         var _loc6_:Number = param2 / _loc4_;
         if(_loc5_ > _loc6_)
         {
            _loc7_ = _loc6_;
         }
         else
         {
            _loc7_ = _loc5_;
         }
         return _loc7_;
      }
      
      protected function HookUpToLoadEvents() : void
      {
         contentLoaderInfo.addEventListener(Event.COMPLETE,this.OnFileLoadComplete,false,int.MAX_VALUE);
         contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.OnIOError);
      }
      
      private function UnhookFromLoadEvents() : void
      {
         removeEventListener(Event.COMPLETE,this.OnFileLoadComplete);
      }
      
      private function OnIOError(param1:IOErrorEvent) : void
      {
         this.UnhookFromLoadEvents();
         dispatchEvent(param1);
      }
      
      protected function OnFileLoadComplete(param1:Event) : void
      {
         this.UnhookFromLoadEvents();
         dispatchEvent(param1);
      }
      
      public function GetContentColorMap() : Array
      {
         var _loc1_:MovieClip = content as MovieClip;
         if(_loc1_ == null)
         {
            return null;
         }
         return _loc1_.colorMap as Array;
      }
      
      public function get loadedContents() : *
      {
         return content;
      }
      
      public function dispose() : void
      {
         this._LoadCallBack = null;
         this._LoadFailCallBack = null;
         if(this.params != null)
         {
            this._params.length = 0;
            this._params = null;
         }
      }
      
      public function set loaderContext(param1:LoaderContext) : void
      {
      }
      
      public function get loaderContext() : LoaderContext
      {
         return null;
      }
      
      public function set buttonMode(param1:Boolean) : void
      {
      }
      
      public function get buttonMode() : Boolean
      {
         return false;
      }
   }
}

