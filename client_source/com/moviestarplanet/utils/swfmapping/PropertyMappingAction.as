package com.moviestarplanet.utils.swfmapping
{
   import com.moviestarplanet.utils.ComponentUtilities;
   
   public class PropertyMappingAction extends AbstractPropertyMapping implements PropertyMappingActionInterface
   {
      
      private var _click:Function;
      
      private var _data:Array;
      
      public function PropertyMappingAction(param1:PathSelectorInterface = null, param2:Function = null, ... rest)
      {
         super(param1);
         this._click = param2;
         this._data = ComponentUtilities.flattenArray(rest);
      }
      
      public function getClick() : Function
      {
         return this._click;
      }
      
      public function setClick(param1:Function) : void
      {
         this._click = param1;
      }
      
      public function get click() : Function
      {
         return this._click;
      }
      
      public function set click(param1:Function) : void
      {
         this._click = param1;
      }
      
      public function getData() : Array
      {
         return this._data;
      }
      
      public function setData(... rest) : void
      {
         this._data = ComponentUtilities.flattenArray(rest);
      }
      
      public function get data() : Array
      {
         return this._data;
      }
      
      public function set data(... rest) : void
      {
         this._data = ComponentUtilities.flattenArray(rest);
      }
   }
}

