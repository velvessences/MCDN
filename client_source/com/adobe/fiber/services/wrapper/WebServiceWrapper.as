package com.adobe.fiber.services.wrapper
{
   import com.adobe.fiber.core.model_internal;
   import flash.events.IEventDispatcher;
   import mx.rpc.AbstractService;
   import mx.rpc.soap.mxml.WebService;
   
   use namespace model_internal;
   
   public class WebServiceWrapper extends AbstractServiceWrapper
   {
      
      protected var _serviceControl:WebService;
      
      protected var _needWSDLLoad:Boolean = false;
      
      public function WebServiceWrapper(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get port() : String
      {
         return _serviceControl.port;
      }
      
      public function set port(param1:String) : void
      {
         _serviceControl.port = param1;
      }
      
      public function get wsdl() : String
      {
         return _serviceControl.wsdl;
      }
      
      public function set wsdl(param1:String) : void
      {
         _serviceControl.wsdl = param1;
         _needWSDLLoad = true;
      }
      
      public function set service(param1:String) : void
      {
         _serviceControl.service = param1;
      }
      
      override public function get serviceControl() : AbstractService
      {
         return _serviceControl;
      }
      
      public function get service() : String
      {
         return _serviceControl.service;
      }
      
      public function get useProxy() : Boolean
      {
         return _serviceControl.useProxy;
      }
      
      model_internal function loadWSDLIfNecessary() : void
      {
         if(_needWSDLLoad)
         {
            _serviceControl.loadWSDL();
            _needWSDLLoad = false;
         }
      }
      
      override public function set destination(param1:String) : void
      {
         serviceControl.destination = param1;
         _needWSDLLoad = true;
      }
      
      public function set useProxy(param1:Boolean) : void
      {
         _serviceControl.useProxy = param1;
      }
   }
}

