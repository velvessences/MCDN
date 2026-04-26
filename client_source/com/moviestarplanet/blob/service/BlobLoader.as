package com.moviestarplanet.blob.service
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class BlobLoader
   {
      
      private var _singleBlobLoaders:Dictionary;
      
      private var _singleBlobResults:Dictionary;
      
      private var _totalRequestsCount:int;
      
      private var _finishedRequestsCount:int;
      
      private var _allFinishedCallback:Function;
      
      public function BlobLoader()
      {
         super();
      }
      
      public static function set BlobServerUrl(param1:String) : void
      {
         SingleBlobLoader.blobServerUrl = param1;
      }
      
      public function RequestLoad(param1:String, param2:Array, param3:Function, param4:Function = null, param5:int = 2, param6:Boolean = true, param7:Array = null) : void
      {
         var _loc9_:int = 0;
         var _loc10_:SingleBlobLoader = null;
         this._allFinishedCallback = param3;
         this._singleBlobLoaders = new Dictionary();
         this._singleBlobResults = new Dictionary();
         this._finishedRequestsCount = 0;
         this._totalRequestsCount = param2.length;
         var _loc8_:int = 0;
         while(_loc8_ < param2.length)
         {
            _loc9_ = int(param2[_loc8_] as int);
            _loc10_ = new SingleBlobLoader();
            if(param7 != null && param7.length > _loc8_)
            {
               _loc10_.CacheTimestamp = param7[_loc8_];
            }
            this._singleBlobLoaders[_loc9_] = _loc10_;
            this._singleBlobResults[_loc9_] = null;
            _loc10_.RequestLoad(param1,_loc9_,this.SingleBlobLoadedHandler);
            _loc8_++;
         }
      }
      
      private function SingleBlobLoadedHandler(param1:String, param2:int, param3:ByteArray) : void
      {
         this._singleBlobResults[param2] = param3;
         ++this._finishedRequestsCount;
         if(this._finishedRequestsCount == this._totalRequestsCount)
         {
            this._allFinishedCallback(this._singleBlobResults);
         }
      }
   }
}

