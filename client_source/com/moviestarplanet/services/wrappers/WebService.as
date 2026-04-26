package com.moviestarplanet.services.wrappers
{
   import com.moviestarplanet.services.ServiceManager;
   import com.moviestarplanet.services.service.Service;
   
   public class WebService extends BaseServiceWrapper
   {
      
      private static var _serviceInstance:Service;
      
      private static var serviceManager:ServiceManager;
      
      public function WebService()
      {
         super();
      }
      
      public static function getService() : Service
      {
         if(_serviceInstance == null)
         {
            _serviceInstance = new Service();
            _serviceInstance.manager = new ServiceManager(_serviceInstance);
         }
         return _serviceInstance;
      }
   }
}

