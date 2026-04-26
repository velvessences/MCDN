package com.moviestarplanet.payment.valueobject
{
   public class PropertyAvailable
   {
      
      private var _property:int;
      
      private var _available:Boolean;
      
      public function PropertyAvailable(param1:int, param2:Boolean)
      {
         super();
         this._property = param1;
         this._available = param2;
      }
      
      public static function fromAny(param1:*) : PropertyAvailable
      {
         return new PropertyAvailable(param1.Property,param1.Available);
      }
      
      public function get property() : int
      {
         return this._property;
      }
      
      public function get available() : Boolean
      {
         return this._available;
      }
   }
}

