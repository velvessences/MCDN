package com.moviestarplanet.media.valueobjects
{
   import com.moviestarplanet.unifiedui.IContentBrowserContent;
   import com.moviestarplanet.utils.GiftCategories;
   
   public class Animation extends Media implements IContentBrowserContent
   {
      
      public var AnimationId:int;
      
      public var FrameLabel:String;
      
      public var AnimationCategoryId:int;
      
      public var LevelId:int;
      
      public var purchased:Boolean;
      
      public var AnimationCategory:com.moviestarplanet.media.valueobjects.AnimationCategory;
      
      public var LastUpdated:Date;
      
      public var IsLoop:Boolean;
      
      public var actorAnimationRelId:int = -1;
      
      public var GivenFreeToUsers:Boolean;
      
      public var DragonbonesCompatible:Boolean;
      
      private var _isGiftable:Boolean = true;
      
      public function Animation()
      {
         super();
      }
      
      public function get getName() : String
      {
         return Name;
      }
      
      public function get getVIP() : int
      {
         return Vip;
      }
      
      public function get getDiamondPrice() : int
      {
         return DiamondsPrice;
      }
      
      public function get id() : int
      {
         return this.actorAnimationRelId;
      }
      
      public function get giftType() : int
      {
         return GiftCategories.animation;
      }
   }
}

