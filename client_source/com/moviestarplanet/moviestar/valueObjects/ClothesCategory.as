package com.moviestarplanet.moviestar.valueObjects
{
   public class ClothesCategory
   {
      
      private var _ClothesCategoryId:int;
      
      private var _Name:String;
      
      private var _SlotTypeId:int;
      
      private var _SlotType:com.moviestarplanet.moviestar.valueObjects.SlotType;
      
      public function ClothesCategory()
      {
         super();
      }
      
      public function get ClothesCategoryId() : int
      {
         return this._ClothesCategoryId;
      }
      
      public function get Name() : String
      {
         return this._Name;
      }
      
      public function get SlotTypeId() : int
      {
         return this._SlotTypeId;
      }
      
      public function get SlotType() : com.moviestarplanet.moviestar.valueObjects.SlotType
      {
         return this._SlotType;
      }
      
      public function set ClothesCategoryId(param1:int) : void
      {
         this._ClothesCategoryId = param1;
      }
      
      public function set Name(param1:String) : void
      {
         this._Name = param1;
      }
      
      public function set SlotTypeId(param1:int) : void
      {
         this._SlotTypeId = param1;
      }
      
      public function set SlotType(param1:com.moviestarplanet.moviestar.valueObjects.SlotType) : void
      {
         this._SlotType = param1;
      }
   }
}

