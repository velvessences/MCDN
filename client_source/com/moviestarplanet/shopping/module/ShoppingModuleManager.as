package com.moviestarplanet.shopping.module
{
   import com.moviestarplanet.Module.AbstractModuleManager;
   import com.moviestarplanet.Module.ModuleInterface;
   import com.moviestarplanet.highscore.valueobjects.ClothHighscore;
   import com.moviestarplanet.look.valueobjects.LookItem;
   
   public class ShoppingModuleManager extends AbstractModuleManager
   {
      
      private static var instance:ShoppingModuleManager;
      
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
      
      override protected function getLoadingThemeColor() : uint
      {
         return 0;
      }
      
      override protected function get moduleName() : String
      {
         return "ShoppingModule";
      }
      
      private function getShoppingModule(param1:Function) : void
      {
         var moduleComplete:Function;
         var callback:Function = param1;
         var module:ModuleInterface = getModule();
         if(module == null)
         {
            moduleComplete = function():void
            {
               callback(IShoppingModuleInfo(getModule()));
            };
            loadModule(moduleComplete);
         }
         else
         {
            callback(IShoppingModuleInfo(module));
         }
      }
      
      public function openDiamondShop(param1:String = null) : void
      {
         var moduleLoaded:Function = null;
         var Preview:String = param1;
         moduleLoaded = function(param1:IShoppingModuleInfo):void
         {
            param1.openDiamondShop(Preview);
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function openAnimationShop() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IShoppingModuleInfo):void
         {
            param1.openAnimationShop();
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function openItemShop(param1:ClothHighscore = null) : void
      {
         var moduleLoaded:Function = null;
         var item:ClothHighscore = param1;
         moduleLoaded = function(param1:IShoppingModuleInfo):void
         {
            param1.openItemShop(item);
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function openClothesShop(param1:LookItem = null, param2:int = 0) : void
      {
         var moduleLoaded:Function = null;
         var look:LookItem = param1;
         var clothesId:int = param2;
         moduleLoaded = function(param1:IShoppingModuleInfo):void
         {
            param1.openClothesShop(look,clothesId);
         };
         this.getShoppingModule(moduleLoaded);
      }
      
      public function clearShopContentCache() : void
      {
         var moduleLoaded:Function = null;
         moduleLoaded = function(param1:IShoppingModuleInfo):void
         {
            param1.clearShopContentCache();
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
