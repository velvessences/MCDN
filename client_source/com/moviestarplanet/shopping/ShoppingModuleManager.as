package com.moviestarplanet.shopping
{
   import com.moviestarplanet.Module.AbstractFlashModuleManager;
   import com.moviestarplanet.Module.IFlashModule;
   import com.moviestarplanet.look.valueobjects.LookItem;
   import com.moviestarplanet.media.valueobjects.Background;
   
   public class ShoppingModuleManager extends AbstractFlashModuleManager
   {
      
      private static var instance:ShoppingModuleManager;
      
      public static const PETSHOP_GOTO_DEFAULT_TAB:String = "PETSHOP_GOTO_DEFAULT_TAB";
      
      public static const PETSHOP_GOTO_CATEGORY_PETS:String = "PETSHOP_GOTO_CATEGORY_PETS";
      
      public static const PETSHOP_GOTO_CATEGORY_BOONIES:String = "PETSHOP_GOTO_CATEGORY_BOONIES";
      
      public static const CLOTHESSHOP_GOTO_DEFAULT_TAB:String = "CLOTHESSHOP_GOTO_DEFAULT_TAB";
      
      public static const ITEMSSHOP_GOTO_CATEGORY_ANIMAL:String = "ITEMSSHOP_GOTO_CATEGORY_ANIMAL";
      
      public static const ITEMSSHOP_GOTO_CATEGORY_PETACC:String = "ITEMSSHOP_GOTO_CATEGORY_PETACC";
      
      public function ShoppingModuleManager(param1:SingletonEnforcer)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : ShoppingModuleManager
      {
         if(instance == null)
         {
            instance = new ShoppingModuleManager(new SingletonEnforcer());
         }
         return instance;
      }
      
      override protected function get moduleName() : String
      {
         return "ShoppingModule(e)";
      }
      
      private function getShoppingModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:IFlashModule = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               callback(IShoppingModule(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IShoppingModule(module));
         }
      }
      
      public function openPetShop(param1:String) : void
      {
         var moduleLoaded:Function = null;
         var tabToVisit:String = param1;
         moduleLoaded = function(param1:IShoppingModule):void
         {
            param1.openPetShop(tabToVisit);
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function openItemsShop(param1:String = "CLOTHESSHOP_GOTO_DEFAULT_TAB") : void
      {
         var moduleLoaded:Function = null;
         var tabToVisit:String = param1;
         moduleLoaded = function(param1:IShoppingModule):void
         {
            param1.openItemsShop(tabToVisit);
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function openBackgroundShop(param1:Background = null) : void
      {
         var moduleLoaded:Function = null;
         var background:Background = param1;
         moduleLoaded = function(param1:IShoppingModule):void
         {
            param1.openBackgroundShop(background);
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function openClothesShop(param1:String = "CLOTHESSHOP_GOTO_DEFAULT_TAB", param2:int = -1) : void
      {
         var moduleLoaded:Function = null;
         var tabToVisit:String = param1;
         var shoppingFriendId:int = param2;
         moduleLoaded = function(param1:IShoppingModule):void
         {
            param1.openClothesShop(tabToVisit,shoppingFriendId);
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function openClothesShopLook(param1:LookItem) : void
      {
         var moduleLoaded:Function = null;
         var look:LookItem = param1;
         moduleLoaded = function(param1:IShoppingModule):void
         {
            param1.openClothesShopLook(look);
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function openClothesShopCloth(param1:int) : void
      {
         var moduleLoaded:Function = null;
         var clothId:int = param1;
         moduleLoaded = function(param1:IShoppingModule):void
         {
            param1.openClothesShopId(clothId);
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function openBeautyClinic() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IShoppingModule):void
         {
            param1.openBeautyClinic();
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function clearCache() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IShoppingModule):void
         {
            param1.clearCache();
         };
         this.getShoppingModule(moduleLoaded);
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
