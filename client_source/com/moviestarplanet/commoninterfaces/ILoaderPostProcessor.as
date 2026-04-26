package com.moviestarplanet.commoninterfaces
{
   public interface ILoaderPostProcessor
   {
      
      function getKeyModifier() : String;
      
      function process(param1:Object) : void;
   }
}

