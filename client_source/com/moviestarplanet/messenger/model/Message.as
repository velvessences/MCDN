package com.moviestarplanet.messenger.model
{
   import mx.collections.ArrayCollection;
   
   public class Message
   {
      
      public var UUID:String;
      
      public var msgText:String;
      
      public var sender:Number;
      
      public var timestamp:String;
      
      public var hiddenForActors:ArrayCollection;
      
      public function Message()
      {
         super();
      }
      
      public function toString() : String
      {
         return "msg:" + this.msgText + " sender:" + this.sender + " time||" + this.timestamp;
      }
   }
}

