package com.moviestarplanet.messenger.model
{
   public class LatestMessage extends Message
   {
      
      public var isUnread:Boolean;
      
      public var domain:String;
      
      public var uuid:String;
      
      public var staticMsg:Boolean;
      
      public var msgType:String;
      
      public function LatestMessage()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "msg:" + msgText + " domain:" + this.domain + " sender:" + sender + " time||" + timestamp + "|| isunread" + this.isUnread + " uuid:" + this.uuid;
      }
      
      public function getOtherActorId(param1:Number) : String
      {
         var _loc2_:Array = this.domain.split(":");
         if(_loc2_.length < 2)
         {
            return "";
         }
         return _loc2_[0] == param1 ? _loc2_[1] : _loc2_[0];
      }
   }
}

