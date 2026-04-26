package com.moviestarplanet.utils.loaderfacade
{
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.loader.ILoaderUrl;
   import com.moviestarplanet.utils.loader.IMSP_Loader;
   
   public class LoaderFacade
   {
      
      private static var facade:ILoaderFacade;
      
      public function LoaderFacade()
      {
         super();
      }
      
      public static function createLoader(param1:Boolean = true, param2:Boolean = true) : IMSP_Loader
      {
         if(facade == null)
         {
            facade = InjectionManager.manager().getInstance(ILoaderFacade);
         }
         return facade.createLoader(param1,param2);
      }
      
      public static function requestLoad(param1:ILoaderUrl, param2:Function, param3:int = 2, param4:Boolean = true, param5:Boolean = true) : IMSP_Loader
      {
         var _loc6_:IMSP_Loader = createLoader(param5,param1.allowCodeImport());
         _loc6_.LoadCallBack = param2;
         _loc6_.isDeletable = param4;
         _loc6_.LoadUrl(param1,param3,param4);
         return _loc6_;
      }
   }
}

