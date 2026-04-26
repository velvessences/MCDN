package com.adobe.fiber.services
{
   import mx.rpc.AbstractService;
   
   public interface IFiberManagingService
   {
      
      function getCustomService(param1:String) : IFiberService;
      
      function getService(param1:String) : AbstractService;
   }
}

