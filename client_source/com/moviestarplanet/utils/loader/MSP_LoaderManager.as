package com.moviestarplanet.utils.loader
{
   import com.moviestarplanet.chatCommunicator.logging.AssetErrorLogger;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   
   public class MSP_LoaderManager
   {
      
      private static var urlLoadedBeforeLoadRequests:Array = new Array();
      
      private static var urlAlreadyLoadingLoadRequests:Array = new Array();
      
      private static var NonDeletableLoadRequests:Array = new Array();
      
      private static var DeletableLoadRequests:Array = new Array();
      
      public static var MAX_CONCURRENT_LOADS:int = 10 - RESERVED_LOADS_HIGH_PRIO - RESERVED_LOADS_CACHED;
      
      private static var RESERVED_LOADS_HIGH_PRIO:int = 3;
      
      private static var RESERVED_LOADS_CACHED:int = 2;
      
      private static var isBusy:Boolean = false;
      
      private static var isReset:Boolean = false;
      
      private static var currentLoaders:Array = [];
      
      private static const LOADED_BEFORE:int = 1;
      
      private static const CURRENTLY_PENDING_LOAD:int = 2;
      
      public static const PRIORITY_CACHED:int = -1;
      
      public static const PRIORITY_ALREADY_LOADING:int = 0;
      
      public static const PRIORITY_UI:int = 1;
      
      public static const PRIORITY_NORMAL:int = 2;
      
      public static const PRIORITY_LOW:int = 3;
      
      private static var cachedUrls:Object = {};
      
      public static var defaultCdnBasePath:String = "";
      
      public static var tmpCacheOn:Boolean = true;
      
      public function MSP_LoaderManager()
      {
         super();
         throw new Error("Do not instanciate");
      }
      
      public static function RequestLoadForLoader(param1:IMSP_Loader, param2:int = 2, param3:Boolean = true, param4:Boolean = true) : void
      {
         if(param1.sourceUrl == null)
         {
            trace("RequestLoadForLoader: loader.source == null");
         }
         applyVersion(param1);
         if(param4)
         {
            applyCDN(param1);
         }
         if(tmpCacheOn && cachedUrls[param1.sourceUrl] == LOADED_BEFORE)
         {
            urlLoadedBeforeLoadRequests.push(param1);
         }
         else if(tmpCacheOn && cachedUrls[param1.sourceUrl] == CURRENTLY_PENDING_LOAD)
         {
            urlAlreadyLoadingLoadRequests.push(param1);
         }
         else
         {
            if(param3 == false)
            {
               if(NonDeletableLoadRequests[param2] == null)
               {
                  NonDeletableLoadRequests[param2] = new Array();
               }
               NonDeletableLoadRequests[param2].push(param1);
            }
            else
            {
               if(DeletableLoadRequests[param2] == null)
               {
                  DeletableLoadRequests[param2] = new Array();
               }
               DeletableLoadRequests[param2].push(param1);
            }
            if(tmpCacheOn)
            {
               cachedUrls[param1.sourceUrl] = CURRENTLY_PENDING_LOAD;
            }
         }
         LoadNext();
      }
      
      private static function applyVersion(param1:IMSP_Loader) : void
      {
         if(param1.sourceUrl == null)
         {
            return;
         }
         param1.sourceUrl = applyVersionToString(param1.sourceUrl.toString());
      }
      
      public static function applyVersionToString(param1:String) : String
      {
         var _loc4_:RegExp = null;
         var _loc5_:Object = null;
         if(param1 == null)
         {
            return param1;
         }
         var _loc2_:String = param1.toLowerCase();
         if(_loc2_.indexOf("http") == 0)
         {
            _loc4_ = /\//g;
            _loc4_.lastIndex = 8;
            _loc5_ = _loc4_.exec(_loc2_);
            if(_loc5_ != null && _loc5_.index > 8 && _loc5_.index < _loc2_.length - 1)
            {
               _loc2_ = _loc2_.substr(_loc5_.index + 1);
            }
         }
         var _loc3_:String = VersionURLAppender.getInstance().getURLVersionPostfix(_loc2_);
         return param1 + _loc3_;
      }
      
      private static function applyCDN(param1:IMSP_Loader) : void
      {
         if(param1.sourceUrl == null)
         {
            return;
         }
         var _loc2_:String = param1.sourceUrl.toString().toLowerCase();
         if(_loc2_.indexOf("http") != 0)
         {
            param1.sourceUrl = defaultCdnBasePath + param1.sourceUrl.toString();
         }
      }
      
      public static function setMaxLoadsSetting(param1:String) : void
      {
         var _loc2_:int = int(parseInt(param1));
         if(_loc2_ > 0)
         {
            MAX_CONCURRENT_LOADS = _loc2_ - RESERVED_LOADS_HIGH_PRIO - RESERVED_LOADS_CACHED;
            if(MAX_CONCURRENT_LOADS < 1)
            {
               RESERVED_LOADS_HIGH_PRIO = 1;
               RESERVED_LOADS_CACHED = 1;
               MAX_CONCURRENT_LOADS = _loc2_ - RESERVED_LOADS_HIGH_PRIO - RESERVED_LOADS_CACHED;
            }
            if(MAX_CONCURRENT_LOADS < 1)
            {
               MAX_CONCURRENT_LOADS = 1;
            }
         }
      }
      
      private static function LoadNext() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(urlLoadedBeforeLoadRequests.length > 0)
         {
            LoadNextFromArray(urlLoadedBeforeLoadRequests,-1);
            return;
         }
         if(urlAlreadyLoadingLoadRequests.length > 0)
         {
            LoadNextFromArray(urlAlreadyLoadingLoadRequests,0);
            return;
         }
         if(NonDeletableLoadRequests.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < NonDeletableLoadRequests.length)
            {
               if(NonDeletableLoadRequests[_loc1_] is Array && NonDeletableLoadRequests[_loc1_].length > 0)
               {
                  LoadNextFromArray(NonDeletableLoadRequests[_loc1_],_loc1_);
                  return;
               }
               _loc1_++;
            }
         }
         if(DeletableLoadRequests.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < DeletableLoadRequests.length)
            {
               if(DeletableLoadRequests[_loc2_] is Array && DeletableLoadRequests[_loc2_].length > 0)
               {
                  LoadNextFromArray(DeletableLoadRequests[_loc2_],_loc2_);
                  return;
               }
               _loc2_++;
            }
         }
      }
      
      private static function LoadNextFromArray(param1:Array, param2:int) : void
      {
         var _loc3_:IMSP_Loader = null;
         if(param1.length == 0 || isReset)
         {
            return;
         }
         if(currentLoaders.length < MAX_CONCURRENT_LOADS || param2 <= PRIORITY_UI && currentLoaders.length < MAX_CONCURRENT_LOADS + RESERVED_LOADS_HIGH_PRIO || param2 == PRIORITY_CACHED && currentLoaders.length < MAX_CONCURRENT_LOADS + RESERVED_LOADS_HIGH_PRIO + RESERVED_LOADS_CACHED)
         {
            _loc3_ = IMSP_Loader(param1[0]);
            if(currentLoaders.indexOf(_loc3_) < 0)
            {
               currentLoaders.push(_loc3_);
               param1.splice(0,1);
               ExecuteLoadRequest(_loc3_);
            }
         }
      }
      
      private static function ExecuteLoadRequest(param1:IMSP_Loader) : void
      {
         HookUpToLoadEvents(param1);
         param1.doLoad();
      }
      
      private static function HookUpToLoadEvents(param1:IMSP_Loader) : void
      {
         param1.addEventListener(Event.COMPLETE,OnLoadComplete,false,int.MAX_VALUE - 1);
         param1.addEventListener(IOErrorEvent.IO_ERROR,OnIOError);
      }
      
      private static function UnhookFromLoadEvents(param1:IMSP_Loader) : void
      {
         param1.removeEventListener(Event.COMPLETE,OnLoadComplete);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,OnIOError);
      }
      
      private static function OnLoadComplete(param1:Event) : void
      {
         if(param1.currentTarget is IMSP_Loader)
         {
            UnhookFromLoadEvents(param1.currentTarget as IMSP_Loader);
            LoadOperationComplete(param1.currentTarget as IMSP_Loader);
         }
      }
      
      private static function OnIOError(param1:IOErrorEvent) : void
      {
         UnhookFromLoadEvents(param1.currentTarget as IMSP_Loader);
         LoadOperationComplete(param1.currentTarget as IMSP_Loader,true);
         var _loc2_:IMSP_Loader = param1.currentTarget as IMSP_Loader;
         var _loc3_:String = " Not an IMSP_Loader, ";
         if(_loc2_)
         {
            _loc3_ = "IMSP_Loader.source = " + _loc2_.sourceUrl + ", ";
         }
      }
      
      public static function LoadOperationComplete(param1:IMSP_Loader, param2:Boolean = false) : void
      {
         if(tmpCacheOn)
         {
            cachedUrls[param1.sourceUrl] = LOADED_BEFORE;
         }
         var _loc3_:Boolean = !param1.isDeletable || !isReset;
         removeLoader(param1);
         if(currentLoaders.length == 0)
         {
            isReset = false;
         }
         LoadNext();
         if(!param2 && _loc3_ && param1.LoadCallBack != null)
         {
            param1.LoadCallBack(param1);
         }
         if(param2 && _loc3_ && param1.LoadFailCallBack != null)
         {
            param1.LoadFailCallBack(param1);
         }
         if(param2)
         {
            AssetErrorLogger.sendErrorEventToLoggly(param1.sourceUrl);
         }
      }
      
      private static function removeLoader(param1:IMSP_Loader) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < currentLoaders.length)
         {
            if(currentLoaders[_loc2_] == param1)
            {
               currentLoaders.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public static function Reset(param1:Boolean) : void
      {
         if(currentLoaders.length > 0)
         {
            isReset = true;
         }
         if(param1)
         {
            urlLoadedBeforeLoadRequests = [];
            urlAlreadyLoadingLoadRequests = [];
            NonDeletableLoadRequests = [];
         }
         DeletableLoadRequests = [];
      }
   }
}

