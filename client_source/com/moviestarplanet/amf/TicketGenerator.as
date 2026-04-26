package com.moviestarplanet.amf
{
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.crypto.hash.SHA256;
   import com.hurlant.util.Hex;
   import com.moviestarplanet.amf.valueobjects.TicketHeader;
   import flash.utils.ByteArray;
   
   public class TicketGenerator
   {
      
      public static var sessionTicket:String = "";
      
      public static var salt:String = "";
      
      private static var _markingId:int = Math.random() * 1000;
      
      public function TicketGenerator()
      {
         super();
      }
      
      public static function createTicketHeaderSHA256(param1:String = "") : TicketHeader
      {
         var _loc3_:String = null;
         var _loc4_:ByteArray = null;
         var _loc5_:SHA256 = null;
         var _loc2_:TicketHeader = new TicketHeader();
         if(param1 != "")
         {
            _loc4_ = new ByteArray();
            _loc4_.writeUTFBytes(param1);
            _loc4_.position = 0;
            _loc5_ = new SHA256();
            param1 = Hex.fromArray(_loc5_.hash(_loc4_)) + "_";
         }
         _loc2_.Ticket = param1 + sessionTicket + getMarkingID();
         _loc3_ = _loc2_.Ticket;
         return _loc2_;
      }
      
      public static function createTicketHeader(param1:String = "") : TicketHeader
      {
         var _loc3_:String = null;
         var _loc4_:ByteArray = null;
         var _loc5_:MD5 = null;
         var _loc2_:TicketHeader = new TicketHeader();
         if(param1 != "")
         {
            _loc4_ = new ByteArray();
            _loc4_.writeUTFBytes(param1);
            _loc4_.position = 0;
            _loc5_ = new MD5();
            param1 = Hex.fromArray(_loc5_.hash(_loc4_)) + "_";
         }
         _loc2_.Ticket = param1 + sessionTicket + getMarkingID();
         _loc3_ = _loc2_.Ticket;
         return _loc2_;
      }
      
      public static function createTicketHeaderNoMarking() : TicketHeader
      {
         var _loc2_:String = null;
         var _loc1_:TicketHeader = new TicketHeader();
         _loc1_.Ticket = sessionTicket;
         _loc2_ = _loc1_.Ticket;
         return _loc1_;
      }
      
      public static function getMarkingID() : String
      {
         var _loc1_:int = 0;
         _markingId += 1;
         _loc1_ = _markingId;
         var _loc2_:String = _loc1_.toString();
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(_loc2_);
         _loc3_.position = 0;
         var _loc4_:MD5 = new MD5();
         var _loc5_:String = Hex.fromArray(_loc4_.hash(_loc3_));
         var _loc6_:String = Hex.fromString(_loc2_);
         return _loc5_ + _loc6_;
      }
   }
}

