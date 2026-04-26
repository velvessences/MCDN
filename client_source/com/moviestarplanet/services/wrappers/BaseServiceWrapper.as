package com.moviestarplanet.services.wrappers
{
   import com.moviestarplanet.amf.TicketGenerator;
   import com.moviestarplanet.amf.valueobjects.TicketHeader;
   import com.moviestarplanet.model.ActorSession;
   import com.moviestarplanet.services.wrappers.call.RpcFaultHandler;
   import mx.rpc.AsyncToken;
   import mx.rpc.CallResponder;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.soap.SOAPHeader;
   
   public class BaseServiceWrapper
   {
      
      public function BaseServiceWrapper()
      {
         super();
      }
      
      protected static function get loggedInActorId() : int
      {
         return ActorSession.getActorId();
      }
      
      public static function get isModerator() : Boolean
      {
         return ActorSession.isModerator();
      }
      
      public static function get enableTracing() : Boolean
      {
         return ActorSession.enableTracing;
      }
      
      protected static function registerResponder(param1:AsyncToken, param2:Function, param3:Function = null) : CallResponder
      {
         var _loc4_:CallResponder = new CallResponder();
         if(param3 == null)
         {
            _loc4_.addEventListener(FaultEvent.FAULT,RpcFaultHandler.faultHandler);
         }
         else
         {
            _loc4_.addEventListener(FaultEvent.FAULT,param3);
         }
         _loc4_.addEventListener(ResultEvent.RESULT,param2);
         _loc4_.token = param1;
         return _loc4_;
      }
      
      protected static function clearResponder(param1:CallResponder, param2:Function, param3:Function = null) : void
      {
         if(param3 == null)
         {
            param1.removeEventListener(FaultEvent.FAULT,RpcFaultHandler.faultHandler);
         }
         else
         {
            param1.removeEventListener(FaultEvent.FAULT,param3);
         }
         param1.removeEventListener(ResultEvent.RESULT,param2);
      }
      
      protected static function createTicketHeader() : TicketHeader
      {
         return TicketGenerator.createTicketHeader();
      }
      
      protected static function createTicketHeaderSHA256(param1:String = "") : TicketHeader
      {
         return TicketGenerator.createTicketHeaderSHA256(param1);
      }
      
      public static function getTicket() : String
      {
         return Ticket + TicketGenerator.getMarkingID();
      }
      
      protected static function get Ticket() : String
      {
         return TicketGenerator.sessionTicket;
      }
      
      protected static function set Ticket(param1:String) : void
      {
         TicketGenerator.sessionTicket = param1;
      }
      
      protected static function GetTicketFromSOAPHeader(param1:SOAPHeader) : void
      {
         var _loc2_:TicketHeader = TicketHeader(param1.content);
         Ticket = _loc2_.Ticket;
      }
      
      protected static function GetTicketFromXMLHeader(param1:XML) : void
      {
         if(param1.children().length() == 0)
         {
            return;
         }
         var _loc2_:TicketHeader = new TicketHeader();
         _loc2_.Ticket = param1.children()[0].text()[0].toXMLString();
         Ticket = _loc2_.Ticket;
      }
   }
}

