package com.moviestarplanet.messenger.model
{
   public class MessageList
   {
      
      public var messages:Array;
      
      public var nextTimeUUID:String;
      
      public function MessageList()
      {
         super();
      }
      
      public function toString() : String
      {
         var _loc2_:Message = null;
         var _loc1_:String = "";
         for each(_loc2_ in this.messages)
         {
            _loc1_ += _loc2_.toString() + "\n";
         }
         return _loc1_ + this.nextTimeUUID;
      }
   }
}

