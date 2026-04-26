package com.moviestarplanet.clothesutils
{
   import com.moviestarplanet.constants.artbook.ConstantsArtBookItemCategory;
   
   public class ClothIdentifier
   {
      
      private static const itemShopIds:Array = new Array(900,2001,2002,2003,2004,2005,2006);
      
      public function ClothIdentifier()
      {
         super();
      }
      
      public static function IsClothes(param1:int) : Boolean
      {
         return param1 <= 15 || param1 >= 25 && param1 != 33 && param1 != 46;
      }
      
      public static function IsItem(param1:int) : Boolean
      {
         return itemShopIds.indexOf(param1) != -1;
      }
      
      public static function IsItemFromCategory(param1:int) : Boolean
      {
         return !IsClothes(param1);
      }
      
      public static function getShopIdByShopCategory(param1:int) : int
      {
         switch(param1)
         {
            case ConstantsArtBookItemCategory.ITEMS_PROPS:
               return 2006;
            case ConstantsArtBookItemCategory.ITEMS_FURNITURE:
               return 2005;
            case ConstantsArtBookItemCategory.ITEMS_GADGETS:
               return 2004;
            case ConstantsArtBookItemCategory.ITEMS_VEHICLES:
               return 2003;
            case ConstantsArtBookItemCategory.ITEMS_FOOD:
               return 2002;
            case ConstantsArtBookItemCategory.ITEMS_INSTRUMENTS:
               return 2001;
            case ConstantsArtBookItemCategory.ITEMS_GARDEN:
               return 900;
            case ConstantsArtBookItemCategory.ITEMS_ANIMALS:
               return 2000;
            default:
               return -1;
         }
      }
   }
}

