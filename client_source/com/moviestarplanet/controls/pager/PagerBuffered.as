package com.moviestarplanet.controls.pager
{
   import com.moviestarplanet.amf.PagerResultObject;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   
   public class PagerBuffered implements PagerBufferedInterface
   {
      
      public var ensureIntegrityOnRefresh:Boolean = false;
      
      private var pageSize:int;
      
      private var loadMethod:Function;
      
      private var loadMethodParams:Object;
      
      private var preBufferSize:int;
      
      private var postBufferSize:int;
      
      private var fetchingIndex:Array = new Array();
      
      private var buffer:Array = new Array();
      
      private var _overrideCallback:Function;
      
      private var indexToCallback:Dictionary = new Dictionary(true);
      
      private var currentPageIndex:int;
      
      private var _totalRecords:int;
      
      public function PagerBuffered(param1:int, param2:int, param3:int, param4:Function, param5:Object = null)
      {
         super();
         this.pageSize = param1;
         this.preBufferSize = param2;
         this.postBufferSize = param3;
         this.loadMethod = param4;
         this.loadMethodParams = param5;
         this.currentPageIndex = 0;
      }
      
      private function pageRequest(param1:int, param2:Function) : void
      {
         this.indexToCallback[param1] = param2;
      }
      
      private function pageAvailable(param1:int) : void
      {
         var _loc2_:int = param1;
         if(_loc2_ != this.currentPageIndex)
         {
            return;
         }
         var _loc3_:Function = this.indexToCallback[_loc2_];
         var _loc4_:PagerResultObject = this.buffer[_loc2_];
         if(_loc3_ == null)
         {
            if(this._overrideCallback != null)
            {
               this._overrideCallback(_loc4_.pageData);
               this._overrideCallback = null;
            }
            return;
         }
         if(_loc4_ == null)
         {
            return;
         }
         delete this.indexToCallback[_loc2_];
         _loc3_(_loc4_.pageData);
      }
      
      private function supplyPages(param1:Array, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param2)
         {
            _loc3_ = int(param1[0]);
            _loc4_ = param1.length * this.pageSize;
            this.supplyPage(_loc3_,_loc4_);
         }
         else
         {
            while(param1.length > 0)
            {
               _loc5_ = int(param1.shift());
               this.supplyPage(_loc5_,this.pageSize);
            }
         }
      }
      
      private function supplyDelayed(param1:int, param2:int) : void
      {
         if(this.loadMethodParams == null)
         {
            this.loadMethod(param1,param2,this.loadMethodResult);
         }
         else
         {
            this.loadMethod(this.loadMethodParams,param1,param2,this.loadMethodResult);
         }
      }
      
      private function supplyPage(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         if(this.buffer[param1] == null && this.fetchingIndex[param1] == null || this.buffer.length == 0)
         {
            this.fetchingIndex[param1] = true;
            _loc3_ = param1 == 0 ? 0 : 1000;
            if(this.preBufferSize == 0 && this.postBufferSize == 0)
            {
               _loc3_ = 0;
            }
            setTimeout(this.supplyDelayed,_loc3_,param1,param2);
         }
         else
         {
            this.pageAvailable(param1);
         }
      }
      
      private function loadMethodResult(param1:PagerResultObject) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:PagerResultObject = null;
         var _loc2_:int = param1.pageIndex;
         var _loc3_:Object = param1.pageData;
         this.currentPageIndex = param1.pageIndex;
         if(_loc3_ is Array && _loc2_ == 0 && _loc3_.length > this.pageSize)
         {
            _loc4_ = param1.pageData as Array;
            _loc5_ = _loc4_.length / this.pageSize;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = _loc6_ * this.pageSize;
               _loc8_ = (_loc6_ + 1) * this.pageSize;
               _loc9_ = _loc4_.slice(_loc7_,_loc8_);
               _loc10_ = new PagerResultObject(param1.totalRecords,_loc9_.length >= this.pageSize,_loc9_,_loc6_ + _loc2_);
               this.fillResult(_loc10_);
               _loc6_++;
            }
         }
         else
         {
            this.fillResult(param1);
         }
      }
      
      private function fillResult(param1:PagerResultObject) : void
      {
         var _loc2_:int = 0;
         if(this.buffer != null)
         {
            _loc2_ = param1.pageIndex;
            this.buffer[_loc2_] = param1;
            delete this.fetchingIndex[_loc2_];
            this._totalRecords = param1.totalRecords;
            this.pageAvailable(_loc2_);
         }
      }
      
      private function enforceBufferIntegrity(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.buffer.length)
         {
            if(_loc2_ < this.currentPageIndex - this.preBufferSize || _loc2_ > this.currentPageIndex + this.postBufferSize)
            {
               delete this.buffer[_loc2_];
               delete this.indexToCallback[_loc2_];
            }
            _loc2_++;
         }
         var _loc3_:Array = new Array();
         var _loc4_:int = int(Math.max(0,this.currentPageIndex - this.preBufferSize));
         while(_loc4_ < this.currentPageIndex + this.postBufferSize + 1)
         {
            _loc3_.push(_loc4_);
            _loc4_++;
         }
         this.supplyPages(_loc3_,param1);
      }
      
      public function ClearBuffer() : void
      {
         this.buffer = new Array();
      }
      
      public function Refresh(param1:Function = null) : void
      {
         this.buffer = new Array();
         this.pageRequest(this.currentPageIndex,param1);
         this.enforceBufferIntegrity(this.ensureIntegrityOnRefresh);
      }
      
      public function FirstPage(param1:Function = null) : void
      {
         this.ClearBuffer();
         this.currentPageIndex = 0;
         this.pageRequest(0,param1);
         this.enforceBufferIntegrity(true);
      }
      
      public function LastPage(param1:Function = null) : void
      {
         this.ClearBuffer();
         this.currentPageIndex = int((this._totalRecords - 1) / this.pageSize);
         this.pageRequest(this.currentPageIndex,param1);
         this.enforceBufferIntegrity(false);
      }
      
      public function PrevPage(param1:Function = null) : Boolean
      {
         if(this.currentPageIndex > 0 && this.IsAtFirstPage == false)
         {
            --this.currentPageIndex;
            this.pageRequest(this.currentPageIndex,param1);
            this.enforceBufferIntegrity(false);
            return true;
         }
         return false;
      }
      
      public function NextPage(param1:Function = null) : Boolean
      {
         if(this.buffer[this.currentPageIndex] != null && this.IsAtLastPage == false)
         {
            this.currentPageIndex += 1;
            this.pageRequest(this.currentPageIndex,param1);
            this.enforceBufferIntegrity(false);
            return true;
         }
         return false;
      }
      
      public function GotoPage(param1:int, param2:Function = null) : Boolean
      {
         this.currentPageIndex = param1;
         this.pageRequest(this.currentPageIndex,param2);
         this.enforceBufferIntegrity(false);
         return true;
      }
      
      public function get IsAtFirstPage() : Boolean
      {
         return this.currentPageIndex == 0;
      }
      
      public function get IsAtLastPage() : Boolean
      {
         return this.isTheEnd(this.currentPageIndex);
      }
      
      private function isTheEnd(param1:int) : Boolean
      {
         var _loc3_:Object = null;
         if(this.buffer[param1] == null)
         {
            return false;
         }
         if(this.buffer[param1].totalRecords <= this.pageSize || this.buffer[param1].totalRecords == 0)
         {
            return true;
         }
         var _loc2_:int = 0;
         for each(_loc3_ in this.buffer)
         {
            _loc2_ += _loc3_.totalRecords - 1;
         }
         return param1 == int(_loc2_ / this.pageSize);
      }
      
      public function get CurrentPageIndex() : int
      {
         return this.currentPageIndex;
      }
      
      public function get PageSize() : int
      {
         return this.pageSize;
      }
      
      public function get loadParams() : Object
      {
         return this.loadMethodParams;
      }
      
      public function set TotalRecords(param1:int) : void
      {
         this._totalRecords = param1;
      }
      
      public function get TotalRecords() : int
      {
         return this._totalRecords;
      }
      
      public function set overrideCallback(param1:Function) : void
      {
         this._overrideCallback = param1;
      }
      
      public function destroy() : void
      {
         var _loc1_:Object = null;
         this.loadMethod = null;
         this.loadMethodParams = null;
         if(this.fetchingIndex != null)
         {
            this.fetchingIndex.length = 0;
            this.fetchingIndex = null;
         }
         if(this.buffer != null)
         {
            this.buffer.length = 0;
            this.buffer = null;
         }
         this._overrideCallback = null;
         for(_loc1_ in this.indexToCallback)
         {
            delete this.indexToCallback[_loc1_];
         }
         this.indexToCallback = null;
      }
   }
}

