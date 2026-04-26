package com.moviestarplanet.services.spendingservice.valueObjects
{
   public class SpecialsItem
   {
      
      public static const FAME_WHEEL:String = "FAME_WHEEL";
      
      public static const DIAMOND_TWIT:String = "DIAMOND_TWIT";
      
      public static const SHOPPING_SPREE:String = "SHOPPING_SPREE";
      
      public static const FAME_BOOSTER:String = "FAME_BOOSTER";
      
      public static const INSTANT_PET_GROW:String = "INSTANT_PET_GROW";
      
      public static const DIAMOND_CHARACTER_EFFECT:String = "DIAMOND_CHARACTER_EFFECT";
      
      public static const CHARACTER_POPUP:String = "CHARACTER_POPUP";
      
      public static const CHANGE_PET:String = "CHANGE_PET";
      
      public static const SPECIAL_GREETING:String = "SPECIAL_GREETING";
      
      public static const STARCOIN_SHOOTER:String = "STARCOIN_SHOOTER";
      
      public var SpecialsItemId:int;
      
      public var Identifier:String;
      
      public var InternalName:String;
      
      public var DiamondsPrice:int;
      
      public var NameResourceId:String;
      
      public var TitleResourceId:String;
      
      public var DescriptionResourceId:String;
      
      public var ButtonTextResourceId:String;
      
      public var IconVisual:String;
      
      public var FullSizeVisual:String;
      
      public var IsShopItem:int;
      
      public var Requirements:String;
      
      private var _renderer:Object;
      
      public function SpecialsItem(param1:Object)
      {
         super();
         this.SpecialsItemId = param1.SpecialsItemId as int;
         this.Identifier = param1.Identifier as String;
         this.InternalName = param1.InternalName as String;
         this.DiamondsPrice = param1.DiamondsPrice as int;
         this.NameResourceId = param1.NameResourceId as String;
         this.TitleResourceId = param1.TitleResourceId as String;
         this.DescriptionResourceId = param1.DescriptionResourceId as String;
         this.ButtonTextResourceId = param1.ButtonTextResourceId as String;
         this.IconVisual = param1.IconVisual as String;
         this.FullSizeVisual = param1.FullSizeVisual as String;
         this.IsShopItem = param1.IsShopItem as int;
         this.Requirements = param1.Requirements as String;
      }
      
      public function set renderer(param1:Object) : void
      {
         this._renderer = param1;
      }
      
      public function get renderer() : Object
      {
         return this._renderer;
      }
   }
}

