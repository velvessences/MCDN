package com.moviestarplanet.utils.loaderfacade
{
   import com.moviestarplanet.utils.MSP_SWFLoader;
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   
   public class LoaderFacadeWeb implements ILoaderFacade
   {
      
      public function LoaderFacadeWeb()
      {
         super();
      }
      
      public function createLoader(param1:Boolean = true, param2:Boolean = true) : IMSP_Loader
      {
         return new MSP_SWFLoader(param1,param2);
      }
   }
}

