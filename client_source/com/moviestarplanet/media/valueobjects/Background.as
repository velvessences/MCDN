package com.moviestarplanet.media.valueobjects
{
   import com.moviestarplanet.unifiedui.IContentBrowserContent;
   import com.moviestarplanet.utils.GiftCategories;
   
   public class Background extends Media implements IContentBrowserContent
   {
      
      public var BackgroundId:int;
      
      public var BackgroundCategoryId:int;
      
      public var url:String;
      
      public var BackgroundCategory:com.moviestarplanet.media.valueobjects.BackgroundCategory;
      
      public var TagId:Number;
      
      public var LastUpdated:Date;
      
      public var actorBackgroundRelId:int = -1;
      
      private var _isGiftable:Boolean = true;
      
      public function Background()
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
         return this.actorBackgroundRelId;
      }
      
      public function get giftType() : int
      {
         return GiftCategories.background;
      }
      
      public function set Url(param1:String) : void
      {
         this.url = param1;
      }
   }
}

