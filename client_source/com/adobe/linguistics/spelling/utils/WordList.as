package com.adobe.linguistics.spelling.utils
{
   public class WordList
   {
      
      private var _words:Array;
      
      private var _sorted:Boolean;
      
      public function WordList(param1:Array = null)
      {
         super();
         if(param1 != null)
         {
            this._words = param1;
         }
         else
         {
            this._words = new Array();
         }
      }
      
      public function toArray() : Array
      {
         return this._words;
      }
      
      public function set data(param1:Array) : void
      {
         this._words = param1;
      }
      
      public function get data() : Array
      {
         return this._words;
      }
      
      public function insert(param1:String) : Boolean
      {
         var _loc5_:uint = 0;
         if(this._words.length == 0)
         {
            this._words.push(param1);
            return true;
         }
         var _loc2_:uint = 0;
         var _loc3_:uint = this._words.length - 1;
         var _loc4_:uint = (_loc2_ + _loc3_) / 2;
         while(_loc2_ < _loc3_)
         {
            if(this._words[_loc4_] < param1)
            {
               _loc2_ = _loc4_ + 1;
            }
            else
            {
               _loc3_ = _loc4_;
            }
            _loc4_ = (_loc2_ + _loc3_) / 2;
         }
         if(_loc2_ <= this._words.length - 1 && this._words[_loc2_] != param1)
         {
            _loc5_ = this._words[_loc2_] > param1 ? _loc2_ : uint(_loc2_ + 1);
            this._words.splice(_loc5_,0,param1);
            return true;
         }
         return false;
      }
      
      public function remove(param1:String) : Boolean
      {
         var _loc2_:int = this.lookup(param1);
         if(_loc2_ != -1)
         {
            this._words.splice(_loc2_,1);
            return true;
         }
         return false;
      }
      
      public function lookup(param1:String) : int
      {
         if(this._words.length == 0)
         {
            return -1;
         }
         var _loc2_:uint = 0;
         var _loc3_:uint = this._words.length - 1;
         var _loc4_:uint = (_loc2_ + _loc3_) / 2;
         while(_loc2_ < _loc3_)
         {
            if(this._words[_loc4_] < param1)
            {
               _loc2_ = _loc4_ + 1;
            }
            else
            {
               _loc3_ = _loc4_;
            }
            _loc4_ = (_loc2_ + _loc3_) / 2;
         }
         if(_loc2_ <= this._words.length - 1 && this._words[_loc2_] == param1)
         {
            return _loc2_;
         }
         return -1;
      }
      
      public function mergeWordLists(param1:WordList, param2:WordList) : WordList
      {
         return null;
      }
   }
}

