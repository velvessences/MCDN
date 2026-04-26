package com.moviestarplanet.services
{
   import com.moviestarplanet.amf.valueobjects.TicketHeader;
   import com.moviestarplanet.configurations.Config;
   import flash.text.TextField;
   import mx.core.ByteArrayAsset;
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.WSDLLoadEvent;
   import mx.rpc.soap.SOAPHeader;
   import mx.rpc.wsdl.WSDL;
   import mx.rpc.wsdl.WSDLLoader;
   
   public class ServiceManager
   {
      
      private var service:IMSP_WSDLService;
      
      private var isWSDLLoaded:Boolean = false;
      
      public function ServiceManager(param1:IMSP_WSDLService)
      {
         super();
         this.service = param1;
      }
      
      public function addTicketHeader(param1:TicketHeader) : void
      {
         this.service.webService.clearHeaders();
         this.service.webService.addHeader(new SOAPHeader(new QName("http://moviestarplanet.com/","TicketHeader"),{"Ticket":param1.Ticket}));
      }
      
      public function loadWSDLIfNecessary() : void
      {
         if(!this.isWSDLLoaded)
         {
            this.isWSDLLoaded = true;
            this.loadWSDLFromAsset();
         }
      }
      
      public function loadWSDL(param1:Function = null) : void
      {
         var loadDone:Function = null;
         var callback:Function = param1;
         loadDone = function(param1:WSDLLoadEvent):void
         {
            if(callback != null)
            {
               callback();
            }
         };
         var wsdlLoader:WSDLLoader = new WSDLLoader(this.service.webService.mx_internal::deriveHTTPService());
         wsdlLoader.addEventListener(WSDLLoadEvent.LOAD,this.service.webService.mx_internal::wsdlHandler);
         wsdlLoader.addEventListener(WSDLLoadEvent.LOAD,loadDone);
         wsdlLoader.addEventListener(FaultEvent.FAULT,this.service.webService.mx_internal::wsdlFaultHandler);
         wsdlLoader.load(this.service.webService.wsdl);
      }
      
      public function loadWSDLFromAsset() : void
      {
         var _loc12_:uint = 0;
         var _loc1_:TextField = new TextField();
         var _loc2_:UIComponent = new UIComponent();
         _loc2_.addChild(_loc1_);
         var _loc3_:Class = this.service.WSDL_CLASS;
         var _loc4_:Object = new _loc3_();
         var _loc5_:ByteArrayAsset = _loc4_ as ByteArrayAsset;
         var _loc6_:String = "";
         var _loc7_:uint = uint(_loc5_.bytesAvailable);
         while(_loc5_.bytesAvailable > 0)
         {
            _loc12_ = 10000;
            if(_loc5_.bytesAvailable < _loc12_)
            {
               _loc12_ = uint(_loc5_.bytesAvailable);
            }
            _loc6_ += _loc5_.readUTFBytes(_loc12_);
         }
         var _loc8_:RegExp = /SOAP_SERVICE_XML_DEFINITION/g;
         _loc6_ = _loc6_.replace(_loc8_,Config.webserverPath);
         this.service.webService.mx_internal::deriveHTTPService();
         var _loc9_:XML = new XML(_loc6_);
         var _loc10_:WSDL = new WSDL(_loc9_);
         var _loc11_:WSDLLoadEvent = WSDLLoadEvent.createEvent(new WSDL(new XML(_loc6_)));
         this.service.webService.mx_internal::wsdlHandler(_loc11_);
      }
   }
}

