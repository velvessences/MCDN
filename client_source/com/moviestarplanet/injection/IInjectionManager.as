package com.moviestarplanet.injection
{
   public interface IInjectionManager
   {
      
      function injectMe(param1:Object) : void;
      
      function getInstance(param1:Class, param2:String = "") : *;
   }
}

