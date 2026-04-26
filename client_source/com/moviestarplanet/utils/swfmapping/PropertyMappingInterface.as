package com.moviestarplanet.utils.swfmapping
{
   import flash.events.IEventDispatcher;
   
   public interface PropertyMappingInterface extends IEventDispatcher
   {
      
      function getPathSelector() : PathSelectorInterface;
   }
}

