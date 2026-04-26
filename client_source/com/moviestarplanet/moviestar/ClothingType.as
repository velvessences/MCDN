package com.moviestarplanet.moviestar
{
   public class ClothingType
   {
      
      private var _categories:Array;
      
      private var _label:String;
      
      public function ClothingType(param1:Array, param2:String)
      {
         super();
         this._categories = param1;
         this._label = param2;
      }
      
      public function get categories() : Array
      {
         return this._categories;
      }
      
      public function get label() : String
      {
         return this._label;
      }
   }
}

