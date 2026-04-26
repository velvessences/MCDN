package com.moviestarplanet.bonster.valueobjects
{
   public class BonsterCandyPriceWithLevel
   {
      
      private var _LevelFloor:int;
      
      private var _LevelCeil:int;
      
      private var _CandyPrice:int;
      
      public function BonsterCandyPriceWithLevel()
      {
         super();
      }
      
      public function get LevelFloor() : int
      {
         return this._LevelFloor;
      }
      
      public function set LevelFloor(param1:int) : void
      {
         this._LevelFloor = param1;
      }
      
      public function get LevelCeil() : int
      {
         return this._LevelCeil;
      }
      
      public function set LevelCeil(param1:int) : void
      {
         this._LevelCeil = param1;
      }
      
      public function get CandyPrice() : int
      {
         return this._CandyPrice;
      }
      
      public function set CandyPrice(param1:int) : void
      {
         this._CandyPrice = param1;
      }
   }
}

