package com.moviestarplanet.blob.service
{
   import com.moviestarplanet.loader.ILoaderUrl;
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   import com.moviestarplanet.utils.loader.MSP_LoaderManager;
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   internal class SingleBlobLoader extends URLLoader implements IMSP_Loader
   {
      
      public static var blobServerUrl:String;
      
      private var _entityType:String;
      
      private var _entityId:int;
      
      private var _userLoadCallBack:Function;
      
      private var _userLoadFailCallBack:Function;
      
      private var _failedAttempts:int;
      
      private var _priority:int;
      
      private var _timer:Timer;
      
      private const _maxFailedAttempts:int = 3;
      
      private const _backoffMilliseconds:int = 1500;
      
      private var _isDeletable:Boolean;
      
      private var _cacheTimestamp:Object;
      
      public function SingleBlobLoader()
      {
         super();
      }
      
      public function get Priority() : int
      {
         return this._priority;
      }
      
      public function set Priority(param1:int) : void
      {
         this._priority = param1;
      }
      
      public function get CacheTimestamp() : Object
      {
         return this._cacheTimestamp;
      }
      
      public function set CacheTimestamp(param1:Object) : void
      {
         this._cacheTimestamp = param1;
      }
      
      public function get LoadCallBack() : Function
      {
         return this.onLoadedEvent;
      }
      
      public function set LoadCallBack(param1:Function) : void
      {
         this._userLoadCallBack = param1;
      }
      
      public function get LoadFailCallBack() : Function
      {
         return this.onErrorEvent;
      }
      
      public function set LoadFailCallBack(param1:Function) : void
      {
         this._userLoadFailCallBack = param1;
      }
      
      public function get sourceUrl() : String
      {
         return this.sourceUrlString;
      }
      
      public function get sourceUrlString() : String
      {
         var _loc1_:String = "";
         if(this._cacheTimestamp != null)
         {
            _loc1_ = "?v=";
            if(this._cacheTimestamp is Date)
            {
               _loc1_ += (this._cacheTimestamp as Date).time;
            }
            else if(this._cacheTimestamp is Number || this._cacheTimestamp is int)
            {
               _loc1_ += (this._cacheTimestamp as int).toString();
            }
            else
            {
               _loc1_ += String(this._cacheTimestamp);
            }
         }
         return blobServerUrl + this._entityType + "data_" + this.FormattedEntityId + _loc1_;
      }
      
      public function set sourceUrl(param1:String) : void
      {
      }
      
      public function get isDeletable() : Boolean
      {
         return this._isDeletable;
      }
      
      public function set isDeletable(param1:Boolean) : void
      {
         this._isDeletable = param1;
      }
      
      private function get FormattedEntityId() : String
      {
         return this.LeftPadNumber(this._entityId / 1000000000) + "_" + this.LeftPadNumber(this._entityId / 1000000 % 1000) + "_" + this.LeftPadNumber(this._entityId / 1000 % 1000) + "_" + this.LeftPadNumber(this._entityId % 1000);
      }
      
      private function LeftPadNumber(param1:int) : String
      {
         if(param1 > 1000 || param1 < 0)
         {
            return param1.toString();
         }
         if(param1 < 10)
         {
            return "00" + param1.toString();
         }
         if(param1 < 100)
         {
            return "0" + param1.toString();
         }
         return param1.toString();
      }
      
      private function onLoadedEvent(param1:Object) : void
      {
         var _loc2_:ByteArray = data as ByteArray;
         if(this._userLoadCallBack != null)
         {
            this._userLoadCallBack(this._entityType,this._entityId,_loc2_);
         }
      }
      
      private function onErrorEvent(param1:Object) : void
      {
         ++this._failedAttempts;
         if(this._failedAttempts >= this._maxFailedAttempts)
         {
            if(this._userLoadCallBack != null)
            {
               this._userLoadCallBack(this._entityType,this._entityId,null);
            }
            if(this._userLoadFailCallBack != null)
            {
               this._userLoadFailCallBack();
            }
            return;
         }
         this._timer = new Timer(this._backoffMilliseconds,1);
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.RetryLoad);
         this._timer.start();
      }
      
      private function RetryLoad(param1:TimerEvent) : void
      {
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.RetryLoad);
         this.AttemptRequest();
      }
      
      private function AttemptRequest() : void
      {
         MSP_LoaderManager.RequestLoadForLoader(this,this.Priority,this.isDeletable,false);
      }
      
      public function doLoad() : void
      {
         var _loc1_:URLRequest = new URLRequest(this.sourceUrlString);
         dataFormat = URLLoaderDataFormat.BINARY;
         load(_loc1_);
      }
      
      public function RequestLoad(param1:String, param2:int, param3:Function, param4:Function = null, param5:int = 2, param6:Boolean = true) : void
      {
         this._failedAttempts = 0;
         this._entityType = param1.toLowerCase();
         this._entityId = param2;
         this._userLoadCallBack = param3;
         this._userLoadFailCallBack = param4;
         param6 = param6;
         this.Priority = param5;
         this.AttemptRequest();
      }
      
      public function LoadUrl(param1:ILoaderUrl, param2:int = 2, param3:Boolean = true) : void
      {
         this.sourceUrl = param1.toString();
         this._isDeletable = param3;
         MSP_LoaderManager.RequestLoadForLoader(this,param2,param3);
      }
      
      public function get loadedContents() : *
      {
         return data;
      }
      
      public function get contentLoaderInfo() : LoaderInfo
      {
         throw new Error("Not implemented");
      }
      
      public function dispose() : void
      {
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
      
      public function get content() : DisplayObject
      {
         return null;
      }
   }
}

