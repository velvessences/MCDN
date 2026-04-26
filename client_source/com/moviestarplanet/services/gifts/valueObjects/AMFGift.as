package com.moviestarplanet.services.gifts.valueObjects
{
   import com.moviestarplanet.actorutils.ClothInfoUtils;
   import com.moviestarplanet.injection.InjectionManager;
   import com.moviestarplanet.model.IActorModel;
   import com.moviestarplanet.model.friends.IContentActorInfo;
   import com.moviestarplanet.userbehavior.UserBehaviorMessageFormatter;
   import com.moviestarplanet.utils.GiftCategories;
   import com.moviestarplanet.utils.GiftState;
   
   public class AMFGift implements IGivable
   {
      
      public var Actor:IContentActorInfo;
      
      public var ActorAnimationRelId:int;
      
      public var ActorBackgroundRelId:int;
      
      public var ActorClothesRelId:int;
      
      public var ActorId:int;
      
      public var ActorName:String;
      
      public var AnimationId:int;
      
      public var BackgroundId:int;
      
      public var ClothesId:int;
      
      public var ClothesName:String;
      
      public var Color:String;
      
      public var DateOpened:Date;
      
      public var DateStr:String;
      
      public var DesignId:int;
      
      public var DiamondsPrice:int;
      
      public var GiftCategory:int;
      
      public var GiftId:int;
      
      public var GiftLogId:int;
      
      public var GiftType:int;
      
      public var Giver:IContentActorInfo;
      
      public var LinkedGiftId:int;
      
      public var Message:String;
      
      public var Price:int;
      
      public var ShopId:int;
      
      public var SpecialGreetingId:int;
      
      public var State:int;
      
      public var Vip:int;
      
      public var WrappingColor:String;
      
      private var _clothesCategoryId:int;
      
      private var _SWF:String;
      
      private var _fileName:String;
      
      private var _lastUpdated:Date;
      
      private var _colorScheme:String;
      
      public function AMFGift()
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
         return this.Actor != null ? this.Actor.getName : "";
      }
      
      public function get giverName() : String
      {
         return this.Giver != null ? this.Giver.getName : "";
      }
      
      public function get receiverActorId() : int
      {
         return this.Actor != null ? this.Actor.getActorId : -1;
      }
      
      public function get giverActorId() : int
      {
         return this.Giver != null ? this.Giver.getActorId : -1;
      }
      
      public function get vip() : Boolean
      {
         return this.Vip > 0;
      }
      
      public function get filteredMessage() : String
      {
         return UserBehaviorMessageFormatter.getInstance().getFilteredMessageFromEmbeddedString(this.Message);
      }
      
      public function get path() : String
      {
         var _loc2_:String = null;
         var _loc3_:IActorModel = null;
         var _loc4_:int = 0;
         var _loc1_:String = "gifts/medium/";
         if(this.State == GiftState.WAITING)
         {
            if(this.SWF != null && this.SWF.length > 0)
            {
               return _loc1_ + this.SWF;
            }
            _loc4_ = Math.random() * 5 + 1;
            return _loc1_ + "Gift_item_" + _loc4_ + ".swf";
         }
         switch(this.GiftCategory)
         {
            case GiftCategories.background:
               return this.ClothesId.toString();
            case GiftCategories.animation:
               _loc2_ = "m_";
               _loc3_ = InjectionManager.manager().getInstance(IActorModel);
               if(_loc3_.isFemale)
               {
                  _loc2_ = "f_";
               }
               return _loc2_ + this.SWF;
            default:
               return ClothInfoUtils.getPath(this);
         }
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
         return false;
      }
      
      public function get LastUpdated() : Date
      {
         return this._lastUpdated;
      }
      
      public function set LastUpdated(param1:Date) : void
      {
         this._lastUpdated = param1;
      }
      
      public function set SWF(param1:String) : void
      {
         this._SWF = param1;
      }
      
      public function get SWF() : String
      {
         return this._SWF;
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
         return this._fileName;
      }
      
      public function set Filename(param1:String) : void
      {
         this._fileName = param1;
      }
   }
}

