package com.moviestarplanet.session.valueobjects
{
   import flash.events.EventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class AppSetting extends EventDispatcher
   {
      
      private var _internal_name:String;
      
      private var _internal_value:String;
      
      public function AppSetting()
      {
         super();
      }
      
      [Bindable(event="propertyChange")]
      public function get name() : String
      {
         return this._internal_name;
      }
      
      [Bindable(event="propertyChange")]
      public function get value() : String
      {
         return this._internal_value;
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:String = this._internal_name;
         if(_loc2_ !== param1)
         {
            this._internal_name = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"name",_loc2_,this._internal_name));
         }
      }
      
      public function set value(param1:String) : void
      {
         var _loc2_:String = this._internal_value;
         if(_loc2_ !== param1)
         {
            this._internal_value = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"value",_loc2_,this._internal_value));
         }
      }
   }
}

