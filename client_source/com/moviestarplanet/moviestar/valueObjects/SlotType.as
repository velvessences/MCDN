package com.moviestarplanet.moviestar.valueObjects
{
   public class SlotType
   {
      
      private var _SlotTypeId:int;
      
      private var _Name:String;
      
      public function SlotType()
      {
         super();
      }
      
      public function get SlotTypeId() : int
      {
         return this._SlotTypeId;
      }
      
      public function get Name() : String
      {
         return this._Name;
      }
      
      public function set SlotTypeId(param1:int) : void
      {
         this._SlotTypeId = param1;
      }
      
      public function set Name(param1:String) : void
      {
         this._Name = param1;
      }
   }
}

