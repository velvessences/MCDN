package com.moviestarplanet.services
{
   import com.moviestarplanet.amf.valueobjects.TicketHeader;
   import mx.rpc.soap.WebService;
   
   public interface IMSP_WSDLService
   {
      
      function get webService() : WebService;
      
      function get serviceName() : String;
      
      function get WSDL_CLASS() : Class;
      
      function set manager(param1:ServiceManager) : void;
      
      function get manager() : ServiceManager;
      
      function addTicketHeader(param1:TicketHeader) : void;
   }
}

