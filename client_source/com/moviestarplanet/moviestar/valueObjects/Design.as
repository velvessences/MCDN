package com.moviestarplanet.moviestar.valueObjects
{
   import com.moviestarplanet.body.IDesign;
   import com.moviestarplanet.globalsharedutils.SerializeUtils;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import flash.utils.ByteArray;
   
   public class Design implements IDesign
   {
      
      public static const STATUS_DESIGNED:int = 0;
      
      public static const STATUS_PRODUCED:int = 1;
      
      public static const STATUS_CANCELED:int = 2;
      
      public static const STATUS_SELLING:int = 3;
      
      private var _DesignId:int;
      
      private var _ActorId:int;
      
      private var _Created:Date;
      
      private var _Name:String;
      
      private var _Data:ByteArray;
      
      private var _Likes:int;
      
      private var _Deleted:int;
      
      private var _Status:int;
      
      private var _FameEarned:int;
      
      private var _Price:int;
      
      private var _Vip:int;
      
      private var _DiamondsPrice:int;
      
      public var DateForSale:Date;
      
      public var TemplateId:int;
      
      public var AmountForSale:int;
      
      public var OriginalActorClothesRelId:int;
      
      private var compressed:Boolean = true;
      
      public function Design()
      {
         super();
      }
      
      public function get DesignId() : int
      {
         return this._DesignId;
      }
      
      public function get ActorId() : int
      {
         return this._ActorId;
      }
      
      public function get Created() : Date
      {
         return this._Created;
      }
      
      public function get Name() : String
      {
         return this._Name;
      }
      
      public function get Data() : ByteArray
      {
         return this._Data;
      }
      
      public function get Likes() : int
      {
         return this._Likes;
      }
      
      public function get Deleted() : int
      {
         return this._Deleted;
      }
      
      public function get Status() : int
      {
         return this._Status;
      }
      
      public function get FameEarned() : int
      {
         return this._FameEarned;
      }
      
      public function get Price() : int
      {
         return this._Price;
      }
      
      public function get DiamondsPrice() : int
      {
         return this._DiamondsPrice;
      }
      
      public function set DesignId(param1:int) : void
      {
         this._DesignId = param1;
      }
      
      public function set ActorId(param1:int) : void
      {
         this._ActorId = param1;
      }
      
      public function set Created(param1:Date) : void
      {
         this._Created = param1;
      }
      
      public function set Name(param1:String) : void
      {
         this._Name = param1;
      }
      
      public function set Data(param1:ByteArray) : void
      {
         this._Data = param1;
      }
      
      public function set Likes(param1:int) : void
      {
         this._Likes = param1;
      }
      
      public function set Deleted(param1:int) : void
      {
         this._Deleted = param1;
      }
      
      public function set Status(param1:int) : void
      {
         this._Status = param1;
      }
      
      public function set FameEarned(param1:int) : void
      {
         this._FameEarned = param1;
      }
      
      public function set Price(param1:int) : void
      {
         this._Price = param1;
      }
      
      public function set Vip(param1:int) : void
      {
         this._Vip = param1;
      }
      
      public function set DiamondsPrice(param1:int) : void
      {
         this._DiamondsPrice = param1;
      }
      
      public function get DataObject() : Object
      {
         if(this.compressed)
         {
            try
            {
               this.Data.uncompress();
            }
            catch(e:Error)
            {
            }
            this.compressed = false;
         }
         return SerializeUtils.deserialize(this.Data);
      }
      
      public function isVip() : Boolean
      {
         return this._Vip > 0;
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
   }
}

