package com.moviestarplanet.shopping
{
   import com.moviestarplanet.Module.IFlashModule;
   
   public interface IShoppingModule extends IFlashModule
   {
      
      function openPetShop(param1:String) : void;
      
      function openClothesShopLook(param1:*) : void;
      
      function openClothesShopId(param1:int) : void;
      
      function openItemsShop(param1:String) : void;
      
      function openBackgroundShop(param1:* = null) : void;
      
      function openClothesShop(param1:String, param2:int = -1) : void;
      
      function openBeautyClinic() : void;
      
      function clearCache() : void;
   }
}

