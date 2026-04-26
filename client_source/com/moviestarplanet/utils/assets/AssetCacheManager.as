package com.moviestarplanet.utils.assets
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class AssetCacheManager
   {
      
      private static var assetArray:Array;
      
      private static var manager:AssetCacheManager;
      
      private static var _verboseDebug:Boolean = true;
      
      private static var CacheTTL:int = 30000;
      
      private static var time:Timer = new Timer(5000);
      
      private static var isInitialized:Boolean = false;
      
      public function AssetCacheManager()
      {
         super();
      }
      
      public static function get verboseDebug() : Boolean
      {
         return _verboseDebug;
      }
      
      public static function set verboseDebug(param1:Boolean) : void
      {
         _verboseDebug = param1;
      }
      
      public static function initialize() : void
      {
         if(manager == null)
         {
            isInitialized = true;
            time.addEventListener(TimerEvent.TIMER,onTimer);
            time.start();
            manager = new AssetCacheManager();
            assetArray = new Array();
         }
      }
      
      protected static function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:Number = Number(new Date().time);
         var _loc3_:int = 0;
         while(_loc3_ < assetArray.length)
         {
            if(_loc2_ - assetArray[_loc3_].lastDataAccess >= CacheTTL)
            {
               assetArray[_loc3_] = null;
               assetArray.splice(_loc3_,1);
            }
            _loc3_++;
         }
         if(assetArray.length == 0)
         {
            time.stop();
         }
         if(verboseDebug)
         {
            trace("Cache size is now: " + assetArray.length);
         }
      }
      
      public static function addData(param1:String, param2:*) : void
      {
         if(!isInitialized)
         {
            initialize();
         }
         if(verboseDebug)
         {
            trace("Cache Saving for : " + param1);
         }
         if(hasDataForPath(param1))
         {
            return;
         }
         if(assetArray.length == 0)
         {
            if(!time.running)
            {
               time.start();
            }
         }
         var _loc3_:Object = new Object();
         _loc3_.id = param1;
         _loc3_.data = param2;
         _loc3_.hits = 0;
         _loc3_.lastDataAccess = new Date().time;
         assetArray.push(_loc3_);
      }
      
      public static function getData(param1:String) : *
      {
         if(!isInitialized)
         {
            initialize();
         }
         if(verboseDebug)
         {
            trace("Cache hit on: " + param1);
         }
         var _loc2_:int = 0;
         while(_loc2_ < assetArray.length)
         {
            if(assetArray[_loc2_].id == param1)
            {
               ++assetArray[_loc2_].hits;
               assetArray[_loc2_].lastDataAccess = new Date().time;
               return assetArray[_loc2_].data;
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function hasDataForPath(param1:String) : Boolean
      {
         if(!isInitialized)
         {
            initialize();
         }
         if(assetArray == null)
         {
            return false;
         }
         var _loc2_:int = 0;
         while(_loc2_ < assetArray.length)
         {
            if(assetArray[_loc2_].id == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}

