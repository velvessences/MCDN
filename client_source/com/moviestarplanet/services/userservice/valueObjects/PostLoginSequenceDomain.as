package com.moviestarplanet.services.userservice.valueObjects
{
   import com.moviestarplanet.payment.timedOffer.*;
   import mx.collections.ArrayCollection;
   
   public class PostLoginSequenceDomain
   {
      
      public var ShowCampaign:Boolean;
      
      public var ShowVipRebuy:Boolean;
      
      public var ShowFameLevelConvert:Boolean;
      
      public var DailyBonusType:int;
      
      public var AnchorFriendshipAccepted:Boolean;
      
      public var AnchorGiftsGiven:int;
      
      public var Features:ArrayCollection;
      
      public function PostLoginSequenceDomain()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : PostLoginSequenceDomain
      {
         var _loc2_:PostLoginSequenceDomain = new PostLoginSequenceDomain();
         _loc2_.ShowCampaign = param1.ShowCampaign;
         _loc2_.ShowVipRebuy = param1.ShowVipRebuy;
         _loc2_.ShowFameLevelConvert = param1.ShowFameLevelConvert;
         _loc2_.DailyBonusType = param1.DailyBonusType;
         _loc2_.AnchorFriendshipAccepted = param1.AnchorFriendshipAccepted;
         _loc2_.AnchorGiftsGiven = param1.AnchorGiftsGiven;
         _loc2_.Features = param1.Features;
         SpecialOffer.setOfferFromObject(param1.SpecialOffer);
         return _loc2_;
      }
   }
}

