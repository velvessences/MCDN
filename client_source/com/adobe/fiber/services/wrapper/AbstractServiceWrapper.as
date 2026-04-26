package com.adobe.fiber.services.wrapper
{
   import com.adobe.fiber.core.model_internal;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.core.IMXMLObject;
   import mx.core.mx_internal;
   import mx.messaging.ChannelSet;
   import mx.rpc.AbstractService;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   
   use namespace mx_internal;
   use namespace model_internal;
   
   public class AbstractServiceWrapper extends EventDispatcher implements IMXMLObject
   {
      
      mx_internal var id:String;
      
      mx_internal var document:Object;
      
      public function AbstractServiceWrapper(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get showBusyCursor() : Boolean
      {
         return serviceControl.showBusyCursor;
      }
      
      public function set showBusyCursor(param1:Boolean) : void
      {
         serviceControl.showBusyCursor = param1;
      }
      
      public function get serviceControl() : AbstractService
      {
         return null;
      }
      
      model_internal function propagateEvents(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      public function get operations() : Object
      {
         return serviceControl.operations;
      }
      
      public function get destination() : String
      {
         return serviceControl.destination;
      }
      
      model_internal function initialize() : void
      {
         serviceControl.addEventListener(ResultEvent.RESULT,model_internal::propagateEvents);
         serviceControl.addEventListener(FaultEvent.FAULT,model_internal::propagateEvents);
      }
      
      public function initialized(param1:Object, param2:String) : void
      {
         this.mx_internal::document = param1;
         this.mx_internal::id = param2;
      }
      
      public function set operations(param1:Object) : void
      {
         serviceControl.operations = param1;
      }
      
      public function set destination(param1:String) : void
      {
         serviceControl.destination = param1;
      }
      
      public function set channelSet(param1:ChannelSet) : void
      {
         serviceControl.channelSet = param1;
      }
      
      public function get channelSet() : ChannelSet
      {
         return serviceControl.channelSet;
      }
   }
}

