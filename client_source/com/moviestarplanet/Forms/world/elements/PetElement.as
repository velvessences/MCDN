package com.moviestarplanet.Forms.world.elements
{
   import com.moviestarplanet.Components.ClickItemShop;
   import com.moviestarplanet.bonster.service.BonsterShopSwitch;
   import com.moviestarplanet.pets.hotel.PetHotel;
   import com.moviestarplanet.shopping.ShoppingModuleManager;
   import com.moviestarplanet.utils.ui.AdHandler;
   
   public class PetElement extends BaseWorldElement
   {
      
      private static var _allItems:Array = [];
      
      public static const PETPETS:PetElement = new PetElement("WEB_BONSTER_SHOP_NAME","petPets");
      
      public static const PETHOTEL:PetElement = new PetElement("PETHOTEL","petHotel");
      
      public static const BOONIES:PetElement = new PetElement("DYNTXT_LAYOUT_BUTTONS_BOONIES","boonies");
      
      public static const ACCESSORIES:PetElement = new PetElement("DYNTXT_LAYOUT_BUTTONS_PETSACCESSORIES","PetItems");
      
      public static const ZOO:PetElement = new PetElement("DYNTXT_ZOO","zoo");
      
      public static const PETREDEEM:PetElement = new PetElement("MAGAZINECORNER_TITLE","petredeem");
      
      public function PetElement(param1:String, param2:String)
      {
         _allItems.push(this);
         super(param1,param2);
      }
      
      public static function get allItems() : Array
      {
         return _allItems;
      }
      
      override public function enter() : void
      {
         switch(this)
         {
            case PETPETS:
               if(BonsterShopSwitch.IsShopSwitchOn)
               {
                  ShoppingModuleManager.getInstance().openPetShop(ShoppingModuleManager.PETSHOP_GOTO_CATEGORY_PETS);
                  break;
               }
               ClickItemShop.getInstance().enterClickItemShop(2,mspLocaleManager.getString("SHOP",["PetPets"]));
               break;
            case PETHOTEL:
               PetHotel.showPetHotel();
               break;
            case ZOO:
               ShoppingModuleManager.getInstance().openItemsShop(ShoppingModuleManager.ITEMSSHOP_GOTO_CATEGORY_ANIMAL);
               break;
            case BOONIES:
               if(BonsterShopSwitch.IsShopSwitchOn)
               {
                  ShoppingModuleManager.getInstance().openPetShop(ShoppingModuleManager.PETSHOP_GOTO_CATEGORY_BOONIES);
                  break;
               }
               ClickItemShop.getInstance().enterClickItemShop(1,mspLocaleManager.getString("SHOP",["Boonie"]));
               break;
            case ACCESSORIES:
               ShoppingModuleManager.getInstance().openItemsShop(ShoppingModuleManager.ITEMSSHOP_GOTO_CATEGORY_PETACC);
               break;
            case PETREDEEM:
               AdHandler.Instance.openAd(AdHandler.MAGAZINEAD);
         }
      }
   }
}

