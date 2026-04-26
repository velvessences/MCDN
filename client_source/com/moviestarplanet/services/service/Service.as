package com.moviestarplanet.services.service
{
   import com.adobe.fiber.core.model_internal;
   import com.moviestarplanet.amf.ServiceUrlUtil;
   import com.moviestarplanet.amf.valueobjects.TicketHeader;
   import com.moviestarplanet.services.IMSP_WSDLService;
   import com.moviestarplanet.services.ServiceManager;
   import mx.rpc.soap.WebService;
   
   use namespace model_internal;
   
   public class Service extends _Super_Service implements IMSP_WSDLService
   {
      
      private static const _WSDL_CLASS:Class = Service__WSDL_CLASS;
      
      private var _serviceManager:ServiceManager;
      
      public function Service()
      {
         super();
      }
      
      public function get WSDL_CLASS() : Class
      {
         return _WSDL_CLASS;
      }
      
      override protected function preInitializeService() : void
      {
         _serviceControl.service = "WebService";
         _serviceControl.port = "WebServiceSoap";
         wsdl = ServiceUrlUtil.getServiceUrlBase() + "Webservice/Service.asmx?WSDL";
      }
      
      public function addTicketHeader(param1:TicketHeader) : void
      {
         this.manager.addTicketHeader(param1);
      }
      
      public function get webService() : WebService
      {
         return _serviceControl as WebService;
      }
      
      public function get serviceName() : String
      {
         return "Webservice/Service.asmx";
      }
      
      public function get manager() : ServiceManager
      {
         return this._serviceManager;
      }
      
      public function set manager(param1:ServiceManager) : void
      {
         this._serviceManager = param1;
         this.manager.loadWSDLIfNecessary();
      }
      
      override model_internal function loadWSDLIfNecessary() : void
      {
         this.manager.loadWSDLIfNecessary();
      }
   }
}

