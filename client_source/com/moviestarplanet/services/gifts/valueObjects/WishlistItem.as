package com.moviestarplanet.services.gifts.valueObjects
{
   import com.moviestarplanet.actorutils.ClothInfoUtils;
   
   public class WishlistItem implements IGivable
   {
      
      public var GiftId:int;
      
      public var ActorId:int;
      
      public var ClothesId:int;
      
      public var clothesName:String;
      
      public var Color:String;
      
      public var Vip:int;
      
      public var Price:int;
      
      public var ShopId:int;
      
      public var IsLastChance:Boolean;
      
      public var actorName:String;
      
      public var _ClothesCategoryId:int;
      
      public var _SWF:String;
      
      public var _Filename:String;
      
      public var _ColorScheme:String;
      
      public function WishlistItem()
      {
         super();
      }
      
      public function get filteredMessage() : String
      {
         return "";
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
         return "";
      }
      
      public function get giverName() : String
      {
         return this.actorName;
      }
      
      public function get receiverActorId() : int
      {
         return this.ActorId;
      }
      
      public function get giverActorId() : int
      {
         return this.ActorId;
      }
      
      public function get vip() : Boolean
      {
         return this.Vip > 0;
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

