package com.moviestarplanet.design.valueobjects
{
   import com.moviestarplanet.design.DesignForSale;
   import com.moviestarplanet.events.MsgEvent;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.utils.DateUtils;
   import flash.events.EventDispatcher;
   
   public class DesignListItem extends EventDispatcher
   {
      
      public static const STATUS_DESIGNED:int = 0;
      
      public static const STATUS_PRODUCED:int = 1;
      
      public static const STATUS_CANCELED:int = 2;
      
      public static const STATUS_SELLING:int = 3;
      
      public static const STATUS_SOLD_OUT:int = 4;
      
      public var DesignId:int;
      
      public var ActorId:int;
      
      public var ActorName:String;
      
      public var ActorMemberTimeout:Date;
      
      public var OwnerId:int;
      
      public var OwnerName:String;
      
      public var OwnerMemberTimeout:Date;
      
      public var ActorClothesRelId:int;
      
      public var ClothesId:int;
      
      public var Created:Date;
      
      public var Name:String;
      
      public var Likes:int;
      
      public var Deleted:int;
      
      public var Status:int;
      
      public var FameEarned:int;
      
      public var Price:int;
      
      public var Vip:int;
      
      public var DiamondsPrice:int;
      
      public var AmountForSale:int;
      
      public var DateForSale:Date;
      
      public var OriginalActorClothesRelId:int;
      
      public var SkinId:int;
      
      public var ClothesCategoryId:int;
      
      private var _rank:int;
      
      public function DesignListItem()
      {
         super();
      }
      
      public function get ActorVip() : Boolean
      {
         return this.ActorMemberTimeout.getTime() > DateUtils.serverNow.getTime();
      }
      
      public function get OwnerVip() : Boolean
      {
         return this.OwnerMemberTimeout.getTime() > DateUtils.serverNow.getTime();
      }
      
      public function updateLikes() : void
      {
         dispatchEvent(new MsgEvent("DesignerBrowserEvent.LOVE_IT_RESPONSE"));
      }
      
      public function get Rank() : int
      {
         return this._rank;
      }
      
      public function set Rank(param1:int) : void
      {
         this._rank = param1;
      }
      
      public function get filteredName() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Name);
      }
      
      public function get starcoinPriceToBuy() : int
      {
         return DesignForSale.getStarcoinPriceToBuy(this.Price);
      }
      
      public function get diamondPriceToBuy() : int
      {
         return DesignForSale.getDiamondPriceToBuy(this.DiamondsPrice);
      }
      
      public function get famePerSale() : int
      {
         return int(this.Price * DesignForSale.FAME_PER_SC + this.DiamondsPrice * DesignForSale.FAME_PER_DIAMOND);
      }
   }
}

