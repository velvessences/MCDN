package com.moviestarplanet.shopping.module
{
   import com.moviestarplanet.Module.ModuleInterface;
   import com.moviestarplanet.highscore.valueobjects.ClothHighscore;
   import com.moviestarplanet.look.valueobjects.LookItem;
   
   public interface IShoppingModuleInfo extends ModuleInterface
   {
      
      function openDiamondShop(param1:String = null) : void;
      
      function openAnimationShop() : void;
      
      function openItemShop(param1:ClothHighscore) : void;
      
      function openClothesShop(param1:LookItem, param2:int) : void;
      
      function clearShopContentCache() : void;
   }
}

