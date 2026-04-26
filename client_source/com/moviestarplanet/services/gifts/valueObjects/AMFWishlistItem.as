package com.moviestarplanet.services.gifts.valueObjects
{
   import com.moviestarplanet.actorutils.ClothInfoUtils;
   
   public class AMFWishlistItem implements IGivable
   {
      
      public var ActorId:int;
      
      public var ActorName:String;
      
      public var ClothesId:int;
      
      public var ClothesName:String;
      
      public var Color:String;
      
      public var FileName:String;
      
      public var GiftId:int;
      
      public var IsLastChance:Boolean;
      
      public var Price:int;
      
      public var ShopId:int;
      
      public var Vip:int;
      
      private var _SWF:String;
      
      private var _clothesCategoryId:int;
      
      private var _colorScheme:*;
      
      public function AMFWishlistItem()
      {
         super();
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
         return this.ActorName;
      }
      
      public function get giverName() : String
      {
         return this.ActorName;
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
      
      public function get filteredMessage() : String
      {
         return null;
      }
      
      public function get path() : String
      {
         return ClothInfoUtils.getPath(this);
      }
      
      public function get ColorScheme() : String
      {
         return this._colorScheme;
      }
      
      public function set ColorScheme(param1:String) : void
      {
         this._colorScheme = param1;
      }
      
      public function get isImage() : Boolean
      {
         return ClothInfoUtils.isImage(this);
      }
      
      public function get LastUpdated() : Date
      {
         return null;
      }
      
      public function get SWF() : String
      {
         return this._SWF;
      }
      
      public function set SWF(param1:String) : void
      {
         this._SWF = param1;
      }
      
      public function get ClothesCategoryId() : int
      {
         return this._clothesCategoryId;
      }
      
      public function set ClothesCategoryId(param1:int) : void
      {
         this._clothesCategoryId = param1;
      }
      
      public function get Filename() : String
      {
         return this.FileName;
      }
   }
}

