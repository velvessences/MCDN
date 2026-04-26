package com.moviestarplanet.utils.swfmapping
{
   import flash.events.EventDispatcher;
   
   public class AbstractPropertyMapping extends EventDispatcher implements PropertyMappingInterface
   {
      
      protected var _pathSelector:PathSelectorInterface;
      
      public function AbstractPropertyMapping(param1:PathSelectorInterface = null)
      {
         super();
         this._pathSelector = param1;
      }
      
      public function getPathSelector() : PathSelectorInterface
      {
         return this._pathSelector;
      }
      
      public function setPathSelector(param1:PathSelectorInterface) : void
      {
         this._pathSelector = param1;
      }
      
      public function get pathSelector() : PathSelectorInterface
      {
         return this._pathSelector;
      }
      
      public function set pathSelector(param1:PathSelectorInterface) : void
      {
         this._pathSelector = param1;
      }
   }
}

