package com.moviestarplanet.assetManager.externalHelpers
{
   import com.moviestarplanet.assetManager.AssetManagerStats;
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   import com.moviestarplanet.minimalCompsWrapper.MinimalCompsWrapper;
   import flash.utils.Dictionary;
   
   public class CallManager
   {
      
      private namespace AssetManagerNS = "AssetManager";
      
      private static var _instance:CallManager;
      
      private static const totalLoadChannels:int = 10;
      
      private static var disabled:Boolean = false;
      
      private var loadChannels:Vector.<AssetLoader> = new Vector.<AssetLoader>();
      
      private var awaitingLoad:Vector.<AssetLoader> = new Vector.<AssetLoader>();
      
      private var loadingWrappers:Dictionary = new Dictionary();
      
      private var storedWrappers:Vector.<AssetLoader> = new Vector.<AssetLoader>();
      
      public function CallManager(param1:Function)
      {
         super();
         if(param1 != _singletonUnBlocker)
         {
            throw new Error("CallManager should only be instantiated through .getInstance()");
         }
         this.loadChannels.length = totalLoadChannels;
      }
      
      private static function getInstance() : CallManager
      {
         if(_instance == null)
         {
            _instance = new CallManager(_singletonUnBlocker);
         }
         return _instance;
      }
      
      private static function _singletonUnBlocker() : void
      {
      }
      
      public static function loaderRequestedLoad(param1:AssetLoader) : void
      {
         if(param1.assetKey == null || param1.assetKey == "")
         {
            throw new Error("AssetLoader has no assetKey");
         }
         getInstance()._loaderRequestedLoad(param1);
      }
      
      public static function loaderSucceeded(param1:AssetLoader) : void
      {
         getInstance()._loaderSucceeded(param1);
      }
      
      public static function loaderFailed(param1:AssetLoader) : void
      {
         getInstance()._loaderFailed(param1);
      }
      
      public static function loaderDisposed(param1:AssetLoader) : void
      {
         getInstance()._loaderDisposed(param1);
      }
      
      private function _loaderRequestedLoad(param1:AssetLoader) : void
      {
         if(this.isLoading(param1))
         {
            throw new Error("you are requesting to load something that is currently loading... this should not be possible");
         }
         if(this.isInQue(param1))
         {
            throw new Error("you are requesting to load something that is currently in que... this should not be possible");
         }
         if(param1.isWrapper)
         {
            this.storedWrappers.push(param1);
         }
         else
         {
            this.awaitingLoad.push(param1);
         }
         this.tryToLoadNext();
      }
      
      private function _loaderSucceeded(param1:AssetLoader) : void
      {
         var _loc2_:AssetLoader = null;
         var _loc3_:* = 0;
         if(this.isLoading(param1))
         {
            _loc3_ = 0;
            while(_loc3_ < this.awaitingLoad.length)
            {
               if(this.awaitingLoad[_loc3_].assetKey == param1.assetKey)
               {
                  if(this.awaitingLoad[_loc3_]["constructor"] == param1["constructor"])
                  {
                     _loc2_ = this.awaitingLoad[_loc3_];
                     if(_loc2_.forceLoad == false)
                     {
                        this.removeFromQue(_loc2_);
                        _loc2_.CallManagerSaysYouHaveLoaded();
                        _loc3_--;
                     }
                  }
               }
               _loc3_++;
            }
            this.removeFromLoadChannels(param1);
         }
         else if(param1.isWrapper)
         {
            this.removeFromWrappedLoading(param1);
         }
         this.tryToLoadNext();
      }
      
      private function _loaderFailed(param1:AssetLoader) : void
      {
         this.removeFromLoadChannels(param1);
         if(param1.isWrapper)
         {
            this.removeFromWrappedLoading(param1);
         }
         this.tryToLoadNext();
      }
      
      private function _loaderDisposed(param1:AssetLoader) : void
      {
         if(param1.isWrapper)
         {
            this.removeFromWrappedLoading(param1);
         }
         if(this.isLoading(param1))
         {
            this.removeFromLoadChannels(param1);
            this.tryToLoadNext();
         }
         else if(this.isInQue(param1))
         {
            this.removeFromQue(param1);
         }
      }
      
      private function isInQue(param1:AssetLoader) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.awaitingLoad.length)
         {
            if(this.awaitingLoad[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function isLoading(param1:AssetLoader) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.loadChannels.length)
         {
            if(this.loadChannels[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function removeFromLoadChannels(param1:AssetLoader) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.loadChannels.length)
         {
            if(this.loadChannels[_loc2_] == param1)
            {
               this.loadChannels[_loc2_] = null;
               return;
            }
            _loc2_++;
         }
      }
      
      private function removeFromQue(param1:AssetLoader) : void
      {
         var _loc2_:int = int(this.awaitingLoad.indexOf(param1));
         if(_loc2_ == -1)
         {
            throw new Error("missing loader from awaitingLoad");
         }
         this.awaitingLoad.splice(_loc2_,1);
      }
      
      private function continueLoading(param1:AssetLoader) : void
      {
         this.removeFromQue(param1);
         var _loc2_:int = 0;
         while(_loc2_ < this.loadChannels.length)
         {
            if(this.loadChannels[_loc2_] == null)
            {
               this.loadChannels[_loc2_] = param1;
               return;
            }
            _loc2_++;
         }
      }
      
      private function findSimilarThatAreLoading(param1:AssetLoader) : AssetLoader
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.loadChannels.length)
         {
            if(this.loadChannels[_loc2_] == null)
            {
               _loc2_++;
            }
            else
            {
               if(this.loadChannels[_loc2_].assetKey == param1.assetKey)
               {
                  if(this.loadChannels[_loc2_].type == param1.type)
                  {
                     return this.loadChannels[_loc2_];
                  }
               }
               _loc2_++;
            }
         }
         return null;
      }
      
      private function tryToLoadNext() : void
      {
         var _loc2_:AssetLoader = null;
         this.tryToParseWrapperLoaders();
         if(this.awaitingLoad.length == 0)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.loadChannels.length)
         {
            if(this.loadChannels[_loc1_] == null)
            {
               break;
            }
            _loc1_++;
         }
         if(_loc1_ >= this.loadChannels.length)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.awaitingLoad.length)
         {
            if(!this.findSimilarThatAreLoading(this.awaitingLoad[_loc3_]))
            {
               _loc2_ = this.awaitingLoad[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_ != null)
         {
            this.loadChannels[_loc1_] = _loc2_;
            this.removeFromQue(_loc2_);
            MinimalCompsWrapper.moveComponent(_loc2_.assetKey,AssetManagerStats.debugCreatedPanel,AssetManagerStats.debugLoadingPanel);
            _loc2_.doLoad();
         }
      }
      
      private function tryToParseWrapperLoaders() : void
      {
         var _loc1_:AssetLoader = null;
         var _loc2_:* = 0;
         while(_loc2_ < this.storedWrappers.length)
         {
            _loc1_ = this.storedWrappers[_loc2_];
            if(this.loadingWrappers[_loc1_.assetKey + _loc1_.type] == undefined || this.loadingWrappers[_loc1_.assetKey + _loc1_.type] == null)
            {
               this.loadingWrappers[_loc1_.assetKey + _loc1_.type] = _loc1_;
               this.storedWrappers.splice(_loc2_,1);
               _loc1_.doLoad();
               _loc2_--;
            }
            _loc2_++;
         }
      }
      
      private function removeFromWrappedLoading(param1:AssetLoader) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.storedWrappers.length)
         {
            if(this.storedWrappers[_loc2_] == param1)
            {
               this.storedWrappers.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
         this.loadingWrappers[param1.assetKey + param1.type] = null;
         delete this.loadingWrappers[param1.assetKey + param1.type];
      }
   }
}

