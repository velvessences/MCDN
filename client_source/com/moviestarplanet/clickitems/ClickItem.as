package com.moviestarplanet.clickitems
{
   import com.moviestarplanet.chat.IChatRoomPet;
   import com.moviestarplanet.pet.valueobjects.ActorClickItemRel;
   import com.moviestarplanet.utils.loader.FlippableLoader;
   import flash.events.Event;
   
   public class ClickItem extends FlippableLoader implements IChatRoomPet
   {
      
      public static const E_SWFLOADED:String = "E_SWFLOADED";
      
      public var enableRandomization:Boolean = false;
      
      public var Price:int = 0;
      
      protected var _isLoaded:Boolean;
      
      private var _clickItemData:ActorClickItemRel;
      
      public const PET_PRICE:int = 1000;
      
      public const PLANT_PRICE:int = 500;
      
      public var FOODPOINT:int = 1;
      
      public var FOODPRICE:int = 10;
      
      public var MEDICINPRICE:int = 20;
      
      public var MEDICINPRICE2:int = 300;
      
      public var VIPFOODPOINTS:int = 2;
      
      public var FOODPOINT_SICK_LEVEL:int = -2;
      
      public var FOODPOINTS_PER_STAGE:int = 9;
      
      public var IS_PLANT:Boolean = false;
      
      public var MAX_FEEDING_INTERVAL_MS:int = 86400000;
      
      public var MIN_FEEDING_INTERVAL_MS:int = 28800000;
      
      public var STYLESHEET:String = "creamOverlay";
      
      public function ClickItem(param1:ActorClickItemRel)
      {
         super(false);
         this._clickItemData = param1;
         x = param1.x;
         y = param1.y;
         originalScale = 1;
      }
      
      public static function isClickItemPlant(param1:ActorClickItemRel) : Boolean
      {
         return ClickItemFactoryImpl.isClickItemPlant(param1);
      }
      
      public static function create(param1:ActorClickItemRel) : ClickItem
      {
         return ClickItemFactory.create(param1) as ClickItem;
      }
      
      public function get chatRoomPetId() : String
      {
         return this._clickItemData.ActorClickItemRelId.toString();
      }
      
      public function get clickItemData() : ActorClickItemRel
      {
         return this._clickItemData;
      }
      
      public function set clickItemData(param1:ActorClickItemRel) : void
      {
         if(param1.ActorClickItemRelId == this.clickItemData.ActorClickItemRelId)
         {
            this._clickItemData = param1;
            return;
         }
         throw new Error("Attempt to replace ClickItemData with another ClickItem: from " + this.clickItemData.ActorClickItemRelId + " to " + param1.ActorClickItemRelId);
      }
      
      public function get isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      public function get swf() : String
      {
         return ClickItemCatalog.itemAt(this.clickItemData.ClickItemId).SWF;
      }
      
      public function get clickItemId() : Number
      {
         return this.clickItemData.ClickItemId;
      }
      
      public function loadClickItemSwf(param1:Function = null) : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function set allowPopup(param1:Boolean) : void
      {
      }
      
      public function click(param1:Event = null) : void
      {
      }
      
      public function get yOffSet() : int
      {
         return 0;
      }
      
      override public function destroy() : void
      {
         this._clickItemData = null;
         super.destroy();
      }
   }
}

