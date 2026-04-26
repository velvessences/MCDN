package com.moviestarplanet.services.gifts.valueObjects
{
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class GiftLog
   {
      
      private var _GiftLogId:int;
      
      private var _ActorId:int;
      
      private var _GiverId:int;
      
      private var _ActorClothesRelId:int;
      
      private var _Price:int;
      
      private var _dateStr:String;
      
      private var _giftType:int;
      
      private var _LinkedGiftId:int;
      
      private var _Actor:GiftActorName;
      
      private var _Giver:GiftActorName;
      
      public var Message:String;
      
      public function GiftLog()
      {
         super();
      }
      
      public function get filteredMessage() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Message);
      }
      
      public function get GiftLogId() : int
      {
         return this._GiftLogId;
      }
      
      public function get ActorId() : int
      {
         return this._ActorId;
      }
      
      public function get GiverId() : int
      {
         return this._GiverId;
      }
      
      public function get ActorClothesRelId() : int
      {
         return this._ActorClothesRelId;
      }
      
      public function get Price() : int
      {
         return this._Price;
      }
      
      public function get dateStr() : String
      {
         return this._dateStr;
      }
      
      public function get giftType() : int
      {
         return this._giftType;
      }
      
      public function get LinkedGiftId() : int
      {
         return this._LinkedGiftId;
      }
      
      public function get Actor() : GiftActorName
      {
         return this._Actor;
      }
      
      public function get Giver() : GiftActorName
      {
         return this._Giver;
      }
      
      public function set GiftLogId(param1:int) : void
      {
         this._GiftLogId = param1;
      }
      
      public function set ActorId(param1:int) : void
      {
         this._ActorId = param1;
      }
      
      public function set GiverId(param1:int) : void
      {
         this._GiverId = param1;
      }
      
      public function set ActorClothesRelId(param1:int) : void
      {
         this._ActorClothesRelId = param1;
      }
      
      public function set Price(param1:int) : void
      {
         this._Price = param1;
      }
      
      public function set dateStr(param1:String) : void
      {
         this._dateStr = param1;
      }
      
      public function set giftType(param1:int) : void
      {
         this._giftType = param1;
      }
      
      public function set LinkedGiftId(param1:int) : void
      {
         this._LinkedGiftId = param1;
      }
      
      public function set Actor(param1:GiftActorName) : void
      {
         this._Actor = param1;
      }
      
      public function set Giver(param1:GiftActorName) : void
      {
         this._Giver = param1;
      }
   }
}

