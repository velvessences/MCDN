package com.moviestarplanet.utils.swfmapping
{
   import mx.events.PropertyChangeEvent;
   
   public class PropertyMappingValue extends AbstractPropertyMapping implements PropertyMappingValueInterface
   {
      
      private var _property:String;
      
      private var _1463225230_value:*;
      
      public function PropertyMappingValue(param1:PathSelectorInterface = null, param2:String = "", param3:* = null)
      {
         super(param1);
         this._value = param3;
         this._property = param2;
      }
      
      public function getValue() : *
      {
         return this._value;
      }
      
      public function setValue(param1:*) : void
      {
         this._value = param1;
      }
      
      public function get value() : *
      {
         return this._value;
      }
      
      public function set value(param1:*) : void
      {
         this._value = param1;
      }
      
      public function getProperty() : String
      {
         return this._property;
      }
      
      public function setProperty(param1:String) : void
      {
         this._property = param1;
      }
      
      public function get property() : String
      {
         return this._property;
      }
      
      public function set property(param1:String) : void
      {
         this._property = param1;
      }
      
      [Bindable(event="propertyChange")]
      private function get _value() : *
      {
         return this._1463225230_value;
      }
      
      private function set _value(param1:*) : void
      {
         var _loc2_:Object = this._1463225230_value;
         if(_loc2_ !== param1)
         {
            this._1463225230_value = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_value",_loc2_,param1));
            }
         }
      }
   }
}

