package com.moviestarplanet.utils.loaderfacade
{
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   
   public interface ILoaderFacade
   {
      
      function createLoader(param1:Boolean = true, param2:Boolean = true) : IMSP_Loader;
   }
}

