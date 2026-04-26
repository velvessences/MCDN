package com.moviestarplanet.utils.swfmapping
{
   public interface PathSelectorInterface
   {
      
      function getIdentifiers() : Array;
      
      function addPropertyIdentifiers(... rest) : PathSelectorInterface;
   }
}

