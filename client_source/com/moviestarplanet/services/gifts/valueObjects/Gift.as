package com.moviestarplanet.services.gifts.valueObjects
{
   import com.moviestarplanet.model.friends.IContentActorInfo;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.utils.StringUtilities;
   
   public class Gift implements IGivable
   {
      
      public var GiftId:int;
      
      public var ActorId:int;
      
      public var GiverId:int;
      
      public var ClothesId:int;
      
      public var Color:String;
      
      public var State:int;
      
      public var Price:int;
      
      public var dateStr:String;
      
      public var actorClothesRelId:int;
      
      public var giftType:int;
      
      public var LinkedGiftId:int;
      
      public var DiamondsPrice:int;
      
      public var Actor:IContentActorInfo;
      
      public var Giver:IContentActorInfo;
      
      public var Vip:int;
      
      public var Message:String;
      
      public var _SWF:String;
      
      public function Gift()
      {
         super();
      }
      
      public function get filteredMessage() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Message);
      }
      
      public function get ColorScheme() : String
      {
         return "";
      }
      
      public function get isImage() : Boolean
      {
         return false;
      }
      
      public function get path() : String
      {
         var _loc2_:int = 0;
         var _loc1_:String = "gifts/medium/";
         if(this.SWF != null && this.SWF.length > 0)
         {
            return _loc1_ + this.SWF;
         }
         _loc2_ = Math.random() * 5 + 1;
         return _loc1_ + "Gift_item_" + _loc2_ + ".swf";
      }
      
      public function get ClothesCategoryId() : int
      {
         return -1;
      }
      
      public function get Filename() : String
      {
         return "";
      }
      
      public function get SWF() : String
      {
         return this._SWF;
      }
      
      public function set SWF(param1:String) : void
      {
         this._SWF = StringUtilities.trim(param1);
      }
      
      public function get vip() : Boolean
      {
         return this.Vip > 0;
      }
      
      public function get starcoinPrice() : Number
      {
         return this.Price;
      }
      
      public function get color() : String
      {
         return this.Color;
      }
      
      public function get receiverName() : String
      {
         return this.Actor.getName;
      }
      
      public function get giverName() : String
      {
         return this.Giver.getName;
      }
      
      public function get receiverActorId() : int
      {
         return this.Actor.getActorId;
      }
      
      public function get giverActorId() : int
      {
         return this.Giver.getActorId;
      }
      
      public function get LastUpdated() : Date
      {
         return null;
      }
      
      public function set LastUpdated(param1:Date) : void
      {
      }
   }
}

