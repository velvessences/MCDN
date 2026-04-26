package com.moviestarplanet.assetManager
{
   import com.moviestarplanet.assetManager.loaders.AssetLoader;
   
   public class AssetBundle
   {
      
      protected var _onSuccess:Function;
      
      protected var _onFail:Function;
      
      private var loadersToLoad:Vector.<AssetLoader> = new Vector.<AssetLoader>();
      
      private var loadersCurrentlyLoading:Vector.<AssetLoader> = new Vector.<AssetLoader>();
      
      public var loadersFinished:Vector.<AssetLoader> = new Vector.<AssetLoader>();
      
      private var alreadyStarted:Boolean = false;
      
      private var tempAssetLoader:AssetLoader;
      
      public function AssetBundle(param1:Function = null, param2:Function = null)
      {
         super();
         this._onSuccess = param1;
         this._onFail = param2;
      }
      
      public function addLoader(param1:AssetLoader) : void
      {
         this.loadersToLoad.push(param1);
         if(this.alreadyStarted)
         {
            this.tryNext();
         }
      }
      
      public function load() : void
      {
         this.alreadyStarted = true;
         this.tryNext();
      }
      
      private function tryNext() : void
      {
         if(this.loadersCurrentlyLoading.length >= 1)
         {
            return;
         }
         if(this.loadersToLoad.length == 0)
         {
            if(this.loadersCurrentlyLoading.length == 0)
            {
               this.alreadyStarted = false;
               this.triggerOnSuccess();
               return;
            }
         }
         var _loc1_:AssetLoader = this.loadersToLoad.shift();
         if(_loc1_ != null)
         {
            this.loadersCurrentlyLoading.push(_loc1_);
            if(_loc1_._onSuccessForAssetBundle != null || _loc1_._onFailForAssetBundle != null)
            {
            }
            _loc1_._onSuccessForAssetBundle = this.successNext;
            _loc1_._onFailForAssetBundle = this.failNext;
            _loc1_.load();
         }
      }
      
      private function successNext(param1:AssetLoader) : void
      {
         this.tempAssetLoader = null;
         var _loc2_:Number = Number(this.loadersCurrentlyLoading.indexOf(param1));
         if(_loc2_ != -1)
         {
            if(_loc2_ == 0)
            {
               this.tempAssetLoader = this.loadersCurrentlyLoading.shift();
            }
            else if(_loc2_ == this.loadersCurrentlyLoading.length - 1)
            {
               this.tempAssetLoader = this.loadersCurrentlyLoading.pop();
            }
            else
            {
               this.tempAssetLoader = this.loadersCurrentlyLoading.slice(_loc2_,_loc2_ + 1)[0];
            }
            this.loadersFinished.push(this.tempAssetLoader);
         }
         this.tempAssetLoader = null;
         this.tryNext();
      }
      
      private function failNext(param1:AssetLoader) : void
      {
         trace("bundle has failed to load a file");
      }
      
      protected function triggerOnSuccess() : void
      {
         if(this._onSuccess != null)
         {
            this._onSuccess(this);
         }
         this.dispose();
      }
      
      protected function triggerOnFail() : void
      {
         if(this._onFail != null)
         {
            this._onFail(this);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:AssetLoader = null;
         var _loc2_:AssetLoader = null;
         this._onSuccess = null;
         this._onFail = null;
         if(this.loadersCurrentlyLoading != null)
         {
            while(this.loadersCurrentlyLoading.length > 0)
            {
               _loc1_ = this.loadersCurrentlyLoading.shift();
               _loc1_.dispose();
            }
            this.loadersCurrentlyLoading.length = 0;
            this.loadersCurrentlyLoading = null;
         }
         if(this.loadersToLoad != null)
         {
            while(this.loadersToLoad.length > 0)
            {
               _loc2_ = this.loadersToLoad.shift();
               _loc2_.dispose();
            }
            this.loadersToLoad.length = 0;
            this.loadersToLoad = null;
         }
         if(this.loadersFinished != null)
         {
            this.loadersFinished.length = 0;
            this.loadersFinished = null;
         }
      }
   }
}

