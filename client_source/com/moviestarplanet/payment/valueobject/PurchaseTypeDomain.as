package com.moviestarplanet.payment.valueobject
{
   import com.moviestarplanet.mangroveanalytics.constants.ItemTypeConst;
   import com.moviestarplanet.mangroveanalytics.context.moviestarplanet.ItemContextMSP;
   import com.moviestarplanet.utils.StringUtilities;
   import mx.collections.ArrayCollection;
   
   public class PurchaseTypeDomain
   {
      
      public var PurchaseTypeId:int;
      
      public var Name:String;
      
      public var ContentId:String;
      
      public var StarCoins:int;
      
      public var DaysVip:int;
      
      public var Diamonds:int;
      
      public var recurring:Boolean;
      
      public var VipTier:int;
      
      public var Items:ArrayCollection;
      
      public var Visuals:ArrayCollection;
      
      public var Currency:String;
      
      public var Cost:int;
      
      public var StandardCost:int;
      
      public var StandardCostApple:int;
      
      public var StandardCostGoogle:int;
      
      public var FullCost:int;
      
      public var DailyDiamonds:int;
      
      public var DailyStarcoins:int;
      
      public function PurchaseTypeDomain()
      {
         super();
      }
      
      public function parseObject(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:PurchaseItemDomain = null;
         var _loc5_:PurchaseVisualDomain = null;
         this.PurchaseTypeId = param1.PurchaseTypeId as int;
         this.Name = StringUtilities.trim(param1.Name as String);
         this.ContentId = StringUtilities.trim(param1.ContentId as String);
         this.StarCoins = param1.StarCoins as int;
         this.DaysVip = param1.DaysVip as int;
         this.Diamonds = param1.Diamonds as int;
         this.recurring = param1.recurring as Boolean;
         this.VipTier = param1.VipTier as int;
         this.Currency = StringUtilities.trim(param1.Currency as String);
         this.Cost = param1.Cost as int;
         this.StandardCost = param1.StandardCost as int;
         this.StandardCostApple = param1.StandardCostApple as int;
         this.StandardCostGoogle = param1.StandardCostGoogle as int;
         this.FullCost = param1.FullCost as int;
         this.DailyDiamonds = param1.DailyDiamonds as int;
         this.DailyStarcoins = param1.DailyStarcoins as int;
         this.Items = new ArrayCollection();
         for each(_loc2_ in param1.Items)
         {
            _loc4_ = new PurchaseItemDomain();
            _loc4_.parseObject(_loc2_);
            this.Items.addItem(_loc4_);
         }
         this.Visuals = new ArrayCollection();
         for each(_loc3_ in param1.Visuals)
         {
            _loc5_ = new PurchaseVisualDomain();
            _loc5_.parseObject(_loc3_);
            this.Visuals.addItem(_loc5_);
         }
      }
      
      public function getMangroveItemContexts() : Array
      {
         var _loc1_:int = 0;
         var _loc4_:PurchaseItemDomain = null;
         var _loc5_:String = null;
         var _loc2_:int = this.Items.length;
         var _loc3_:Array = new Array();
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.Items[_loc1_] as PurchaseItemDomain;
            switch(_loc4_.Type)
            {
               case "CLICKITEM":
                  _loc5_ = ItemTypeConst.ITEM;
                  break;
               case "BONSTER":
                  _loc5_ = ItemTypeConst.BONSTER;
                  break;
               default:
                  _loc5_ = this.checkItemOrCloth(_loc4_.CategoryId);
            }
            _loc3_.push(new ItemContextMSP(_loc4_.Id.toString(),_loc5_,true,_loc4_.Filename,_loc4_.CategoryId.toString()));
            _loc1_++;
         }
         return _loc3_;
      }
      
      private function checkItemOrCloth(param1:int) : String
      {
         if(param1 == 19 || param1 == 20 || param1 == 21 || param1 == 22 || param1 == 23 || param1 == 24 || param1 == 25 || param1 == 33 || param1 == 46 || param1 == 47)
         {
            return ItemTypeConst.ITEM;
         }
         return ItemTypeConst.CLOTHES;
      }
   }
}

