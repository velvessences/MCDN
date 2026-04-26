package com.moviestarplanet.clientcensor
{
   import flash.events.*;
   import flash.net.*;
   
   public class CSV extends URLLoader
   {
      
      private var FieldSeperator:String;
      
      private var FieldEnclosureToken:String;
      
      private var RecordsetDelimiter:String;
      
      private var Header:Array;
      
      private var EmbededHeader:Boolean;
      
      private var HeaderOverwrite:Boolean;
      
      private var SortField:*;
      
      private var SortSequence:String;
      
      public function CSV(param1:URLRequest = null)
      {
         super();
         this.fieldSeperator = ",";
         this.fieldEnclosureToken = "\"";
         this.recordsetDelimiter = "\r";
         this.header = new Array();
         this.embededHeader = true;
         this.headerOverwrite = false;
         if(param1)
         {
            load(param1);
         }
         this.dataFormat = URLLoaderDataFormat.TEXT;
         addEventListener(Event.COMPLETE,this.decode);
      }
      
      public function get fieldSeperator() : String
      {
         return this.FieldSeperator;
      }
      
      public function get fieldEnclosureToken() : String
      {
         return this.FieldEnclosureToken;
      }
      
      public function get recordsetDelimiter() : String
      {
         return this.RecordsetDelimiter;
      }
      
      public function get embededHeader() : Boolean
      {
         return this.EmbededHeader;
      }
      
      public function get headerOverwrite() : Boolean
      {
         return this.HeaderOverwrite;
      }
      
      public function get header() : Array
      {
         return this.Header;
      }
      
      public function get headerHasValues() : Boolean
      {
         var check:Boolean = false;
         try
         {
            if(this.Header.length > 0)
            {
               check = true;
            }
         }
         catch(e:Error)
         {
            check = false;
         }
         finally
         {
            return check;
         }
      }
      
      public function get dataHasValues() : Boolean
      {
         var check:Boolean = false;
         try
         {
            if(data.length > 0)
            {
               check = true;
            }
         }
         catch(e:Error)
         {
            check = false;
         }
         finally
         {
            return check;
         }
      }
      
      public function set fieldSeperator(param1:String) : void
      {
         this.FieldSeperator = param1;
      }
      
      public function set fieldEnclosureToken(param1:String) : void
      {
         this.FieldEnclosureToken = param1;
      }
      
      public function set recordsetDelimiter(param1:String) : void
      {
         this.RecordsetDelimiter = param1;
      }
      
      public function set embededHeader(param1:Boolean) : void
      {
         this.EmbededHeader = param1;
      }
      
      public function set headerOverwrite(param1:Boolean) : void
      {
         this.HeaderOverwrite = param1;
      }
      
      public function set header(param1:Array) : void
      {
         if(!this.embededHeader && !this.headerHasValues || !this.embededHeader && this.headerHasValues && this.headerOverwrite || this.headerOverwrite)
         {
            this.Header = param1;
         }
      }
      
      public function getRecordSet(param1:int) : Array
      {
         if(this.dataHasValues)
         {
            return data[param1];
         }
         return null;
      }
      
      public function addRecordSet(param1:Array, param2:* = null) : void
      {
         if(!this.dataHasValues)
         {
            data = new Array();
         }
         if(!param2 && param2 != 0)
         {
            data.push(param1);
         }
         else
         {
            data.splice(param2,0,param1);
         }
      }
      
      public function deleteRecordSet(param1:int, param2:int = 1) : Boolean
      {
         if(this.dataHasValues && param1 < data.length && param2 > 0)
         {
            return data.splice(param1,param2);
         }
         return false;
      }
      
      public function search(param1:*, param2:Boolean = true) : Array
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc3_:Array = new Array();
         for each(_loc4_ in data)
         {
            if(param1 is Array)
            {
               for each(_loc5_ in param1)
               {
                  if(_loc4_.indexOf(String(_loc5_)) >= 0)
                  {
                     _loc3_.push(_loc4_);
                  }
               }
            }
            else if(_loc4_.indexOf(String(param1)) >= 0)
            {
               _loc3_.push(_loc4_);
            }
         }
         if(param2 && _loc3_.length > 2)
         {
            _loc6_ = int(_loc3_.length - 1);
         }
         while(_loc6_--)
         {
            _loc7_ = int(_loc3_.length);
            while(--_loc7_ > _loc6_)
            {
               if(_loc3_[_loc6_] == _loc3_[_loc7_])
               {
                  _loc3_.splice(_loc7_,1);
               }
            }
         }
         return _loc3_;
      }
      
      public function sort(param1:* = 0, param2:String = "ASC") : void
      {
         this.SortSequence = param2;
         if(this.headerHasValues && this.header.indexOf(param1) >= 0)
         {
            this.SortField = this.header.indexOf(param1);
         }
         else
         {
            this.SortField = param1;
         }
         if(this.dataHasValues)
         {
            data.sort(this.sort2DArray);
         }
      }
      
      public function decode(param1:Event = null) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Array = new Array();
         data = data.toString().split(this.recordsetDelimiter);
         var _loc4_:uint = 0;
         while(_loc4_ < data.length)
         {
            if(!Boolean(_loc2_ % 2))
            {
               _loc3_.push(data[_loc4_]);
            }
            else
            {
               _loc3_[_loc3_.length - 1] += data[_loc4_];
            }
            _loc2_ += StringUtils.count(data[_loc4_],this.fieldEnclosureToken);
            _loc4_++;
         }
         _loc3_ = _loc3_.filter(this.isNotEmptyRecord);
         _loc3_.forEach(this.fieldDetection);
         if(this.embededHeader && this.headerOverwrite)
         {
            _loc3_.shift();
         }
         else if(this.embededHeader && this.headerHasValues)
         {
            _loc3_.shift();
         }
         else if(this.embededHeader)
         {
            this.Header = _loc3_.shift();
         }
         data = _loc3_;
      }
      
      public function encode() : void
      {
         var _loc2_:Array = null;
         var _loc1_:String = "";
         if(this.headerHasValues && this.header.length > 0)
         {
            this.embededHeader = true;
            data.unshift(this.header);
         }
         if(this.dataHasValues)
         {
            for each(_loc2_ in data)
            {
               _loc1_ += _loc2_.join(this.fieldSeperator) + this.recordsetDelimiter;
            }
         }
         data = _loc1_;
      }
      
      private function fieldDetection(param1:*, param2:int, param3:Array) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:Array = new Array();
         var _loc6_:Array = param1.split(this.fieldSeperator);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_.length)
         {
            if(!Boolean(_loc4_ % 2))
            {
               _loc5_.push(StringUtils.trim(_loc6_[_loc7_]));
            }
            else
            {
               _loc5_[_loc5_.length - 1] += this.fieldSeperator + _loc6_[_loc7_];
            }
            _loc4_ += StringUtils.count(_loc6_[_loc7_],this.fieldEnclosureToken);
            _loc7_++;
         }
         param3[param2] = _loc5_;
      }
      
      private function sort2DArray(param1:Array, param2:Array) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:int = this.SortSequence == "ASC" ? -1 : 1;
         if(String(param1[this.SortField]) < String(param2[this.SortField]))
         {
            _loc3_ = _loc4_;
         }
         else if(String(param1[this.SortField]) > String(param2[this.SortField]))
         {
            _loc3_ = -_loc4_;
         }
         else
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      private function isNotEmptyRecord(param1:*, param2:int, param3:Array) : Boolean
      {
         return Boolean(StringUtils.trim(param1));
      }
      
      public function dump() : String
      {
         var _loc3_:uint = 0;
         var _loc1_:String = "data:Array -> [\r";
         var _loc2_:int = 0;
         while(_loc2_ < data.length)
         {
            _loc1_ += "\t[" + _loc2_ + "]:Array -> [\r";
            _loc3_ = 0;
            while(_loc3_ < data[_loc2_].length)
            {
               _loc1_ += "\t\t[" + _loc3_ + "]:String -> " + data[_loc2_][_loc3_] + "\r";
               _loc3_++;
            }
            _loc1_ += "\t]\r";
            _loc2_++;
         }
         return _loc1_ + "]\r";
      }
   }
}

