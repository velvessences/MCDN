package com.moviestarplanet.assetManager.cache
{
   import com.moviestarplanet.commonaccesspoints.DebugAccessPoint;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public final class MemoryCacheManager
   {
      
      public static const DEFAULT_MEMORY_UPPER_LIMIT:int = 3 * 512 * 1024;
      
      public static const DEFAULT_MEMORY_LOWER_LIMIT:int = 180 * 1024;
      
      public static const MINIMUM_TIMEOUT_INTERVAL:int = 20;
      
      private var localPath:String;
      
      private var cacheTrimTimer:Timer;
      
      private var nextTimeoutTime:int = 2147483646;
      
      private var nextTimeoutElement:CacheElement;
      
      private var cacheTable:Dictionary;
      
      private var totalCacheSize:int = 0;
      
      private var memoryUsageUpperLimit:int;
      
      private var memoryUsageLowerLimit:int;
      
      public function MemoryCacheManager(param1:int = 1572864, param2:int = 184320)
      {
         super();
         this.memoryUsageUpperLimit = param1;
         this.memoryUsageLowerLimit = param2;
         this.cacheTable = new Dictionary();
         this.cacheTrimTimer = new Timer(99999);
         this.cacheTrimTimer.addEventListener(TimerEvent.TIMER,this.onTrimCacheTimer);
      }
      
      private function showCacheInfo() : void
      {
         var _loc2_:CacheElement = null;
         var _loc3_:int = 0;
         var _loc4_:CacheElement = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this.cacheTable)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("useCount",Array.NUMERIC | Array.DESCENDING);
         trace("--------------------------CACHE STATS ---------------------");
         trace(" - memCache size:",this.totalCacheSize,"(" + int(this.totalCacheSize / 1024) + "KB)");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            trace(" -",_loc4_.key + " (" + _loc4_.data.length + "b) - Use count:",_loc4_.useCount);
            _loc3_++;
         }
         trace("--------------------------CACHE STATS ---------------------");
      }
      
      protected function onTrimCacheTimer(param1:TimerEvent) : void
      {
         this.removeNext();
      }
      
      private function removeNext() : void
      {
         this.totalCacheSize -= this.nextTimeoutElement.data.length;
         delete this.cacheTable[this.nextTimeoutElement.key];
         this.nextTimeoutElement.data.clear();
         this.nextTimeoutElement.data = null;
         this.findAndSetNextTimeoutElement();
         if(this.totalCacheSize > this.memoryUsageUpperLimit)
         {
            this.removeNext();
         }
      }
      
      private function findAndSetNextTimeoutElement() : void
      {
         var _loc1_:CacheElement = null;
         this.nextTimeoutTime = int.MAX_VALUE - 1;
         for each(_loc1_ in this.cacheTable)
         {
            if(_loc1_.nextTimeoutTime < this.nextTimeoutTime)
            {
               this.nextTimeoutTime = _loc1_.nextTimeoutTime;
               this.nextTimeoutElement = _loc1_;
            }
         }
         if(this.nextTimeoutTime == int.MAX_VALUE - 1 || this.totalCacheSize < this.memoryUsageLowerLimit)
         {
            this.cacheTrimTimer.reset();
         }
         else
         {
            this.setNextTimeout(this.nextTimeoutElement.nextTimeoutTime,this.nextTimeoutElement);
         }
      }
      
      public function storeCopy(param1:ByteArray, param2:String, param3:int) : void
      {
         if(this.cacheTable[param2])
         {
            trace("trying to store the same key TWICE... This should not HAPPEN... INVESTIGATE");
            DebugAccessPoint.log("MemoryCacheManager.storeCopy(data, key, timeOutMs) being called more than once, KEY:" + param2);
            return;
         }
         if(param1.length <= 0 || param1.length > this.memoryUsageUpperLimit)
         {
            return;
         }
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeBytes(param1);
         _loc4_.position = 0;
         var _loc5_:CacheElement = new CacheElement();
         _loc5_.key = param2;
         _loc5_.data = _loc4_;
         _loc5_.timeOutDelay = param3;
         _loc5_.updateTimeoutTime();
         this.cacheTable[param2] = _loc5_;
         if(_loc5_.nextTimeoutTime < this.nextTimeoutTime)
         {
            this.setNextTimeout(_loc5_.nextTimeoutTime,_loc5_);
         }
         this.totalCacheSize += param1.length;
         if(this.totalCacheSize > this.memoryUsageUpperLimit)
         {
            this.removeNext();
         }
      }
      
      public function getCopy(param1:String) : ByteArray
      {
         var _loc2_:CacheElement = this.cacheTable[param1];
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeBytes(_loc2_.data);
         _loc3_.position = 0;
         _loc2_.updateTimeoutTime();
         if(this.nextTimeoutElement == _loc2_)
         {
            this.findAndSetNextTimeoutElement();
         }
         ++_loc2_.useCount;
         return _loc3_;
      }
      
      private function setNextTimeout(param1:int, param2:CacheElement) : void
      {
         this.nextTimeoutTime = param1;
         this.nextTimeoutElement = param2;
         var _loc3_:int = param1 - getTimer();
         this.cacheTrimTimer.reset();
         this.cacheTrimTimer.delay = _loc3_ > 20 ? _loc3_ : 20;
         this.cacheTrimTimer.start();
      }
      
      public function dispose() : void
      {
         var _loc1_:CacheElement = null;
         if(this.cacheTable)
         {
            for each(_loc1_ in this.cacheTable)
            {
               _loc1_.data.clear();
               _loc1_.data = null;
            }
            this.cacheTable = null;
         }
      }
   }
}

import flash.utils.ByteArray;
import flash.utils.getTimer;

class CacheElement
{
   
   public var key:String;
   
   public var data:ByteArray;
   
   public var nextTimeoutTime:int;
   
   public var timeOutDelay:int;
   
   public var useCount:int = 0;
   
   public function CacheElement()
   {
      super();
   }
   
   public function updateTimeoutTime() : void
   {
      this.nextTimeoutTime = getTimer() + this.timeOutDelay;
   }
}
