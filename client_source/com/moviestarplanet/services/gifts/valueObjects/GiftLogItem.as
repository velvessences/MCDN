package com.moviestarplanet.services.gifts.valueObjects
{
   import com.moviestarplanet.actor.IClothInfo;
   import com.moviestarplanet.actorutils.ClothInfoUtils;
   import com.moviestarplanet.body.ILoadable;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   
   public class GiftLogItem implements IGivable, IClothInfo, ILoadable
   {
      
      public var GiftLogId:int;
      
      public var ActorId:int;
      
      public var GiverId:int;
      
      public var ClothesId:int;
      
      public var clothesName:String;
      
      public var Color:String;
      
      public var Vip:int;
      
      public var Price:int;
      
      public var ShopId:int;
      
      public var dateStr:String;
      
      public var giftType:int;
      
      public var LinkedGiftId:int;
      
      public var actorName:String;
      
      public var DesignId:*;
      
      public var Message:String;
      
      public var _LastUpdated:Date;
      
      public var _ClothesCategoryId:int;
      
      public var _ColorScheme:String;
      
      public var _SWF:String;
      
      public var _Filename:String;
      
      public var _giverName:String;
      
      public function GiftLogItem()
      {
         super();
      }
      
      public function get filteredMessage() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Message);
      }
      
      public function set ColorScheme(param1:String) : void
      {
         this._ColorScheme = param1;
      }
      
      public function set ClothesCategoryId(param1:int) : void
      {
         this._ClothesCategoryId = param1;
      }
      
      public function set Filename(param1:String) : void
      {
         this._Filename = param1;
      }
      
      public function set SWF(param1:String) : void
      {
         this._SWF = param1;
      }
      
      public function set giverName(param1:String) : void
      {
         this._giverName = param1;
      }
      
      public function get ColorScheme() : String
      {
         return this._ColorScheme;
      }
      
      public function get isImage() : Boolean
      {
         return ClothInfoUtils.isImage(this);
      }
      
      public function get path() : String
      {
         return ClothInfoUtils.getPath(this);
      }
      
      public function get ClothesCategoryId() : int
      {
         return this._ClothesCategoryId;
      }
      
      public function get Filename() : String
      {
         return this._Filename;
      }
      
      public function get SWF() : String
      {
         return this._SWF;
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
         return this.actorName;
      }
      
      public function get giverName() : String
      {
         return this._giverName;
      }
      
      public function get receiverActorId() : int
      {
         return this.ActorId;
      }
      
      public function get giverActorId() : int
      {
         return this.GiverId;
      }
      
      public function get vip() : Boolean
      {
         return this.Vip > 0;
      }
      
      public function get LastUpdated() : Date
      {
         return this._LastUpdated;
      }
      
      public function set LastUpdated(param1:Date) : void
      {
         this._LastUpdated = param1;
      }
   }
}

