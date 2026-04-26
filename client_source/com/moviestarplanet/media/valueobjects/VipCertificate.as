package com.moviestarplanet.media.valueobjects
{
   import com.moviestarplanet.model.friends.IContentActorInfo;
   import com.moviestarplanet.unifiedui.IContentBrowserContent;
   import com.moviestarplanet.utils.GiftCategories;
   
   public class VipCertificate implements IContentBrowserContent
   {
      
      public var Id:int;
      
      public var DurationInDays:int;
      
      public var FinalizedAt:Date;
      
      public var CreatedAt:Date;
      
      public var GiftedAt:Date;
      
      public var Giver:IContentActorInfo;
      
      public var Receiver:IContentActorInfo;
      
      public var Status:int;
      
      public var Message:String;
      
      public var WrappingColor:String;
      
      public var PurchaseType:GiftPurchaseType;
      
      public function VipCertificate()
      {
         super();
      }
      
      public function get getName() : String
      {
         return "";
      }
      
      public function get getVIP() : int
      {
         return 0;
      }
      
      public function get getDiamondPrice() : int
      {
         return 0;
      }
      
      public function get id() : int
      {
         return this.Id;
      }
      
      public function get ContentId() : String
      {
         return this.PurchaseType.ContentId;
      }
      
      public function get giftType() : int
      {
         return GiftCategories.vip_certificate;
      }
   }
}

